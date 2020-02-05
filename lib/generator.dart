import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import './generator/ephemeral_data.dart';
import './generator/data.dart';
import './generator/graphql_helpers.dart' as gql;
import './generator/helpers.dart';
import './schema/graphql.dart';
import './schema/options.dart';

typedef _OnNewClassFoundCallback = void Function(Context context);

void _log(Object log, [int align = 2]) {
  print('${List.filled(align, ' ').join()}${log.toString()}');
}

/// Enum value for values not mapped in the GraphQL enum
const ARTEMIS_UNKNOWN = 'ARTEMIS_UNKNOWN';

/// Generate queries definitions from a GraphQL schema and a list of queries,
/// given Artemis options and schema mappings.
LibraryDefinition generateLibrary(
  GraphQLSchema schema,
  String path,
  List<DocumentNode> gqlDocs,
  GeneratorOptions options,
  SchemaMap schemaMap,
  List<FragmentDefinitionNode> fragmenDefinitionNode,
) {
  final queriesDefinitions = gqlDocs
      .map((doc) => generateQuery(
          schema, path, doc, options, schemaMap, fragmenDefinitionNode))
      .toList();

  final allClassesNames = queriesDefinitions.fold<Iterable<String>>(
      [], (defs, def) => defs.followedBy(def.classes.map((c) => c.name)));

  mergeDuplicatesBy(allClassesNames, (a) => a, (a, b) {
    _log(queriesDefinitions);

    throw Exception('''Two classes were generated with the same name `$a`!
You may want to:
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a field of type `$a` is requested
- File a bug on artemis (https://is.gd/YLSfC2)''');
  });

  final basename = p.basenameWithoutExtension(path);
  final customImports = _extractCustomImports(schema.types, options);
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
      final fragmentDefinition = fragmentsCommon.firstWhere(
          (fragmentDifinition) =>
              fragmentDifinition.name.value == selection.name.value);
      result.add(fragmentDefinition);
      result.addAll(
          _extractFragments(fragmentDefinition.selectionSet, fragmentsCommon));
    });
  }
  return result;
}

GraphQLType _unwrapToType(GraphQLSchema schema, TypeNode node) {
  final isList = node is ListTypeNode;
  final leafNode =
      (isList ? (node as ListTypeNode).type : node) as NamedTypeNode;

  final type = gql.getTypeByName(schema, leafNode.name.value,
      context: 'query variables');

  if (isList) {
    return GraphQLType(kind: GraphQLTypeKind.LIST, ofType: type);
  }

  return type;
}

/// Generate a query definition from a GraphQL schema and a query, given
/// Artemis options and schema mappings.
QueryDefinition generateQuery(
  GraphQLSchema schema,
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

  final parentType = gql.getTypeByName(
      schema, (schema.queryType ?? schema.mutationType)?.name,
      context: 'query/mutation root');

  final suffix = operation.type == OperationType.query ? 'Query' : 'Mutation';

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
    queryType: '$className\$${parentType.name}',
    document: document,
    classes: visitor.context.generatedClasses,
    inputs: visitor.context.inputsClasses,
    generateHelpers: options.generateHelpers,
    suffix: suffix,
  );
}

List<String> _extractCustomImports(
  List<GraphQLType> types,
  GeneratorOptions options,
) =>
    types
        .map((GraphQLType type) {
          final scalarMap = gql.getSingleScalarMap(options, type);
          return scalarMap.dartType.imports.followedBy(
              [scalarMap.customParserImport].where((c) => c != null));
        })
        .expand((i) => i)
        .toSet()
        .toList();

ClassProperty _createClassProperty({
  @required String fieldName,
  String fieldAlias,
  @required Context context,
  @required InjectedOptions options,
  _OnNewClassFoundCallback onNewClassFound,
}) {
  final inputField = context.currentType.inputFields
      .firstWhere((f) => f.name == fieldName, orElse: () => null);
  final regularField = context.currentType.fields
      .firstWhere((f) => f.name == fieldName, orElse: () => null);

  final fieldType = regularField?.type ?? inputField?.type;

  if (fieldType == null) {
    throw Exception(
        '''Field $fieldName was not found in GraphQL type ${context.currentType.name}.
Make sure your query is correct and your schema is updated.''');
  }
  final aliasAsClassName =
      fieldAlias != null ? ReCase(fieldAlias).pascalCase : null;
  final nextType =
      fieldType.follow().upgrade(options.schema, context: 'field node');
  final nextClassName = context.joinedName(aliasAsClassName ?? nextType.name);

  final dartTypeStr = gql.buildTypeString(fieldType, options.options,
      dartType: true, replaceLeafWith: nextClassName);

  if (nextType.kind != GraphQLTypeKind.SCALAR &&
      nextType.kind != GraphQLTypeKind.ENUM &&
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
  final scalar = gql.getSingleScalarMap(options.options, nextType);
  if (nextType.kind == GraphQLTypeKind.SCALAR &&
      scalar.customParserImport != null) {
    final graphqlTypeSafeStr = gql
        .buildTypeString(fieldType, options.options, dartType: false)
        .replaceAll(RegExp(r'[<>]'), '');
    final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
    annotation =
        'JsonKey(fromJson: fromGraphQL${dartTypeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
  }

  // On enums
  else if (nextType.kind == GraphQLTypeKind.ENUM) {
    _generateEnumForType(
      context.nextTypeWithSamePath(
        nextType: nextType,
        alias: aliasAsClassName,
      ),
      options,
    );
    annotation = 'JsonKey(unknownEnumValue: $dartTypeStr.$ARTEMIS_UNKNOWN)';
  }

  return ClassProperty(
    type: dartTypeStr,
    name: fieldAlias ?? fieldName,
    annotation: annotation,
    isNonNull: fieldType.kind == GraphQLTypeKind.NON_NULL,
  );
}

void _generateEnumForType(Context context, InjectedOptions options) {
  final currentType =
      context.currentType.upgrade(options.schema, context: 'enum');

  _log('<- Generated enum ${context.joinedName()}', 0);
  context.generatedClasses.add(
    EnumDefinition(
      name: context.joinedName(),
      values: currentType.enumValues.map((eV) => eV.name).toList()
        ..add(ARTEMIS_UNKNOWN),
    ),
  );
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
    if (context.currentType.kind == GraphQLTypeKind.UNION ||
        context.currentType.kind == GraphQLTypeKind.INTERFACE) {
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
    final properties = context.currentType.inputFields.map((i) {
      return _createClassProperty(
        fieldName: i.name,
        context: context.sameTypeWithNextPath(),
        options: options,
        onNewClassFound: (nextContext) {
          _generateInputObjectClassesByType(nextContext);
        },
      );
    }).toList();

    _log('<- Generated input class ${context.joinedName()}.', 0);
    context.generatedClasses.add(ClassDefinition(
      name: context.joinedName(),
      properties: properties,
      isInput: true,
    ));
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final varType = _unwrapToType(options.schema, node.type);
    final nextClassName = context.joinedName(varType.name);

    final dartTypeStr = gql.buildTypeString(varType, options.options,
        dartType: true, replaceLeafWith: nextClassName);
    context.inputsClasses.add(QueryInput(
      type: dartTypeStr,
      name: node.variable.name.value,
      isNonNull: node.type.isNonNull,
    ));

    _log('Found new input ${node.variable.name.value} (-> $dartTypeStr).');

    final leafType = varType.follow().upgrade(options.schema);
    final nextContext = context.nextTypeWithSamePath(nextType: leafType);
    if (leafType.kind == GraphQLTypeKind.INPUT_OBJECT) {
      _generateInputObjectClassesByType(nextContext);
    } else if (leafType.kind == GraphQLTypeKind.ENUM) {
      _generateEnumForType(nextContext, options);
    }
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    context.fragments.add(node);
    final partName = '${ReCase(node.name.value).pascalCase}Mixin';

    final fragmentOnClassName = node.typeCondition.on.name.value;
    final nextType = gql.getTypeByName(options.schema, fragmentOnClassName,
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

    _log('<- Generated mixin ${context.joinedName(partName)}', 0);
    context.generatedClasses.add(
      FragmentClassDefinition(
        name: context.joinedName(partName),
        properties: visitor._classProperties,
      ),
    );
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    final onTypeName = node.typeCondition.on.name.value;
    final nextType = gql.getTypeByName(options.schema, onTypeName,
        context: 'inline fragment');

    _log('Fragment spread on ${nextType.name} (context: ${context.path}).');

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
        'Visiting $fieldName ${node.alias?.value != null ? '(alias: ${node.alias.value})' : ''} on ${context.currentType.name} (context: ${context.path}).');

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
        'Spreading fragment $fragmentName into GraphQL type ${context.currentType.name} (context: ${context.path}).');
    _mixins.add(fragmentName);
  }
}
