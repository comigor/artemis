import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import './generator/ephemeral_data.dart';
import './generator/data.dart';
import './generator/graphql_helpers.dart' as gql;
import './generator/helpers.dart';
import './schema/options.dart';
import 'visitor.dart';

typedef _OnNewClassFoundCallback = void Function(Context context);

void _log(Object log, [int align = 2]) {
  print('${List.filled(align, ' ').join()}${log.toString()}');
}

/// Enum value for values not mapped in the GraphQL enum
const ARTEMIS_UNKNOWN = 'ARTEMIS_UNKNOWN';

/// Generate queries definitions from a GraphQL schema and a list of queries,
/// given Artemis options and schema mappings.
LibraryDefinition generateLibrary(
  String path,
  List<DocumentNode> gqlDocs,
  GeneratorOptions options,
  SchemaMap schemaMap,
  List<FragmentDefinitionNode> fragmentDefinitionNode,
  DocumentNode schema,
) {
  final queriesDefinitions = gqlDocs
      .map((doc) => generateQuery(
            schema,
            path,
            doc,
            options,
            schemaMap,
            fragmentDefinitionNode,
          ))
      .toList();

  final allClassesNames = queriesDefinitions.fold<Iterable<String>>(
      [], (defs, def) => defs.followedBy(def.classes.map((c) => c.name)));

  allClassesNames.mergeDuplicatesBy((a) => a, (a, b) {
    _log(queriesDefinitions);

    throw Exception('''Two classes were generated with the same name `$a`!
You may want to:
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a field of type `$a` is requested
- File a bug on artemis (https://is.gd/YLSfC2)''');
  });

  final basename = p.basenameWithoutExtension(path);

  final customImports = _extractCustomImports(schema, options);
  return LibraryDefinition(
    basename: basename,
    queries: queriesDefinitions,
    customImports: customImports,
  );
}

Set<FragmentDefinitionNode> _extractFragments(SelectionSetNode selectionSet,
    List<FragmentDefinitionNode> fragmentsCommon) {
  final result = <FragmentDefinitionNode>{};
  if (selectionSet != null) {
    selectionSet.selections.whereType<FieldNode>().forEach((selection) {
      result.addAll(_extractFragments(selection.selectionSet, fragmentsCommon));
    });
    selectionSet.selections
        .whereType<FragmentSpreadNode>()
        .forEach((selection) {
      final fragmentDefinitions = fragmentsCommon.firstWhere(
          (fragmentDefinition) =>
              fragmentDefinition.name.value == selection.name.value);
      result.add(fragmentDefinitions);
      result.addAll(
          _extractFragments(fragmentDefinitions.selectionSet, fragmentsCommon));
    });
  }
  return result;
}

/// Generate a query definition from a GraphQL schema and a query, given
/// Artemis options and schema mappings.
QueryDefinition generateQuery(
  DocumentNode schema,
  String path,
  DocumentNode document,
  GeneratorOptions options,
  SchemaMap schemaMap,
  List<FragmentDefinitionNode> fragmentsCommon,
) {
  final operation =
      document.definitions.whereType<OperationDefinitionNode>().first;

  final fragments = <FragmentDefinitionNode>[];

  if (fragmentsCommon.isEmpty) {
    fragments.addAll(document.definitions.whereType<FragmentDefinitionNode>());
  } else {
    final fragmentsOperation =
        _extractFragments(operation.selectionSet, fragmentsCommon);
    document.definitions.addAll(fragmentsOperation);
    fragments.addAll(fragmentsOperation);
  }

  final basename = p.basenameWithoutExtension(path);
  final queryName = operation.name?.value ?? basename;
  final className = ReCase(queryName).pascalCase;

  final schemaVisitor = SchemaDefinitionVisitor();
  final objectVisitor = ObjectTypeDefinitionVisitor();

  schema.accept(schemaVisitor);
  schema.accept(objectVisitor);

  final suffix = operation.type == OperationType.query ? 'Query' : 'Mutation';
  final rootTypeName = (schemaVisitor.schemaDefinitionNode?.operationTypes ??
              [])
          .firstWhere((e) => e.operation == operation.type, orElse: () => null)
          ?.type
          ?.name
          ?.value ??
      suffix;

  if (rootTypeName == null) {
    throw Exception(
        '''No root type was found for ${operation.type} $queryName.''');
  }

  final TypeDefinitionNode parentType = objectVisitor.getByName(rootTypeName);

  final visitor = _GeneratorVisitor(
    context: Context(
      path: [className],
      currentType: parentType,
      generatedClasses: [],
      inputsClasses: [],
      fragments: fragments,
    ),
    options: InjectedOptions(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
    ),
  );
  document.accept(visitor);

  return QueryDefinition(
    queryName: queryName,
    queryType: '$className\$${parentType.name.value}',
    document: document,
    classes: visitor.context.generatedClasses,
    inputs: visitor.context.inputsClasses,
    generateHelpers: options.generateHelpers,
    suffix: suffix,
  );
}

List<String> _extractCustomImports(
  DocumentNode schema,
  GeneratorOptions options,
) {
  final typeVisitor = TypeDefinitionNodeVisitor();

  schema.accept(typeVisitor);

  return typeVisitor.types
      .map((TypeDefinitionNode type) {
        final scalarMap = gql.getSingleScalarMap(options, type.name.value);
        return scalarMap.dartType.imports
            .followedBy([scalarMap.customParserImport].where((c) => c != null));
      })
      .expand((i) => i)
      .toSet()
      .toList();
}

ClassProperty _createClassProperty({
  @required String fieldName,
  String fieldAlias,
  @required Context context,
  @required InjectedOptions options,
  _OnNewClassFoundCallback onNewClassFound,
}) {
  var finalFields = [];

  if (context.currentType is ObjectTypeDefinitionNode) {
    finalFields = (context.currentType as ObjectTypeDefinitionNode).fields;
  }

  if (context.currentType is InterfaceTypeDefinitionNode) {
    finalFields = (context.currentType as InterfaceTypeDefinitionNode).fields;
  }

  if (context.currentType is InputObjectTypeDefinitionNode) {
    finalFields = (context.currentType as InputObjectTypeDefinitionNode).fields;
  }

  final regularField = finalFields.firstWhere((f) => f.name.value == fieldName,
      orElse: () => null);

  final fieldType = regularField?.type;

  if (fieldType == null) {
    throw Exception(
        '''Field $fieldName was not found in GraphQL type ${context.currentType.name.value}.
Make sure your query is correct and your schema is updated.''');
  }
  final aliasAsClassName =
      fieldAlias != null ? ReCase(fieldAlias).pascalCase : null;

  final nextType = gql.getTypeByName(options.schema, fieldType as Node,
      context: 'field node');

  final nextClassName =
      context.joinedName(aliasAsClassName ?? nextType?.name?.value);

  final dartTypeStr = gql.buildTypeString(
      fieldType as TypeNode, options.options,
      dartType: true, replaceLeafWith: nextClassName, schema: options.schema);

  if ((nextType is ObjectTypeDefinitionNode ||
          nextType is InputObjectTypeDefinitionNode ||
          nextType is UnionTypeDefinitionNode ||
          nextType is InterfaceTypeDefinitionNode) &&
      onNewClassFound != null) {
    onNewClassFound(
      context.nextTypeWithSamePath(
        nextType: nextType,
        alias: aliasAsClassName,
      ),
    );
  }

  // On custom scalars
  String annotation;
  if (nextType is ScalarTypeDefinitionNode) {
    final scalar = gql.getSingleScalarMap(options.options, nextType.name.value);

    if (scalar.customParserImport != null &&
        nextType is ScalarTypeDefinitionNode &&
        nextType.name.value == scalar.graphQLType) {
      final graphqlTypeSafeStr = gql
          .buildTypeString(fieldType as TypeNode, options.options,
              dartType: false, schema: options.schema)
          .replaceAll(RegExp(r'[<>]'), '');
      final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
      annotation =
          'JsonKey(fromJson: fromGraphQL${dartTypeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
    }
  } // On enums
  else if (nextType is EnumTypeDefinitionNode) {
    _generateEnumForType(
      context.nextTypeWithSamePath(
        nextType: nextType,
        alias: aliasAsClassName,
      ),
      options,
    );
    if (fieldType is! ListTypeNode) {
      annotation = 'JsonKey(unknownEnumValue: $dartTypeStr.$ARTEMIS_UNKNOWN)';
    }
  }

  return ClassProperty(
    type: dartTypeStr,
    name: fieldAlias ?? fieldName,
    annotation: annotation,
    isNonNull: (fieldType as TypeNode).isNonNull,
  );
}

void _generateEnumForType(Context context, InjectedOptions options) {
  final enumType = context.currentType as EnumTypeDefinitionNode;

  final enumDefinition = EnumDefinition(
    name: enumType.name.value,
    values: enumType.values.map((eV) => eV.name.value).toList()
      ..add(ARTEMIS_UNKNOWN),
  );

  _log('<- Generated enum ${enumType.name.value}', 0);
  var duplicates = context.generatedClasses
      .where((element) => element.name == enumDefinition.name);

  if (duplicates.isEmpty) {
    context.generatedClasses.add(enumDefinition);
  }
}

class _GeneratorVisitor extends RecursiveVisitor {
  _GeneratorVisitor({
    @required this.context,
    @required this.options,
  });

  final Context context;
  final InjectedOptions options;

  SelectionSetNode selectionSetNode;
  final List<ClassProperty> _classProperties = [];
  final List<String> _mixins = [];

  @override
  void visitSelectionSetNode(SelectionSetNode node) {
    super.visitSelectionSetNode(node);

    final possibleTypes = <String, String>{};

    if (context.currentType is UnionTypeDefinitionNode ||
        context.currentType is InterfaceTypeDefinitionNode) {
      // Filter by requested types
      final keys = node.selections
          .whereType<InlineFragmentNode>()
          .map((n) => n.typeCondition.on.name.value);

      final values =
          keys.map((t) => context.sameTypeWithNextPath().joinedName(t));

      possibleTypes.addAll(Map.fromIterables(keys, values));
      _classProperties.add(ClassProperty(
        type: 'String',
        name: 'typeName',
        annotation: 'JsonKey(name: \'${options.schemaMap.typeNameField}\')',
        isOverride: true,
        isResolveType: true,
      ));
      _log('It is an union/interface of possible types $possibleTypes.');
    }

    final partOfUnion = context.ofUnion != null;
    if (partOfUnion) {
      _log('It is part of union ${context.ofUnion.name}.');
    }

    _log('<- Generated class ${context.joinedName()}.', 0);
    context.generatedClasses.add(ClassDefinition(
      name: context.joinedName(),
      properties: _classProperties,
      mixins: _mixins,
      extension: partOfUnion ? context.path.join(r'$') : null,
      factoryPossibilities: possibleTypes,
    ));
  }

  void _generateInputObjectClassesByType(Context context) {
    final properties = <ClassProperty>[];

    if (context.currentType is InputObjectTypeDefinitionNode) {
      properties.addAll((context.currentType as InputObjectTypeDefinitionNode)
          .fields
          .map((i) {
        return _createClassProperty(
          fieldName: i.name.value,
          context: context.sameTypeWithNextPath(),
          options: options,
          onNewClassFound: (nextContext) {
            _generateInputObjectClassesByType(nextContext);
          },
        );
      }));
    }

    _log('<- Generated input class ${context.currentType.name.value}.', 0);
    context.generatedClasses.add(ClassDefinition(
      name: context.currentType.name.value,
      properties: properties,
      isInput: true,
    ));
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final nextClassName = context.joinedName((node.type is ListTypeNode)
        ? null
        : (node.type as NamedTypeNode).name.value);

    final dartTypeStr = gql.buildTypeString(node.type, options.options,
        dartType: true, replaceLeafWith: nextClassName, schema: options.schema);

    context.inputsClasses.add(QueryInput(
      type: dartTypeStr,
      name: node.variable.name.value,
      isNonNull: node.type.isNonNull,
    ));

    _log('Found new input ${node.variable.name.value} (-> $dartTypeStr).');

    final leafType =
        gql.getTypeByName(options.schema, node.type, context: 'field node');

    if (leafType is TypeDefinitionNode) {
      final nextContext = context.nextTypeWithSamePath(nextType: leafType);

      if (leafType is ObjectTypeDefinitionNode ||
          leafType is InputObjectTypeDefinitionNode) {
        _generateInputObjectClassesByType(nextContext);
      } else if (leafType is EnumTypeDefinitionNode) {
        _generateEnumForType(nextContext, options);
      }
    }
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    context.fragments.add(node);
    final partName = '${ReCase(node.name.value).pascalCase}Mixin';

    final nextType = gql.getTypeByName(options.schema, node.typeCondition.on,
        context: 'fragment definition');

    final visitor = _GeneratorVisitor(
      context: context.next(
        nextType: nextType,
        inputsClasses: [],
        fragments: [],
      ),
      options: options,
    );

    node.selectionSet.visitChildren(visitor);

    final otherMixinsProps = context.generatedClasses
        .whereType<FragmentClassDefinition>()
        .where((def) => visitor._mixins.contains(def.name))
        .map((def) => def.properties)
        .expand((a) => a)
        .mergeDuplicatesBy((a) => a.name, (a, b) => a);

    _log('<- Generated mixin ${context.joinedName(partName)}', 0);
    context.generatedClasses.add(
      FragmentClassDefinition(
        name: context.joinedName(partName),
        properties:
            visitor._classProperties.followedBy(otherMixinsProps).toList(),
      ),
    );
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    final nextType = gql.getTypeByName(options.schema, node.typeCondition.on,
        context: 'inline fragment');

    _log(
        'Fragment spread on ${nextType.name.value} (context: ${context.path}).');

    final visitor = _GeneratorVisitor(
      context: context.next(
        nextType: nextType,
        ofUnion: context.currentType,
        inputsClasses: [],
        fragments: [],
      ),
      options: options,
    );

    node.visitChildren(visitor);
  }

  @override
  void visitFieldNode(FieldNode node) {
    final fieldName = node.name.value;
    if (fieldName == options.schemaMap.typeNameField) {
      return;
    }

    _log(
        'Visiting $fieldName ${node.alias?.value != null ? '(alias: ${node.alias.value})' : ''} on ${context.currentType.name.value} (context: ${context.path}).');

    final property = _createClassProperty(
      fieldName: fieldName,
      fieldAlias: node.alias?.value,
      context: context.sameTypeWithNextPath(),
      options: options,
      onNewClassFound: (nextContext) {
        node.visitChildren(_GeneratorVisitor(
          context: nextContext,
          options: options,
        ));
      },
    );
    _classProperties.add(property);
  }

  @override
  void visitFragmentSpreadNode(FragmentSpreadNode node) {
    final fragmentName = context
        .sameTypeWithFirstPath()
        .joinedName('${ReCase(node.name.value).pascalCase}Mixin');
    _log(
        'Spreading fragment $fragmentName into GraphQL type ${context.currentType.name.value} (context: ${context.path}).');
    _mixins.add(fragmentName);
  }
}
