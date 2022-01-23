import 'package:gql/ast.dart';

List<MapEntry<String, TypeDefinitionNode>> _defaultScalars =
    ['Boolean', 'Float', 'ID', 'Int', 'String']
        .map((e) => MapEntry(
            e,
            ScalarTypeDefinitionNode(
              name: NameNode(value: e),
            )))
        .toList();

/// Visits all type definition nodes recursively
class TypeDefinitionNodeVisitor extends RecursiveVisitor {
  /// Stores all type definition nodes
  Map<String, TypeDefinitionNode> types = Map.fromEntries(_defaultScalars);

  @override
  void visitObjectTypeDefinitionNode(
    ObjectTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitObjectTypeDefinitionNode(node);
  }

  @override
  void visitScalarTypeDefinitionNode(
    ScalarTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitScalarTypeDefinitionNode(node);
  }

  @override
  void visitInterfaceTypeDefinitionNode(
    InterfaceTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitInterfaceTypeDefinitionNode(node);
  }

  @override
  void visitUnionTypeDefinitionNode(
    UnionTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitUnionTypeDefinitionNode(node);
  }

  @override
  void visitInputObjectTypeDefinitionNode(
    InputObjectTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitInputObjectTypeDefinitionNode(node);
  }

  @override
  void visitEnumTypeDefinitionNode(
    EnumTypeDefinitionNode node,
  ) {
    types[node.name.value] = node;
    super.visitEnumTypeDefinitionNode(node);
  }

  /// Gets type definition node by type name
  TypeDefinitionNode? getByName(String name) {
    final type = types[name];

    if (type != null) {
      return type;
    }

    return null;
  }
}
