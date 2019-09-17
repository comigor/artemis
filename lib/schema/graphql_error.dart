import 'package:json_annotation/json_annotation.dart';

part 'graphql_error.g2.dart';

/// Encapsulates a single GraphQL error, from `errors` key.
@JsonSerializable(fieldRename: FieldRename.snake)
class GraphQLError {
  /// Error message, direct from server response.
  final String message;

  /// Error line location on query.
  final List<GraphQLErrorLocation> locations;

  /// The path on JSON where the error happened.
  final List<String> queryPath;

  /// Instantiates a GraphQL error.
  GraphQLError({
    this.message,
    List<GraphQLErrorLocation> locations,
    List<String> queryPath,
  })  : locations = locations ?? <GraphQLErrorLocation>[],
        queryPath = queryPath ?? <String>[];

  /// Build an error from a JSON map.
  factory GraphQLError.fromJson(Map<String, dynamic> json) =>
      _$GraphQLErrorFromJson(json);

  /// Convert this error back to JSON.
  Map<String, dynamic> toJson() => _$GraphQLErrorToJson(this);
}

/// The location (line and column) of an error.
@JsonSerializable()
class GraphQLErrorLocation {
  /// The error line.
  final int line;

  /// The error column.
  final int column;

  /// Instantiates a GraphQL error location.
  GraphQLErrorLocation({
    this.line,
    this.column,
  });

  /// Build an error location from a JSON map.
  factory GraphQLErrorLocation.fromJson(Map<String, dynamic> json) =>
      _$GraphQLErrorLocationFromJson(json);

  /// Convert this error location back to JSON.
  Map<String, dynamic> toJson() => _$GraphQLErrorLocationToJson(this);
}

/// Encapsulates a GraphQL query/mutation response from server, with typed
/// input and responses, and errors.
@JsonSerializable()
class GraphQLResponse<T> {
  /// The typed data of this response.
  @JsonKey(ignore: true)
  T data;

  /// The list of errors in this response.
  final List<GraphQLError> errors;

  /// If this response has any error.
  bool get hasErrors => errors.isNotEmpty;

  /// Instantiates a GraphQL response.
  GraphQLResponse({
    this.data,
    List<GraphQLError> errors,
  }) : errors = errors ?? <GraphQLError>[];

  /// Build a response from a JSON map.
  factory GraphQLResponse.fromJson(Map<String, dynamic> json) =>
      _$GraphQLResponseFromJson(json);

  /// Convert this GraphQL response back to JSON.
  Map<String, dynamic> toJson() => _$GraphQLResponseToJson(this);
}
