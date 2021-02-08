import 'package:gql/ast.dart';

List<TypeDefinitionNode> _defaultScalars =
    ['Boolean', 'Float', 'ID', 'Int', 'String']
        .map((e) => ScalarTypeDefinitionNode(
              name: NameNode(value: e),
            ))
        .toList();

/// Visits all type definition nodes recursively
class TypeDefinitionNodeVisitor extends RecursiveVisitor {
  /// Stores all type definition nodes
  Iterable<TypeDefinitionNode> types = [..._defaultScalars];

  @override
  void visitObjectTypeDefinitionNode(
    ObjectTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitObjectTypeDefinitionNode(node);
  }

  @override
  void visitScalarTypeDefinitionNode(
    ScalarTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitScalarTypeDefinitionNode(node);
  }

  @override
  void visitInterfaceTypeDefinitionNode(
    InterfaceTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitInterfaceTypeDefinitionNode(node);
  }

  @override
  void visitUnionTypeDefinitionNode(
    UnionTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitUnionTypeDefinitionNode(node);
  }

  @override
  void visitInputObjectTypeDefinitionNode(
    InputObjectTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitInputObjectTypeDefinitionNode(node);
  }

  @override
  void visitEnumTypeDefinitionNode(
    EnumTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitEnumTypeDefinitionNode(node);
  }

  /// Gets type definition node by type name
  TypeDefinitionNode? getByName(String name) {
    final type = types.where((type) => type.name!.value == name);

    if (type.isNotEmpty) {
      return type.first;
    }

    return null;
  }
}
