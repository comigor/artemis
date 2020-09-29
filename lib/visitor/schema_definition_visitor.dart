// @dart = 2.8

import 'package:gql/ast.dart';

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
