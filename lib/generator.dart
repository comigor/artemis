import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import './generator/ephemeral_data.dart';
import './generator/data.dart';
import './generator/errors.dart';
import './generator/graphql_helpers.dart' as gql;
import './generator/helpers.dart';
import './schema/options.dart';
import 'visitor.dart';

typedef _OnNewClassFoundCallback = void Function(Context context);

void _log(Context context, int align, Object logObject) {
  if (!context.log) return;
  log.fine('${List.filled(align, '|   ').join()}${logObject.toString()}');
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
  List<FragmentDefinitionNode> fragmentsCommon,
  DocumentNode schema,
) {
  final queriesDefinitions = gqlDocs
      .map((doc) => generateQuery(
            schema,
            path,
            doc,
            options,
            schemaMap,
            fragmentsCommon,
          ))
      .toList();

  final allClassesNames = queriesDefinitions
      .map((def) => def.classes.map((c) => c.name))
      .expand((e) => e)
      .toList();

  allClassesNames.mergeDuplicatesBy((a) => a, (a, b) {
    throw DuplicatedClassesException(allClassesNames, a);
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
        .whereType<InlineFragmentNode>()
        .forEach((selection) {
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

  final documentFragments =
      document.definitions.whereType<FragmentDefinitionNode>();

  if (documentFragments.isNotEmpty && fragmentsCommon.isNotEmpty) {
    throw FragmentIgnoreException();
  }

  if (fragmentsCommon.isEmpty) {
    fragments.addAll(documentFragments);
  } else {
    final fragmentsOperation =
        _extractFragments(operation.selectionSet, fragmentsCommon);
    document.definitions.addAll(fragmentsOperation);
    fragments.addAll(fragmentsOperation);
  }

  final basename = p.basenameWithoutExtension(path).split('.').first;
  final queryName = operation.name?.value ?? basename;
  final className = ReCase(queryName).pascalCase;

  final schemaVisitor = SchemaDefinitionVisitor();
  final objectVisitor = ObjectTypeDefinitionVisitor();

  schema.accept(schemaVisitor);
  schema.accept(objectVisitor);

  String suffix;
  switch (operation.type) {
    case OperationType.subscription:
      suffix = 'Subscription';
      break;
    case OperationType.mutation:
      suffix = 'Mutation';
      break;
    case OperationType.query:
    default:
      suffix = 'Query';
      break;
  }

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

  final context = Context(
    schema: schema,
    options: options,
    schemaMap: schemaMap,
    path: [className, parentType.name.value],
    currentType: parentType,
    currentFieldName: null,
    currentClassName: null,
    generatedClasses: [],
    inputsClasses: [],
    fragments: fragments,
    usedEnums: {},
    usedInputObjects: {},
  );

  final visitor = _GeneratorVisitor(
    context: context,
  );
  final canonicalVisitor = _CanonicalVisitor(
    context: context.sameTypeWithNoPath(),
  );

  document.accept(visitor);
  schema.accept(canonicalVisitor);

  return QueryDefinition(
    queryName: queryName,
    queryType: createJoinedName(
        [className, parentType.name.value], schemaMap.namingScheme),
    document: document,
    classes: [
      ...canonicalVisitor.enums
          .where((e) => context.usedEnums.contains(e.name)),
      ...visitor.context.generatedClasses,
      ...canonicalVisitor.inputObjects
          .where((i) => context.usedInputObjects.contains(i.name)),
    ],
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
  _OnNewClassFoundCallback onNewClassFound,
  bool markAsUsed = true,
}) {
  var finalFields = <Node>[];

  if (context.currentType is ObjectTypeDefinitionNode) {
    finalFields = (context.currentType as ObjectTypeDefinitionNode).fields;
  } else if (context.currentType is InterfaceTypeDefinitionNode) {
    finalFields = (context.currentType as InterfaceTypeDefinitionNode).fields;
  } else if (context.currentType is InputObjectTypeDefinitionNode) {
    finalFields = (context.currentType as InputObjectTypeDefinitionNode).fields;
  }

  final regularField = finalFields
      .whereType<FieldDefinitionNode>()
      .firstWhere((f) => f.name.value == fieldName, orElse: () => null);
  final regularInputField = finalFields
      .whereType<InputValueDefinitionNode>()
      .firstWhere((f) => f.name.value == fieldName, orElse: () => null);

  final fieldType = regularField?.type ?? regularInputField?.type;

  if (fieldType == null) {
    throw Exception(
        '''Field $fieldName was not found in GraphQL type ${context.currentType?.name?.value}.
Make sure your query is correct and your schema is updated.''');
  }
  final aliasAsClassName =
      fieldAlias != null ? ReCase(fieldAlias).pascalCase : null;

  final nextType =
      gql.getTypeByName(context.schema, fieldType, context: 'field node');

  final aliasedContext = context.withAlias(
    nextFieldName: fieldName,
    nextClassName: nextType.name.value,
    alias: fieldAlias,
  );

  final nextClassName = aliasedContext.joinedName();

  final dartTypeStr = gql.buildTypeString(fieldType, context.options,
      dartType: true, replaceLeafWith: nextClassName, schema: context.schema);

  _log(context, aliasedContext.align + 1,
      '${aliasedContext.path}[${aliasedContext.currentType.name.value}][${aliasedContext.currentClassName} ${aliasedContext.currentFieldName}] ${fieldAlias == null ? '' : '(${fieldAlias}) '}-> $dartTypeStr');

  if ((nextType is ObjectTypeDefinitionNode ||
          nextType is UnionTypeDefinitionNode ||
          nextType is InterfaceTypeDefinitionNode) &&
      onNewClassFound != null) {
    onNewClassFound(
      aliasedContext.next(
        nextType: nextType,
        nextFieldName:
            regularField?.name?.value ?? regularInputField?.name?.value,
        nextClassName: nextType.name.value,
        alias: aliasAsClassName,
      ),
    );
  }

  // On custom scalars
  String annotation;
  if (nextType is ScalarTypeDefinitionNode) {
    final scalar = gql.getSingleScalarMap(context.options, nextType.name.value);

    if (scalar.customParserImport != null &&
        nextType.name.value == scalar.graphQLType) {
      final graphqlTypeSafeStr = gql
          .buildTypeString(fieldType, context.options,
              dartType: false, schema: context.schema)
          .replaceAll(RegExp(r'[<>]'), '');
      final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
      annotation =
          'JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr,)';
    }
  } // On enums
  else if (nextType is EnumTypeDefinitionNode) {
    if (markAsUsed) {
      context.usedEnums.add(nextType.name.value);
    }

    if (fieldType is! ListTypeNode) {
      annotation = 'JsonKey(unknownEnumValue: $dartTypeStr.$ARTEMIS_UNKNOWN)';
    }
  }

  return ClassProperty(
    type: dartTypeStr,
    name: fieldAlias ?? fieldName,
    annotation: annotation,
    isNonNull: fieldType.isNonNull,
  );
}

class _GeneratorVisitor extends RecursiveVisitor {
  _GeneratorVisitor({
    @required this.context,
  });

  final Context context;

  SelectionSetNode selectionSetNode;
  final List<ClassProperty> _classProperties = [];
  final List<String> _mixins = [];

  @override
  void visitSelectionSetNode(SelectionSetNode node) {
    final nextContext = context.withAlias();

    _log(context, nextContext.align, '-> Class');
    _log(context, nextContext.align,
        '┌ ${nextContext.path}[${nextContext.currentType.name.value}][${nextContext.currentClassName} ${nextContext.currentFieldName}] (${nextContext.alias ?? ''})');
    super.visitSelectionSetNode(node);

    final possibleTypes = <String, String>{};

    if (nextContext.currentType is UnionTypeDefinitionNode ||
        nextContext.currentType is InterfaceTypeDefinitionNode) {
      // Filter by requested types
      final keys = node.selections
          .whereType<InlineFragmentNode>()
          .map((n) => n.typeCondition.on.name.value);

      final values =
          keys.map((t) => nextContext.withAlias(alias: t).joinedName());

      possibleTypes.addAll(Map.fromIterables(keys, values));
      _classProperties.add(ClassProperty(
        type: 'String',
        name: 'typeName',
        annotation: 'JsonKey(name: \'${nextContext.schemaMap.typeNameField}\')',
        isOverride: true,
        isResolveType: true,
      ));
    }

    final partOfUnion = nextContext.ofUnion != null;
    if (partOfUnion) {}

    _log(context, nextContext.align,
        '└ ${nextContext.path}[${nextContext.currentType.name.value}][${nextContext.currentClassName} ${nextContext.currentFieldName}] (${nextContext.alias ?? ''})');
    _log(context, nextContext.align,
        '<- Generated class ${nextContext.joinedName()}.');
    nextContext.generatedClasses.add(ClassDefinition(
      name: nextContext.joinedName(),
      properties: _classProperties,
      mixins: _mixins,
      extension: partOfUnion ? nextContext.rollbackPath().joinedName() : null,
      factoryPossibilities: possibleTypes,
    ));
  }

  @override
  void visitFieldNode(FieldNode node) {
    final fieldName = node.name.value;
    if (fieldName == context.schemaMap.typeNameField) {
      return;
    }

    final property = _createClassProperty(
      fieldName: fieldName,
      fieldAlias: node.alias?.value,
      context: context,
      onNewClassFound: (nextContext) {
        node.visitChildren(_GeneratorVisitor(
          context: nextContext,
        ));
      },
    );
    _classProperties.add(property);
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    _log(context, context.align + 1,
        '${context.path}: ... on ${node.typeCondition.on.name.value}');
    final nextType = gql.getTypeByName(context.schema, node.typeCondition.on,
        context: 'inline fragment');

    if (nextType.name.value == context.currentType.name.value) {
      final visitor = _GeneratorVisitor(
        context: context.nextTypeWithSamePath(
          nextType: nextType,
          nextClassName: null,
          nextFieldName: null,
          ofUnion: context.currentType,
          inputsClasses: [],
          fragments: [],
        ),
      );
      node.selectionSet.visitChildren(visitor);
    } else {
      final visitor = _GeneratorVisitor(
        context: context.next(
          nextType: nextType,
          nextClassName: nextType.name.value,
          nextFieldName: nextType.name.value,
          ofUnion: context.currentType,
          inputsClasses: [],
          fragments: [],
        ),
      );
      node.visitChildren(visitor);
    }
  }

  void addUsedInputObjectsAndEnums(InputObjectTypeDefinitionNode node) {
    context.usedInputObjects.add(node.name.value);

    for (final field in node.fields) {
      final type = gql.getTypeByName(context.schema, field.type);
      if (type is InputObjectTypeDefinitionNode) {
        addUsedInputObjectsAndEnums(type);
      } else if (type is EnumTypeDefinitionNode) {
        context.usedEnums.add(type.name.value);
      }
    }
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final leafType = gql.getTypeByName(context.schema, node.type,
        context: 'variable definition');

    final nextClassName = context
        .nextTypeWithNoPath(
          nextType: leafType,
          nextClassName: leafType.name.value,
          nextFieldName: node.variable.name.value,
        )
        .joinedName();

    final dartTypeStr = gql.buildTypeString(node.type, context.options,
        dartType: true, replaceLeafWith: nextClassName, schema: context.schema);

    String annotation;
    if (leafType is EnumTypeDefinitionNode) {
      context.usedEnums.add(leafType.name.value);
      if (leafType is! ListTypeNode) {
        annotation = 'JsonKey(unknownEnumValue: $dartTypeStr.$ARTEMIS_UNKNOWN)';
      }
    } else if (leafType is InputObjectTypeDefinitionNode) {
      addUsedInputObjectsAndEnums(leafType);
    } else if (leafType is ScalarTypeDefinitionNode) {
      final scalar =
          gql.getSingleScalarMap(context.options, leafType.name.value);

      if (scalar.customParserImport != null &&
          leafType.name.value == scalar.graphQLType) {
        final graphqlTypeSafeStr = gql
            .buildTypeString(node.type, context.options,
                dartType: false, schema: context.schema)
            .replaceAll(RegExp(r'[<>]'), '');
        final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
        annotation =
            'JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr,)';
      }
    }

    context.inputsClasses.add(QueryInput(
      type: dartTypeStr,
      name: node.variable.name.value,
      isNonNull: node.type.isNonNull,
      annotation: annotation,
    ));
  }

  @override
  void visitFragmentSpreadNode(FragmentSpreadNode node) {
    _log(context, context.align + 1,
        '${context.path}: ... expanding ${node.name.value}');
    final fragmentName = context
        .sameTypeWithNoPath(alias: '${ReCase(node.name.value).pascalCase}Mixin')
        .joinedName();

    final visitor = _GeneratorVisitor(
      context: context.sameTypeWithNextPath(
        alias: fragmentName,
        generatedClasses: [],
        log: false,
      ),
    );
    final fragmentDef = context.fragments.firstWhere(
        (fragment) => fragment.name.value == node.name.value,
        orElse: () => null);
    fragmentDef?.visitChildren(visitor);

    _mixins
      ..add(fragmentName)
      ..addAll(visitor._mixins);
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    final partName = '${ReCase(node.name.value).pascalCase}Mixin';
    final nextContext = context.sameTypeWithNoPath(alias: partName);

    _log(context, nextContext.align, '-> Fragment');
    _log(context, nextContext.align,
        '┌ ${nextContext.path}[${node.name.value}]');
    nextContext.fragments.add(node);

    final nextType = gql.getTypeByName(
        nextContext.schema, node.typeCondition.on,
        context: 'fragment definition');

    final visitorContext = Context(
      schema: context.schema,
      options: context.options,
      schemaMap: context.schemaMap,
      path: [nextContext.alias],
      currentType: nextType,
      currentFieldName: null,
      currentClassName: null,
      alias: nextContext.alias,
      generatedClasses: nextContext.generatedClasses,
      inputsClasses: [],
      fragments: [],
      usedEnums: nextContext.usedEnums,
      usedInputObjects: nextContext.usedInputObjects,
    );

    final visitor = _GeneratorVisitor(
      context: visitorContext,
    );

    node.selectionSet.visitChildren(visitor);

    final otherMixinsProps = nextContext.generatedClasses
        .whereType<FragmentClassDefinition>()
        .where((def) => visitor._mixins.contains(def.name))
        .map((def) => def.properties)
        .expand((a) => a)
        .mergeDuplicatesBy((a) => a.name, (a, b) => a);

    _log(context, nextContext.align,
        '└ ${nextContext.path}[${node.name.value}]');
    _log(context, nextContext.align,
        '<- Generated fragment ${nextContext.joinedName()}.');
    nextContext.generatedClasses.add(
      FragmentClassDefinition(
        name: nextContext.joinedName(),
        properties:
            visitor._classProperties.followedBy(otherMixinsProps).toList(),
      ),
    );
  }
}

class _CanonicalVisitor extends RecursiveVisitor {
  _CanonicalVisitor({
    @required this.context,
  });

  final Context context;
  final List<ClassDefinition> inputObjects = [];
  final List<EnumDefinition> enums = [];

  @override
  void visitEnumTypeDefinitionNode(EnumTypeDefinitionNode node) {
    final nextContext = context.sameTypeWithNoPath(alias: node.name.value);
    _log(context, nextContext.align, '-> Enum');
    _log(context, nextContext.align,
        '<- Generated enum ${nextContext.joinedName()}.');

    enums.add(EnumDefinition(
      name: nextContext.joinedName(),
      values: node.values.map((eV) => eV.name.value).toList()
        ..add(ARTEMIS_UNKNOWN),
    ));
  }

  @override
  void visitInputObjectTypeDefinitionNode(InputObjectTypeDefinitionNode node) {
    final nextContext = context.sameTypeWithNoPath(alias: node.name.value);

    _log(context, nextContext.align, '-> Input class');
    _log(context, nextContext.align,
        '┌ ${nextContext.path}[${node.name.value}]');
    final properties = <ClassProperty>[];

    properties.addAll(node.fields.map((i) {
      final nextType = gql.getTypeByName(nextContext.schema, i.type);
      return _createClassProperty(
        fieldName: i.name.value,
        context: nextContext.nextTypeWithNoPath(
          nextType: node,
          nextClassName: nextType.name.value,
          nextFieldName: i.name.value,
        ),
        markAsUsed: false,
      );
    }));

    _log(context, nextContext.align,
        '└ ${nextContext.path}[${node.name.value}]');
    _log(context, nextContext.align,
        '<- Generated input class ${nextContext.joinedName()}.');

    inputObjects.add(ClassDefinition(
      isInput: true,
      name: nextContext.joinedName(),
      properties: properties,
    ));
  }
}
