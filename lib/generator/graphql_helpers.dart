import 'dart:convert';
import '../schema/graphql.dart';
import '../schema/options.dart';

/// Get a full [GraphQLType] from its canonical name.
GraphQLType getTypeByName(GraphQLSchema schema, String name, {String context}) {
  if (_defaultScalarMapping.containsKey(name)) {
    return GraphQLType(
      name: name,
      kind: GraphQLTypeKind.SCALAR,
    );
  }
  return schema.types.firstWhere((t) => t.name == name,
      orElse: () => throw Exception(
          'Type $name not found on schema (on `$context` context).'));
}

/// "Follow" a type to find the leaf scalar or type.
GraphQLType followType(GraphQLType type) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
    case GraphQLTypeKind.NON_NULL:
      return followType(type.ofType);
    default:
      return type;
  }
}

/// Build a string repesenting a Dart type, given a GraphQL type.
String buildTypeString(GraphQLType type, GeneratorOptions options,
    {bool dartType = true, String replaceLeafWith}) {
  switch (type.kind) {
    case GraphQLTypeKind.LIST:
      return 'List<${buildTypeString(type.ofType, options, dartType: dartType, replaceLeafWith: replaceLeafWith)}>';
    case GraphQLTypeKind.NON_NULL:
      return buildTypeString(type.ofType, options,
          dartType: dartType, replaceLeafWith: replaceLeafWith);
    case GraphQLTypeKind.SCALAR:
      final scalar = getSingleScalarMap(options, type);
      return dartType ? scalar.dartType.name : scalar.graphQLType;
    default:
      if (replaceLeafWith != null) return replaceLeafWith;
      return type.name;
  }
}

Map<String, ScalarMap> _defaultScalarMapping = {
  'Boolean':
      ScalarMap(graphQLType: 'Boolean', dartType: const DartType(name: 'bool')),
  'Float':
      ScalarMap(graphQLType: 'Float', dartType: const DartType(name: 'double')),
  'ID': ScalarMap(graphQLType: 'ID', dartType: const DartType(name: 'String')),
  'Int': ScalarMap(graphQLType: 'Int', dartType: const DartType(name: 'int')),
  'String': ScalarMap(
      graphQLType: 'String', dartType: const DartType(name: 'String')),
};

/// Retrieve a scalar mapping of a type.
ScalarMap getSingleScalarMap(GeneratorOptions options, GraphQLType type) =>
    options.scalarMapping
        .followedBy(_defaultScalarMapping.values)
        .firstWhere((m) => m.graphQLType == type.name,
            orElse: () => ScalarMap(
                  graphQLType: type.name,
                  dartType: DartType(name: type.name),
                ));

/// Instantiates a schema from a JSON string.
GraphQLSchema schemaFromJsonString(String jsonS) =>
    GraphQLSchema.fromJson(json.decode(jsonS) as Map<String, dynamic>);
