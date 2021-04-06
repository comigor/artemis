import 'package:gql/ast.dart';

/// Visits all operation definition nodes recursively
class OperationTypeDefinitionNodeVisitor extends RecursiveVisitor {
  /// Stores all operation definition nodes
  Iterable<OperationTypeDefinitionNode> types = [];

  @override
  void visitOperationTypeDefinitionNode(
    OperationTypeDefinitionNode node,
  ) {
    types = types.followedBy([node]);
    super.visitOperationTypeDefinitionNode(node);
  }

  /// Gets operation type definition node by operation name
  OperationTypeDefinitionNode? getByType(OperationType operationType) {
    final type = types.where((type) => type.operation == operationType);

    if (type.isNotEmpty) {
      return type.first;
    }

    return null;
  }
}
