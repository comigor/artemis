import 'package:meta/meta.dart';
import 'package:gql/ast.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import './generator/data.dart';
import './generator/graphql_helpers.dart' as gql;
import './generator/helpers.dart';
import './schema/graphql.dart';
import './schema/options.dart';

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
    print(queriesDefinitions);

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

  var parentType =
      gql.getTypeByName(schema, schema.queryType.name, context: 'query');
  if (operation.type == OperationType.mutation) {
    parentType = gql.getTypeByName(schema, schema.mutationType.name,
        context: 'mutation');
  }

  final visitor = _AB(
    context: _Context(
      className: '$className\$${parentType.name}',
      currentType: parentType,
      generatedClasses: [],
      inputsClasses: [],
      fragments: fragments,
    ),
    options: _InjectedOptions(
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

ClassProperty _createClassProperty(
  String fieldName,
  String alias,
  String aliasClassName,
  GraphQLSchema schema,
  GraphQLType parentType,
  GeneratorOptions options, {
  OnNewClassFoundCallback onNewClassFound,
  SelectionNode selection,
}) {
  String annotation;
  final graphQLField = parentType.fields
      .firstWhere((f) => f.name == fieldName, orElse: () => null);
  final graphQLInputValue = parentType.inputFields
      .firstWhere((f) => f.name == fieldName, orElse: () => null);

  final selectedType = graphQLField?.type ?? graphQLInputValue?.type;
  if (selectedType == null) {
    print(
        'Could not find property "${fieldName}" of class "${parentType.name}". Moving on...');
    return null;
  }

  final dartTypeStr = gql.buildTypeString(selectedType, options,
      dartType: true, replaceLeafWith: aliasClassName);

  final leafType = gql.getTypeByName(schema, gql.followType(selectedType).name,
      context: 'class property');
  if (leafType.kind != GraphQLTypeKind.SCALAR && onNewClassFound != null) {
    onNewClassFound(
        selection != null && selection is FieldNode
            ? selection.selectionSet
            : null,
        aliasClassName ?? leafType.name,
        leafType);
  }

  // On custom scalars
  final scalar = gql.getSingleScalarMap(options, leafType);
  if (leafType.kind == GraphQLTypeKind.SCALAR &&
      scalar.customParserImport != null) {
    final graphqlTypeSafeStr = gql
        .buildTypeString(selectedType, options, dartType: false)
        .replaceAll(RegExp(r'[<>]'), '');
    final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
    annotation =
        'JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
  }

  return ClassProperty(
    type: dartTypeStr,
    name: alias,
    annotation: annotation,
    isNonNull: graphQLInputValue?.type?.kind == GraphQLTypeKind.NON_NULL,
  );
}

class _InjectedOptions {
  _InjectedOptions({
    @required this.schema,
    @required this.options,
    @required this.schemaMap,
  });

  final GraphQLSchema schema;
  final GeneratorOptions options;
  final SchemaMap schemaMap;
}

class _Context {
  _Context({
    @required this.className,
    @required this.currentType,
    this.ofUnion,
    @required this.generatedClasses,
    @required this.inputsClasses,
    @required this.fragments,
  });

  final String className;
  final GraphQLType currentType;
  final GraphQLType ofUnion;

  final List<Definition> generatedClasses;
  final List<QueryInput> inputsClasses;
  final List<FragmentDefinitionNode> fragments;
}

class _AB extends RecursiveVisitor {
  _AB({
    @required this.context,
    @required this.options,
  });

  final _Context context;
  final _InjectedOptions options;

  SelectionSetNode selectionSetNode;
  final List<ClassProperty> _classProperties = [];
  final List<String> _mixins = [];

  @override
  void visitSelectionSetNode(SelectionSetNode node) {
    print(
        'Start wrapping class ${context.currentType.name} (-> ${context.className}).');
    super.visitSelectionSetNode(node);
    print(
        'Finish wrapping class ${context.currentType.name} (-> ${context.className}).');

    final possibleTypes = <String, String>{};
    if (context.currentType.kind == GraphQLTypeKind.UNION ||
        context.currentType.kind == GraphQLTypeKind.INTERFACE) {
      // Filter by requested types
      final keys = node.selections
          .whereType<InlineFragmentNode>()
          .map((n) => n.typeCondition.on.name.value);
      final values = keys.map((t) => '${context.className}\$$t');
      possibleTypes.addAll(Map.fromIterables(keys, values));
      _classProperties.add(ClassProperty(
        type: 'String',
        name: 'typeName',
        annotation: 'JsonKey(name: \'${options.schemaMap.typeNameField}\')',
        isOverride: true,
      ));
      print('It is an union/interface of possible types $possibleTypes.');
    }
    final partOfUnion = context.ofUnion != null;
    if (partOfUnion) {
      print('It is part of union ${context.ofUnion.name}.');
    }

    context.generatedClasses.add(ClassDefinition(
      name: context.className,
      properties: _classProperties,
      mixins: _mixins,
      extension: partOfUnion
          ? context.className.replaceAll('\$${context.currentType.name}', '')
          : null,
      factoryPossibilities: possibleTypes,
    ));
  }

  void _generateInputObjectClassesByType(_Context context, GraphQLType type) {
    final currentType =
        gql.getTypeByName(options.schema, type.name, context: 'input object');

    if (currentType.kind == GraphQLTypeKind.ENUM) {
      context.generatedClasses.add(
        EnumDefinition(
          name: currentType.name,
          values: currentType.enumValues.map((eV) => eV.name).toList(),
        ),
      );
      return;
    }

    final properties = currentType.inputFields.map((i) {
      final type = gql.getTypeByName(
          options.schema, gql.followType(i.type).name,
          context: 'input object/union');
      return _createClassProperty(
        i.name,
        i.name,
        type.name,
        options.schema,
        currentType,
        options.options,
        onNewClassFound: (selectionSet, className, type) {
          _generateInputObjectClassesByType(context, type);
        },
      );
    }).toList();

    context.generatedClasses.add(ClassDefinition(
      name: type.name,
      properties: properties,
      isInput: true,
    ));
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final varType = _unwrapToType(options.schema, node.type);
    final dartTypeStr =
        gql.buildTypeString(varType, options.options, dartType: true);
    context.inputsClasses.add(QueryInput(
      type: dartTypeStr,
      name: node.variable.name.value,
      isNonNull: node.type.isNonNull,
    ));

    print('Found new input ${node.variable.name.value} (-> $dartTypeStr).');

    final leafType = gql.followType(varType);
    if (leafType.kind == GraphQLTypeKind.INPUT_OBJECT) {
      _generateInputObjectClassesByType(context, leafType);
    }
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    context.fragments.add(node);
    final fragmentName = '${ReCase(node.name.value).pascalCase}Mixin';
    print('Found new fragment ${node.name.value} (-> $fragmentName).');

    final fragmentOnClassName = node.typeCondition.on.name.value;
    final nextType = gql.getTypeByName(options.schema, fragmentOnClassName,
        context: 'fragment definition');

    final visitor = _AB(
      context: _Context(
        className: fragmentName,
        currentType: nextType,
        generatedClasses: context.generatedClasses,
        inputsClasses: [],
        fragments: [],
      ),
      options: options,
    );

    node.selectionSet.visitChildren(visitor);

    context.generatedClasses.add(
      FragmentClassDefinition(
        name: fragmentName,
        properties: visitor._classProperties,
      ),
    );
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    final onTypeName = node.typeCondition.on.name.value;
    final nextType = gql.getTypeByName(options.schema, onTypeName,
        context: 'inline fragment');

    print(
        'Fragment spread on ${nextType.name} (on ${context.className} context).');

    final visitor = _AB(
      context: _Context(
        className: '${context.className}\$${nextType.name}',
        currentType: nextType,
        ofUnion: context.currentType,
        generatedClasses: context.generatedClasses,
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

    final field = context.currentType.fields
        .firstWhere((f) => f.name == fieldName, orElse: () => null);
    print(
        'Searching for field $fieldName in GraphQL type ${context.currentType.name} (on ${context.className} context)... ${field == null ? 'Not found' : 'Found'}.');
    if (field == null) {
      throw Exception(
          '''Field $fieldName was not found in GraphQL type ${context.currentType.name}.
Make sure your query is correct and your schema is updated.''');
    }
    final aliasAsClassName =
        node.alias?.value != null ? ReCase(node.alias?.value).pascalCase : null;
    final nextType = gql.getTypeByName(
        options.schema, gql.followType(field.type).name,
        context: 'field node');
    final nextClassName =
        '${context.className}\$${aliasAsClassName ?? nextType.name}';

    final dartTypeStr = gql.buildTypeString(field.type, options.options,
        dartType: true, replaceLeafWith: nextClassName);

    print('$fieldName GraphQL type is ${nextType.name} (-> $dartTypeStr).');

    // On custom scalars
    String annotation;
    final scalar = gql.getSingleScalarMap(options.options, nextType);
    if (nextType.kind == GraphQLTypeKind.SCALAR &&
        scalar.customParserImport != null) {
      final graphqlTypeSafeStr = gql
          .buildTypeString(field.type, options.options, dartType: false)
          .replaceAll(RegExp(r'[<>]'), '');
      final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
      annotation =
          'JsonKey(fromJson: fromGraphQL${dartTypeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
    }

    _classProperties.add(ClassProperty(
      type: dartTypeStr,
      name: node.alias?.value ?? fieldName,
      annotation: annotation,
      isNonNull: field.type.kind == GraphQLTypeKind.NON_NULL,
    ));

    node.visitChildren(_AB(
      context: _Context(
        className: nextClassName,
        currentType: nextType,
        generatedClasses: context.generatedClasses,
        inputsClasses: context.inputsClasses,
        fragments: context.fragments,
      ),
      options: options,
    ));
  }

  @override
  void visitFragmentSpreadNode(FragmentSpreadNode node) {
    final fragmentName = '${ReCase(node.name.value).pascalCase}Mixin';
    print(
        'Spreading fragment $fragmentName into GraphQL type ${context.currentType.name} (on ${context.className} context).');
    _mixins.add(fragmentName);
  }
}
