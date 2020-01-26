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
    List<FragmentDefinitionNode> fragmenDefinitionNode) {
  final queriesDefinitions = gqlDocs
      .map((doc) => generateQuery(
          schema, path, doc, options, schemaMap, fragmenDefinitionNode))
      .toList();

  final allClassesNames = queriesDefinitions.fold<Iterable<String>>(
      [], (defs, def) => defs.followedBy(def.classes.map((c) => c.name)));

  mergeDuplicatesBy(allClassesNames, (a) => a, (a, b) {
    print(queriesDefinitions);

    throw Exception('''Two classes were generated with the same name `$a`!
You may want to do either:
- Enable add_query_prefix on this schema_map
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a `$a` field is requested''');
  });

  final basename = p.basenameWithoutExtension(path);
  final customImports = _extractCustomImports(schema.types, options);
  return LibraryDefinition(
    basename: basename,
    queries: queriesDefinitions,
    customImports: customImports,
    customParserImport: options.customParserImport,
  );
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
  document.definitions.addAll(fragmentsCommon ?? []);

  final basename = p.basenameWithoutExtension(path);
  final queryName = operation.name?.value ?? basename;
  final className = ReCase(queryName).pascalCase;

  var parentType =
      gql.getTypeByName(schema, schema.queryType.name, context: 'query');
  if (operation.type == OperationType.mutation) {
    parentType = gql.getTypeByName(schema, schema.mutationType.name,
        context: 'mutation');
  }

  final prefix = schemaMap.addQueryPrefix ? className : '';

  final visitor = _AB(
    context: _Context(
      className: parentType.name,
      currentType: parentType,
      generatedClasses: [],
      inputsClasses: [],
      fragments: [],
    ),
    options: _InjectedOptions(
      schema: schema,
      options: options,
      schemaMap: schemaMap,
      prefix: prefix,
    ),
  );
  document.accept(visitor);

  return QueryDefinition(
    queryName: queryName,
    queryType: parentType.name,
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
        .map((GraphQLType type) =>
            gql.getSingleScalarMap(options, type).dartType.imports)
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
  String prefix = '',
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
      dartType: true, replaceLeafWith: aliasClassName, prefix: prefix);

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
  if (leafType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParser) {
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
  );
}

class _InjectedOptions {
  _InjectedOptions({
    @required this.schema,
    @required this.options,
    @required this.schemaMap,
    this.prefix = '',
  });

  final GraphQLSchema schema;
  final GeneratorOptions options;
  final SchemaMap schemaMap;
  final String prefix;
}

class _Context {
  _Context({
    @required this.className,
    @required this.currentType,
    @required this.generatedClasses,
    @required this.inputsClasses,
    @required this.fragments,
  });

  final String className;
  final GraphQLType currentType;

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
    print('Start wrapping class ${context.className}.');
    super.visitSelectionSetNode(node);
    print('Finish wrapping class ${context.className}.');
    context.generatedClasses.add(ClassDefinition(
      name: context.className,
      properties: _classProperties,
      mixins: _mixins,
      prefix: options.prefix,
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
        prefix: options.prefix,
        onNewClassFound: (selectionSet, className, type) {
          _generateInputObjectClassesByType(context, type);
        },
      );
    }).toList();

    context.generatedClasses.add(ClassDefinition(
      name: type.name,
      properties: properties,
      prefix: options.prefix,
    ));
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    final varType = _unwrapToType(options.schema, node.type);
    final dartTypeStr = gql.buildTypeString(varType, options.options,
        dartType: true, prefix: options.prefix);
    context.inputsClasses.add(QueryInput(
      type: dartTypeStr,
      name: node.variable.name.value,
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
    final nextClassName = '${options.prefix}$fragmentName';

    final visitor = _AB(
      context: _Context(
        className: nextClassName,
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
  void visitFieldNode(FieldNode node) {
    final fieldName = node.name.value;
    final field = context.currentType.fields
        .firstWhere((f) => f.name == fieldName, orElse: () => null);
    print(
        'Searching for field $fieldName in GraphQL type ${context.currentType.name} (on ${context.className} context)... ${field == null ? 'Not found' : 'Found'}.');
    if (field == null) {
      throw Exception(
          '''Field $fieldName was not found in GraphQL type ${context.currentType.name}.
Make sure your query is correct and your schema is updated.''');
    }
    final aliasAsClassName = node.alias?.value != null
        ? ReCase('${options.prefix}${node.alias?.value}').pascalCase
        : null;
    final nextType =
        gql.getTypeByName(options.schema, gql.followType(field.type).name);
    final nextClassName =
        '${context.className}\$${aliasAsClassName ?? nextType.name}';

    final dartTypeStr = gql.buildTypeString(field.type, options.options,
        dartType: true, prefix: options.prefix, replaceLeafWith: nextClassName);

    print('$fieldName GraphQL type is ${nextType.name} (-> $dartTypeStr).');

    _classProperties.add(ClassProperty(
      type: dartTypeStr,
      name: node.alias?.value ?? fieldName,
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
