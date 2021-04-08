import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:json_annotation/json_annotation.dart';

/// A GraphQL query abstraction. This class should be extended automatically
/// by Artemis and used with [ArtemisClient].
abstract class GraphQLQuery<T, U extends JsonSerializable> extends Equatable {
  /// Instantiates a query or mutation.
  GraphQLQuery({this.variables});

  /// Typed query/mutation variables.
  final U? variables;

  /// AST representation of the document to be executed.
  late final DocumentNode document;

  /// Operation name used for this query/mutation.
  final String? operationName = null;

  /// Parses a JSON map into the response type.
  T parse(Map<String, dynamic> json);

  /// Get variables as a JSON map.
  Map<String, dynamic> getVariablesMap() => variables?.toJson() ?? {};
}
