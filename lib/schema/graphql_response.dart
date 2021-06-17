import 'package:gql_exec/gql_exec.dart';

/// Encapsulates a GraphQL query/mutation response from server, with typed
/// input and responses, and errors.
class GraphQLResponse<T> {
  /// The typed data of this response.
  final T? data;

  /// The list of errors in this response.
  final List<GraphQLError>? errors;

  /// If this response has any error.
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  /// The [Context] of the [Response]
  final Context? context;

  /// Instantiates a GraphQL response.
  const GraphQLResponse({
    this.data,
    this.errors,
    this.context,
  });
}
