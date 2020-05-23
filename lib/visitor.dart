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

/// Visits the schema definition node.
class SchemaDefinitionVisitor extends RecursiveVisitor {
  /// Store the schema definition.
  SchemaDefinitionNode schemaDefinitionNode;

  @override
  void visitSchemaDefinitionNode(
    SchemaDefinitionNode node,
  ) {
    schemaDefinitionNode = node;
  }
}

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
  OperationTypeDefinitionNode getByType(OperationType operationType) {
    final type = types.where((type) => type.operation == operationType);

    if (type.isNotEmpty) {
      return type.first;
    }

    return null;
  }
}

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
  TypeDefinitionNode getByName(String name) {
    final type = types.where((type) => type.name.value == name);

    if (type.isNotEmpty) {
      return type.first;
    }

    return null;
  }
}
