import 'package:artemis/visitor.dart';
import 'package:gql/ast.dart';

import '../schema/options.dart';

/// Get a full [TypeDefinitionNode] from its name.
TypeDefinitionNode getTypeByName(DocumentNode schema, Node name,
    {String context}) {
  NamedTypeNode namedNode;

  if (name is NamedTypeNode) {
    namedNode = name;
  }

  if (name is ListTypeNode) {
    namedNode = name.type as NamedTypeNode;
  }

  final typeVisitor = TypeDefinitionNodeVisitor();
  schema.accept(typeVisitor);

  final type = typeVisitor.getByName(namedNode.name.value);

  return type;
}

/// Build a string representing a Dart type, given a GraphQL type.
String buildTypeString(
  Node node,
  GeneratorOptions options, {
  bool dartType = true,
  String replaceLeafWith,
  String prefix = '',
  DocumentNode schema,
}) {
  if (node is NamedTypeNode) {
    final typeVisitor = TypeDefinitionNodeVisitor();
    schema.accept(typeVisitor);
    final type = typeVisitor.getByName(node.name.value);

    final scalar = getSingleScalarMap(options, node.name.value);
    final dartTypeValue = dartType ? scalar.dartType.name : scalar.graphQLType;

    if (type != null) {
      if (type is ScalarTypeDefinitionNode) {
        return dartTypeValue;
      }

      if (type is EnumTypeDefinitionNode) {
        return type.name.value;
      }

      if (replaceLeafWith != null) {
        return '$prefix$replaceLeafWith';
      } else {
        return '$prefix${type.name.value}';
      }
    }

    return dartTypeValue;
  }

  if (node is ListTypeNode) {
    return 'List<${buildTypeString(node.type, options, dartType: dartType, replaceLeafWith: replaceLeafWith, prefix: prefix, schema: schema)}>';
  }

  throw Exception('Unable to build type string');
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
ScalarMap getSingleScalarMap(GeneratorOptions options, String type) =>
    options.scalarMapping
        .followedBy(_defaultScalarMapping.values)
        .firstWhere((m) => m.graphQLType == type,
            orElse: () => ScalarMap(
                  graphQLType: type,
                  dartType: DartType(name: type),
                ));
