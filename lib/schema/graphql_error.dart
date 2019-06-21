import 'package:json_annotation/json_annotation.dart';

// I can't use the default json_serializable flow because the artemis generator
// would crash when importing graphql.dart file.
part 'graphql_error.g2.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GraphQLError {
  final String message;
  final List<GraphQLErrorLocation> locations;
  final List<String> queryPath;

  GraphQLError({
    this.message,
    List<GraphQLErrorLocation> locations,
    List<String> queryPath,
  })  : locations = locations ?? <GraphQLErrorLocation>[],
        queryPath = queryPath ?? <String>[];

  factory GraphQLError.fromJson(Map<String, dynamic> json) =>
      _$GraphQLErrorFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLErrorToJson(this);
}

@JsonSerializable()
class GraphQLErrorLocation {
  final int line;
  final int column;

  GraphQLErrorLocation({
    this.line,
    this.column,
  });

  factory GraphQLErrorLocation.fromJson(Map<String, dynamic> json) =>
      _$GraphQLErrorLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLErrorLocationToJson(this);
}

@JsonSerializable()
class GraphQLResponse<T> {
  @JsonKey(ignore: true)
  T data;
  final List<GraphQLError> errors;

  bool get hasErrors => errors.isNotEmpty;

  GraphQLResponse({
    this.data,
    List<GraphQLError> errors,
  }) : errors = errors ?? <GraphQLError>[];

  factory GraphQLResponse.fromJson(Map<String, dynamic> json) =>
      _$GraphQLResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLResponseToJson(this);
}
