import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:graphql_parser/graphql_parser.dart';
import 'package:recase/recase.dart';
import 'package:artemis/schema/options.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/generator/print_helpers.dart';
import 'package:artemis/generator/graphql_helpers.dart' as gql;

Future<String> generate(
    GraphQLSchema schema, String path, GeneratorOptions options) async {
  return '';
}

OperationDefinitionContext getOperationFromQuery(String queryStr) {
  final tokens = scan(queryStr);
  final parser = Parser(tokens);

  if (parser.errors.isNotEmpty) {
    throw Exception('''
There's (at least) an error while parsing a query. Please fix it and run me again:
${parser.errors.map((e) => e.message).join('\n')}
''');
  }

  final doc = parser.parseDocument();

  return doc.definitions.whereType<OperationDefinitionContext>().first;
}

List<FragmentDefinitionContext> getFragmentsFromQuery(String queryStr) {
  final tokens = scan(queryStr);
  final parser = Parser(tokens);

  if (parser.errors.isNotEmpty) {
    throw Exception('''
There's (at least) an error while parsing a query. Please fix it and run me again:
${parser.errors.map((e) => e.message).join('\n')}
''');
  }

  final doc = parser.parseDocument();

  return doc.definitions.whereType<FragmentDefinitionContext>().toList();
}

Future<String> generateQuery(GraphQLSchema schema, String path, String queryStr,
    GeneratorOptions options, SchemaMap schemaMap) async {
  final StringBuffer buffer = StringBuffer();

  final operation = getOperationFromQuery(queryStr);
  final fragments = getFragmentsFromQuery(queryStr);

  final basename = p.basenameWithoutExtension(path);
  final queryName = ReCase(operation.name ?? basename).pascalCase;
  final parentType = gql.getTypeByName(schema, schema.queryType.name);

  final List<QueryInput> inputs = [];
  if (operation.variableDefinitions != null) {
    inputs.addAll(operation.variableDefinitions.variableDefinitions.map((v) {
      final type = gql.getTypeByName(schema, v.type.typeName.name);
      final dartTypeStr =
          gql.buildType(type, options, options.prefix, dartType: true);
      return QueryInput(dartTypeStr, v.variable.name);
    }));
  }

  final classes = _extractClasses(buffer, operation.selectionSet, fragments,
      schema, queryName, parentType, options, schemaMap);

  printCustomQuery(
      buffer,
      QueryDefinition(
        queryName,
        queryStr,
        basename,
        classes: classes,
        inputs: inputs,
        generateHelpers: options.generateHelpers,
        customParserImport: options.customParserImport,
      ));

  return buffer.toString();
}

ClassProperty _selectionToClassProperty(SelectionContext selection,
    GraphQLSchema schema, GraphQLType type, GeneratorOptions options,
    {OnNewClassFoundCallback onNewClassFound}) {
  String annotation;
  String fieldName = selection.field.fieldName.name;
  String alias = fieldName;
  String aliasClassName;
  final bool hasAlias = selection.field.fieldName.alias != null;
  if (hasAlias) {
    alias = selection.field.fieldName.alias.alias;
    aliasClassName = ReCase(selection.field.fieldName.alias.alias).pascalCase;
    fieldName = selection.field.fieldName.alias.name;
  }

  final graphQLField = type.fields.firstWhere((f) => f.name == fieldName);
  final dartTypeStr = gql.buildType(graphQLField.type, options, options.prefix,
      dartType: true, replaceLeafWith: aliasClassName);

  final leafType =
      gql.getTypeByName(schema, gql.followType(graphQLField.type).name);
  if (leafType.kind != GraphQLTypeKind.SCALAR && onNewClassFound != null) {
    onNewClassFound(selection.field.selectionSet,
        aliasClassName ?? leafType.name, leafType);
  }

  // On custom scalars
  final scalar = gql.getSingleScalarMap(options, leafType);
  if (leafType.kind == GraphQLTypeKind.SCALAR && scalar.useCustomParser) {
    final graphqlTypeSafeStr = gql
        .buildType(graphQLField.type, options, options.prefix, dartType: false)
        .replaceAll(RegExp(r'[<>]'), '');
    final dartTypeSafeStr = dartTypeStr.replaceAll(RegExp(r'[<>]'), '');
    annotation =
        '@JsonKey(fromJson: fromGraphQL${graphqlTypeSafeStr}ToDart$dartTypeSafeStr, toJson: fromDart${dartTypeSafeStr}ToGraphQL$graphqlTypeSafeStr)';
  }

  return ClassProperty(dartTypeStr, alias, annotation: annotation);
}

List<Definition> _extractClasses(
    StringBuffer buffer,
    SelectionSetContext selectionSet,
    List<FragmentDefinitionContext> fragments,
    GraphQLSchema schema,
    String className,
    GraphQLType currentType,
    GeneratorOptions options,
    SchemaMap schemaMap,
    {SelectionSetContext parentSelectionSet}) {
  if (currentType.kind == GraphQLTypeKind.INPUT_OBJECT) {
    // TODO: this
    return [];
  }
  if (currentType.kind == GraphQLTypeKind.ENUM) {
    return [
      EnumDefinition(
        currentType.name,
        currentType.enumValues.map((eV) => eV.name),
      ),
    ];
  }
  if (selectionSet != null) {
    final classProperties = <ClassProperty>[];
    final factoryPossibilities = Set<String>();
    final queue = <Definition>[];
    String mixins = '';

    // Spread fragment spreads into selections
    final fragmentSelections = selectionSet.selections
        .where((s) => s.fragmentSpread != null)
        .map((selection) => fragments
            .firstWhere((f) => f.name == selection.fragmentSpread.name)
            .selectionSet
            .selections)
        .expand((i) => i);

    // Look at field selections (and fragment spreads) and add it as class properties
    fragmentSelections
        .followedBy(selectionSet.selections)
        .where((s) => s.field != null)
        .forEach((selection) {
      final cp =
          _selectionToClassProperty(selection, schema, currentType, options,
              onNewClassFound: (selectionSet, className, type) {
        queue.addAll(_extractClasses(buffer, selection.field.selectionSet,
            fragments, schema, className, type, options, schemaMap,
            parentSelectionSet: selectionSet));
      });

      classProperties.add(cp);
    });

    // Look at inline fragment spreads to consider factory overrides
    selectionSet.selections
        .where((s) => s.inlineFragment != null)
        .forEach((selection) {
      final spreadClassName =
          selection.inlineFragment.typeCondition.typeName.name;
      final spreadType = gql.getTypeByName(schema, spreadClassName);

      if (spreadType.possibleTypes.isNotEmpty) {
        // If it's, say, a union type, add to factory possibilities all possibleTypes that the query selects
        factoryPossibilities.addAll(spreadType.possibleTypes
            .where((t) => selection.inlineFragment.selectionSet.selections.any(
                (s) =>
                    s.inlineFragment != null &&
                    s.inlineFragment.typeCondition.typeName.name == t.name))
            .map((t) => t.name));
      } else {
        factoryPossibilities.add(spreadClassName);
      }

      queue.addAll(_extractClasses(
          buffer,
          selection.inlineFragment.selectionSet,
          fragments,
          schema,
          spreadClassName,
          spreadType,
          options,
          schemaMap,
          parentSelectionSet: selectionSet));
    });

    // Part of a union type
    final unionOf = schema.types.firstWhere(
        (t) =>
            t.kind == GraphQLTypeKind.UNION &&
            t.possibleTypes.any((pt) => pt.name == currentType.name),
        orElse: () => null);
    if (unionOf != null) {
      mixins = 'extends ${unionOf.name}';
    }

    // If this is an interface, we must add resolveType
    if (currentType.kind == GraphQLTypeKind.INTERFACE) {
      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'${schemaMap.resolveTypeField}\')'));
    }

    // If this is an interface child, we must add mixins, resolveType, and override properties
    if (currentType.interfaces.isNotEmpty ||
        currentType.kind == GraphQLTypeKind.UNION) {
      final interfacesOfUnion = currentType.kind == GraphQLTypeKind.UNION
          ? currentType.possibleTypes
              .map((t) => gql.getTypeByName(schema, t.name).interfaces)
              .expand<GraphQLType>((i) => i)
          : <GraphQLType>[];
      final implementations = currentType.interfaces
          .followedBy(interfacesOfUnion)
          .map((t) => gql.getTypeByName(schema, t.name))
          .toSet();

      mixins =
          '$mixins implements ' + implementations.map((t) => t.name).join(', ');

      classProperties.add(ClassProperty('String', 'resolveType',
          annotation: '@JsonKey(name: \'${schemaMap.resolveTypeField}\')',
          override: true));

      implementations.forEach((interfaceType) {
        parentSelectionSet.selections
            .where((s) => s.field != null)
            .forEach((selection) {
          final cp = _selectionToClassProperty(
              selection, schema, interfaceType, options);
          classProperties.add(cp.copyWith(override: true));
        });
      });
    }

    queue.insert(
      0,
      ClassDefinition(
        className,
        classProperties,
        mixins: mixins,
        factoryPossibilities: factoryPossibilities,
        resolveTypeField: schemaMap.resolveTypeField,
      ),
    );

    return queue;
  }
  return [];
}
