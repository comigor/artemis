import 'package:json_annotation/json_annotation.dart';

part 'graphql.g.dart';

@JsonSerializable()
class GraphQLSchema {
  final GraphQLType queryType;
  final GraphQLType mutationType;
  final List<GraphQLType> types;
  final List<dynamic> directives;

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    List<GraphQLType> types,
    List<dynamic> directives,
  })  : types = types ?? <GraphQLType>[],
        directives = directives ?? <dynamic>[];

  factory GraphQLSchema.fromJson(Map<String, dynamic> json) =>
      _$GraphQLSchemaFromJson(json['data']['__schema']);

  Map<String, dynamic> toJson() => _$GraphQLSchemaToJson(this);
}

@JsonSerializable()
class GraphQLType {
  final String kind;
  final String name;
  final String description;
  final List<GraphQLField> fields;
  final List<GraphQLField> inputFields;
  final List<GraphQLFieldType> interfaces;
  final List<GraphQLEnumValue> enumValues;
  final List<GraphQLFieldType> possibleTypes;

  GraphQLType({
    this.kind,
    this.name,
    this.description,
    List<GraphQLField> fields,
    List<GraphQLField> inputFields,
    List<GraphQLFieldType> interfaces,
    List<GraphQLEnumValue> enumValues,
    List<GraphQLFieldType> possibleTypes,
  })  : fields = fields ?? <GraphQLField>[],
        inputFields = inputFields ?? <GraphQLField>[],
        interfaces = interfaces ?? <GraphQLFieldType>[],
        enumValues = enumValues ?? <GraphQLEnumValue>[],
        possibleTypes = possibleTypes ?? <GraphQLFieldType>[];

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
  final List<GraphQLArg> args;
  final GraphQLFieldType type;
  final bool isDeprecated;
  final String deprecatedReason;

  GraphQLField({
    this.name,
    this.description,
    List<GraphQLArg> args,
    this.type,
    this.isDeprecated,
    this.deprecatedReason,
  }) : args = args ?? <GraphQLArg>[];

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

@JsonSerializable()
class GraphQLArg {
  final String name;
  final String description;
  final GraphQLFieldType type;
  final String defaultValue;

  GraphQLArg({
    this.name,
    this.description,
    this.type,
    this.defaultValue,
  });

  factory GraphQLArg.fromJson(Map<String, dynamic> json) =>
      _$GraphQLArgFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLArgToJson(this);
}
