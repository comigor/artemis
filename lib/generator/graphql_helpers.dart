import 'package:artemis/generator/errors.dart';
import 'package:artemis/visitor/type_definition_node_visitor.dart';
import 'package:gql/ast.dart';

import '../generator/data/data.dart';
import '../schema/options.dart';
import 'data/definition.dart';

/// Get a full [TypeDefinitionNode] from a type node.
TypeDefinitionNode getTypeByName(DocumentNode schema, TypeNode typeNode,
    {String? context}) {
  late NamedTypeNode namedNode;

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
  Name? replaceLeafWith,
  DocumentNode? schema,
}) {
  if (node is NamedTypeNode) {
    final typeVisitor = TypeDefinitionNodeVisitor();
    schema!.accept(typeVisitor);
    final type = typeVisitor.getByName(node.name.value);

    if (type != null) {
      if (type is ScalarTypeDefinitionNode) {
        final scalar = getSingleScalarMap(options, node.name.value);
        final dartTypeValue = scalar?.dartType;
        final graphQLTypeValue = scalar?.graphQLType;

        if (dartType && dartTypeValue != null && dartTypeValue.name != null) {
          return TypeName(
            name: dartTypeValue.name!,
            isNonNull: node.isNonNull,
          );
        } else if (graphQLTypeValue != null) {
          return TypeName(
            name: graphQLTypeValue,
            isNonNull: node.isNonNull,
          );
        }
      }

      if (type is EnumTypeDefinitionNode ||
          type is InputObjectTypeDefinitionNode) {
        return TypeName(name: type.name.value, isNonNull: node.isNonNull);
      }

      if (replaceLeafWith != null) {
        return TypeName(name: replaceLeafWith.name, isNonNull: node.isNonNull);
      } else {
        return TypeName(name: type.name.value, isNonNull: node.isNonNull);
      }
    }

    return TypeName(name: node.name.value, isNonNull: node.isNonNull);
  }

  if (node is ListTypeNode) {
    final typeName = buildTypeName(node.type, options,
        dartType: dartType, replaceLeafWith: replaceLeafWith, schema: schema);
    return ListOfTypeName(
      typeName: typeName,
      isNonNull: node.isNonNull,
    );
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
ScalarMap? getSingleScalarMap(GeneratorOptions options, String type,
    {bool throwOnNotFound = true}) {
  final scalarMap =
      options.scalarMapping.followedBy(_defaultScalarMapping.values).firstWhere(
            (m) => m!.graphQLType == type,
            orElse: () => null,
          );

  if (throwOnNotFound && scalarMap == null) {
    throw MissingScalarConfigurationException(type);
  }

  return scalarMap;
}

/// Retrieve imports of a scalar map.
Iterable<String> importsOfScalar(GeneratorOptions options, String type) {
  final scalarMapping = options.scalarMapping.firstWhere(
    (m) => m!.graphQLType == type,
    orElse: () => null,
  );

  final customParserImport = scalarMapping?.customParserImport;

  final result = List<String>.from(scalarMapping?.dartType?.imports ?? []);

  if (customParserImport != null) {
    result.add(customParserImport);
  }

  return result;
}
