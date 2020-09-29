// @dart = 2.8

import 'package:gql/ast.dart';

/// Visits all object definition nodes recursively
class ObjectTypeDefinitionVisitor extends RecursiveVisitor {
  /// Stores all object definition nodes
  Iterable<ObjectTypeDefinitionNode> types = [];

  @override
  void visitObjectTypeDefinitionNode(
    ObjectTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitObjectTypeDefinitionNode(node);
  }

  /// Gets object type definition node by operation name
  ObjectTypeDefinitionNode getByName(String name) {
    final type = types.where((type) => type.name.value == name);

    if (type.isNotEmpty) {
      return type.first;
    }

    return null;
  }
}
