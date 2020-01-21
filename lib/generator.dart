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
    throw Exception('''Two classes were generated with the same name `$a`!
You may want to do either:
- Enable add_query_prefix on this schema_map
- Make queries_glob stricter, to gather less .graphql files on a single output
- Use alias on one of the places a `$a` field is requested''');
  });

  final basename = p.basenameWithoutExtension(path);
  final customImports = _extractCustomImports(schema.types, options);
  return LibraryDefinition(
    basename,
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
    List<FragmentDefinitionNode> fragmentsCommon) {
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

  final prefix = schemaMap.addQueryPrefix ? className : '';

  final inputs = <QueryInput>[];
  final inputsClasses = <Definition>[];
  if (operation.variableDefinitions != null) {
    operation.variableDefinitions.forEach((v) {
      final type = _unwrapToType(schema, v.type);

      if (type.kind == GraphQLTypeKind.INPUT_OBJECT ||
          (type.kind == GraphQLTypeKind.LIST &&
              type.ofType.kind == GraphQLTypeKind.INPUT_OBJECT)) {
        inputsClasses.addAll(_extractClasses(
            null, fragments, schema, type.name, type, options, schemaMap,
            prefix: prefix));
      }

      final dartTypeStr =
          gql.buildTypeString(type, options, dartType: true, prefix: prefix);
      inputs.add(QueryInput(dartTypeStr, v.variable.name.value));
    });
  }

  final classes = _extractClasses(
    operation.selectionSet,
    fragments,
    schema,
    className,
    parentType,
    options,
    schemaMap,
    prefix: prefix,
  );

  return QueryDefinition(
    queryName,
    document,
    classes:
        removeDuplicatedBy(classes.followedBy(inputsClasses), (i) => i.name),
    inputs: inputs,
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

  return ClassProperty(dartTypeStr, alias, annotation: annotation);
}

ClassProperty _selectionToClassProperty(
  SelectionNode selection,
  GraphQLSchema schema,
  GraphQLType parentType,
  GeneratorOptions options, {
  OnNewClassFoundCallback onNewClassFound,
  String prefix = '',
}) {
  if (selection is! FieldNode) return null;

  final field = (selection as FieldNode);

  final fieldName = field.name.value;
  var alias = fieldName;
  String aliasClassName;
  final hasAlias = field.alias != null;
  if (hasAlias) {
    alias = field.alias.value;
    aliasClassName = ReCase(alias).pascalCase;
  }

  if (fieldName.startsWith('__')) {
    return null;
  }

  return _createClassProperty(
    fieldName,
    alias,
    aliasClassName,
    schema,
    parentType,
    options,
    onNewClassFound: onNewClassFound,
    selection: selection,
    prefix: prefix,
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

List<Definition> _extractClasses(
  SelectionSetNode selectionSet,
  List<FragmentDefinitionNode> fragments,
  GraphQLSchema schema,
  String className,
  GraphQLType currentType,
  GeneratorOptions options,
  SchemaMap schemaMap, {
  String prefix = '',
  SelectionSetNode parentSelectionSet,
}) {
  final thisClassName = prefix == className ? className : '$prefix$className';

  if (currentType.kind == GraphQLTypeKind.INPUT_OBJECT ||
      (currentType.kind == GraphQLTypeKind.UNION && selectionSet == null)) {
    final queue = <Definition>[];
    final properties = currentType.inputFields.map((i) {
      final type = gql.getTypeByName(schema, gql.followType(i.type).name,
          context: 'input object/union');
      return _createClassProperty(
        i.name,
        i.name,
        type.name,
        schema,
        currentType,
        options,
        prefix: prefix,
        onNewClassFound: (selectionSet, className, type) {
          queue.addAll(
            _extractClasses(
              null,
              fragments,
              schema,
              className,
              type,
              options,
              schemaMap,
              prefix: prefix,
              parentSelectionSet: selectionSet,
            ),
          );
        },
      );
    }).toList();

    queue.insert(
      0,
      ClassDefinition(thisClassName, properties),
    );

    return queue;
  }
  if (currentType.kind == GraphQLTypeKind.ENUM) {
    return [
      EnumDefinition(
        prefix + currentType.name,
        currentType.enumValues.map((eV) => eV.name).toList(),
      ),
    ];
  }
  if (selectionSet != null) {
    final classProperties = <ClassProperty>[];
    final factoryPossibilities = <String>{};
    final mixins = <FragmentClassDefinition>{};
    final queue = <Definition>[];
    String classExtension;
    Iterable<String> classImplementations = [];

    // Add fragments as mixins
    selectionSet.selections
        .whereType<FragmentSpreadNode>()
        .forEach((selection) {
      final mixinFields = <ClassProperty>[];
      fragments
          .firstWhere(
            (f) => f.name.value == selection.name.value,
          )
          .selectionSet
          .selections
          .whereType<FieldNode>()
          .forEach(
        (selection) {
          final cp = _selectionToClassProperty(
            selection,
            schema,
            currentType,
            options,
            prefix: prefix,
            onNewClassFound: (
              selectionSet,
              className,
              type,
            ) {
              queue.addAll(
                _extractClasses(
                  selection.selectionSet,
                  fragments,
                  schema,
                  className,
                  type,
                  options,
                  schemaMap,
                  prefix: prefix,
                  parentSelectionSet: selectionSet,
                ),
              );
            },
          );

          mixinFields.add(cp);
        },
      );

      if (mixinFields.isNotEmpty) {
        final mixinName = ReCase('${selection.name.value}Mixin').pascalCase;
        final fragment = FragmentClassDefinition(
          mixinName,
          mixinFields.toList(),
        );
        queue.add(fragment);
        mixins.add(fragment);
      }
    });

    // Look at field selections and add it as class properties
    selectionSet.selections.whereType<FieldNode>().forEach(
      (selection) {
        final cp = _selectionToClassProperty(
          selection,
          schema,
          currentType,
          options,
          prefix: prefix,
          onNewClassFound: (
            selectionSet,
            className,
            type,
          ) {
            queue.addAll(
              _extractClasses(
                selection.selectionSet,
                fragments,
                schema,
                className,
                type,
                options,
                schemaMap,
                prefix: prefix,
                parentSelectionSet: selectionSet,
              ),
            );
          },
        );

        classProperties.add(cp);
      },
    );

    // Look at inline fragment spreads to consider factory overrides
    selectionSet.selections.whereType<InlineFragmentNode>().forEach(
      (selection) {
        final spreadClassName = selection.typeCondition.on.name.value;
        final spreadType = gql.getTypeByName(
          schema,
          spreadClassName,
          context: 'inline fragment',
        );

        if (spreadType.possibleTypes.isNotEmpty) {
          // If it's, say, a union type, add to factory possibilities all possibleTypes that the query selects
          factoryPossibilities.addAll(
            spreadType.possibleTypes
                .where(
                  (t) => selection.selectionSet.selections
                      .whereType<InlineFragmentNode>()
                      .any(
                        (s) => s.typeCondition.on.name.value == t.name,
                      ),
                )
                .map(
                  (t) => t.name,
                ),
          );
        } else {
          factoryPossibilities.add(spreadClassName);
        }

        queue.addAll(
          _extractClasses(
            selection.selectionSet,
            fragments,
            schema,
            spreadClassName,
            spreadType,
            options,
            schemaMap,
            prefix: prefix,
            parentSelectionSet: selectionSet,
          ),
        );
      },
    );

    // Part of a union type
    final unionOf = schema.types.firstWhere(
        (t) =>
            t.kind == GraphQLTypeKind.UNION &&
            t.possibleTypes.any((pt) => pt.name == currentType.name),
        orElse: () => null);
    if (unionOf != null) {
      classExtension = '$prefix${unionOf.name}';
      queue.addAll(_extractClasses(
          null, fragments, schema, unionOf.name, unionOf, options, schemaMap,
          prefix: prefix));
    }

    // If this is an interface, we must add resolveType
    if (currentType.kind == GraphQLTypeKind.INTERFACE) {
      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: 'JsonKey(name: \'${schemaMap.resolveTypeField}\')'));
    }

    // If this is an interface child, we must add mixins, resolveType, and override properties
    if (currentType.interfaces.isNotEmpty ||
        currentType.kind == GraphQLTypeKind.UNION) {
      final interfacesOfUnion = currentType.kind == GraphQLTypeKind.UNION
          ? currentType.possibleTypes
              .map((t) => gql
                  .getTypeByName(schema, t.name, context: 'union interfaces')
                  .interfaces)
              .expand<GraphQLType>((i) => i)
          : <GraphQLType>[];
      final implementations = currentType.interfaces
          .followedBy(interfacesOfUnion)
          .map((t) => gql.getTypeByName(schema, t.name, context: 'interfaces'))
          .toSet();

      classImplementations =
          implementations.map((t) => '$prefix${t.name}').toList();

      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: 'JsonKey(name: \'${schemaMap.resolveTypeField}\')',
          isOverride: true));

      implementations.forEach((interfaceType) {
        queue.addAll(_extractClasses(
          selectionSet,
          fragments,
          schema,
          interfaceType.name,
          gql.getTypeByName(schema, interfaceType.name, context: 'interface'),
          options,
          schemaMap,
          prefix: prefix,
        ));

        parentSelectionSet.selections.whereType<FieldNode>().forEach(
          (selection) {
            final cp = _selectionToClassProperty(
              selection,
              schema,
              interfaceType,
              options,
              prefix: prefix,
            );
            if (cp != null) {
              classProperties.add(cp.copyWith(isOverride: true));
            }
          },
        );
      });
    }

    queue.insert(
      0,
      ClassDefinition(
        thisClassName,
        mergeDuplicatesBy(
            classProperties.where((c) => c != null),
            (c) => c.name,
            (old, n) =>
                old.copyWith(isOverride: old.isOverride || n.isOverride)),
        extension: classExtension,
        implementations: classImplementations,
        mixins: mixins.toList(),
        factoryPossibilities: factoryPossibilities.toList(),
        prefix: prefix,
        resolveTypeField: schemaMap.resolveTypeField,
      ),
    );

    return queue;
  }
  return [];
}
