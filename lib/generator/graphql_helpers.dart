// @dart = 2.8

import 'package:gql/ast.dart';

import '../generator/data/data.dart';
import '../generator/errors.dart';
import '../schema/options.dart';
import '../visitor.dart';
import 'data/definition.dart';

/// Get a full [TypeDefinitionNode] from a type node.
TypeDefinitionNode getTypeByName(DocumentNode schema, TypeNode typeNode,
    {String context}) {
  NamedTypeNode namedNode;

  if (typeNode is ListTypeNode) {
    return getTypeByName(schema, typeNode.type, context: context);
  }

  if (typeNode is NamedTypeNode) {
    namedNode = typeNode;
  }

  final typeVisitor = TypeDefinitionNodeVisitor();
  schema.accept(typeVisitor);

  final type = typeVisitor.getByName(namedNode.name.value);

  if (type == null) {
    throw Exception('''Type ${namedNode.name.value} was not found in schema.
Make sure your query is correct and your schema is updated.''');
  }

  return type;
}

/// Build a string representing a Dart type, given a GraphQL type.
TypeName buildTypeName(
  Node node,
  GeneratorOptions options, {
  bool dartType = true,
  Name replaceLeafWith,
  DocumentNode schema,
}) {
  if (node is NamedTypeNode) {
    final typeVisitor = TypeDefinitionNodeVisitor();
    schema.accept(typeVisitor);
    final type = typeVisitor.getByName(node.name.value);

    if (type != null) {
      if (type is ScalarTypeDefinitionNode) {
        final scalar = getSingleScalarMap(options, node.name.value);
        return TypeName(
            name: dartType ? scalar.dartType.name : scalar.graphQLType);
      }

      if (type is EnumTypeDefinitionNode ||
          type is InputObjectTypeDefinitionNode) {
        return TypeName(name: type.name.value);
      }

      if (replaceLeafWith != null) {
        return TypeName(name: replaceLeafWith.name);
      } else {
        return TypeName(name: type.name.value);
      }
    }

    return TypeName(name: node.name.value);
  }

  if (node is ListTypeNode) {
    final typeName = buildTypeName(node.type, options,
        dartType: dartType, replaceLeafWith: replaceLeafWith, schema: schema);
    return TypeName(name: 'List<${typeName.namePrintable}>');
  }

  throw Exception('Unable to build type name');
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
ScalarMap getSingleScalarMap(GeneratorOptions options, String type,
        {bool throwOnNotFound = true}) =>
    options.scalarMapping.followedBy(_defaultScalarMapping.values).firstWhere(
          (m) => m.graphQLType == type,
          orElse: () => throwOnNotFound
              ? throw MissingScalarConfigurationException(type)
              : null,
        );

/// Retrieve imports of a scalar map.
Iterable<String> importsOfScalar(GeneratorOptions options, String type) {
  final scalarMapping = options.scalarMapping.firstWhere(
    (m) => m.graphQLType == type,
    orElse: () => null,
  );
  return (scalarMapping?.dartType?.imports ?? [])
      .followedBy([scalarMapping?.customParserImport]).where((c) => c != null);
}
