import 'package:json_annotation/json_annotation.dart';

part 'graphql.g.dart';

@JsonSerializable()
class GraphQL {
  final GraphQLSchema data;

  GraphQL({this.data});

  factory GraphQL.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLToJson(this);
}

@JsonSerializable()
class GraphQLSchema {
  final GraphQLType queryType;
  final GraphQLType mutationType;
  final List<GraphQLType> types;
  final List<dynamic> directives;

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    this.types,
    this.directives,
  });

  factory GraphQLSchema.fromJson(Map<String, dynamic> json) =>
      _$GraphQLSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLSchemaToJson(this);
}

@JsonSerializable()
class GraphQLType {
  final String kind;
  final String name;
  final String description;
  final List<GraphQLField> fields;
  final List<dynamic> inputFields;
  final List<dynamic> interfaces;
  final List<GraphQLEnumValue> enumValues;
  final List<dynamic> possibleTypes;

  GraphQLType({
    this.kind,
    this.name,
    this.description,
    this.fields,
    this.inputFields,
    this.interfaces,
    this.enumValues,
    this.possibleTypes,
  });

  factory GraphQLType.fromJson(Map<String, dynamic> json) =>
      _$GraphQLTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLTypeToJson(this);
}

@JsonSerializable()
class GraphQLEnumValue {
  final String name;
  final String description;
  final bool isDeprecated;
  final String deprecatedReason;

  GraphQLEnumValue({
    this.name,
    this.description,
    this.isDeprecated,
    this.deprecatedReason,
  });

  factory GraphQLEnumValue.fromJson(Map<String, dynamic> json) =>
      _$GraphQLEnumValueFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLEnumValueToJson(this);
}

@JsonSerializable()
class GraphQLField {
  final String name;
  final String description;
  final List<dynamic> args;
  final GraphQLFieldType type;
  final bool isDeprecated;
  final String deprecatedReason;

  GraphQLField({
    this.name,
    this.description,
    this.args,
    this.type,
    this.isDeprecated,
    this.deprecatedReason,
  });

  factory GraphQLField.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFieldFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLFieldToJson(this);
}

@JsonSerializable()
class GraphQLFieldType {
  final String kind;
  final String name;
  final GraphQLFieldType ofType;

  GraphQLFieldType({
    this.kind,
    this.name,
    this.ofType,
  });

  factory GraphQLFieldType.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFieldTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLFieldTypeToJson(this);
}
