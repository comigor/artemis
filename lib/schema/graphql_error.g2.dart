// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLError _$GraphQLErrorFromJson(Map<String, dynamic> json) {
  return GraphQLError(
      message: json['message'] as String,
      locations: (json['locations'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLErrorLocation.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      queryPath:
          (json['query_path'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$GraphQLErrorToJson(GraphQLError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'locations': instance.locations,
      'query_path': instance.queryPath
    };

GraphQLErrorLocation _$GraphQLErrorLocationFromJson(Map<String, dynamic> json) {
  return GraphQLErrorLocation(
      line: json['line'] as int, column: json['column'] as int);
}

Map<String, dynamic> _$GraphQLErrorLocationToJson(
        GraphQLErrorLocation instance) =>
    <String, dynamic>{'line': instance.line, 'column': instance.column};

GraphQLResponse<T> _$GraphQLResponseFromJson<T>(Map<String, dynamic> json) {
  return GraphQLResponse<T>(
      errors: (json['errors'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLError.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLResponseToJson<T>(GraphQLResponse<T> instance) =>
    <String, dynamic>{'errors': instance.errors};
