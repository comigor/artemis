import 'package:json_annotation/json_annotation.dart';

part 'graphql.g.dart';

// https://gist.github.com/craigbeck/b90915d49fda19d5b2b17ead14dcd6da

@JsonSerializable()
class GraphQLSchema {
  final GraphQLFullType queryType;
  final GraphQLFullType mutationType;
  final List<GraphQLFullType> types;
  final List<GraphQLDirective> directives;

  GraphQLSchema({
    this.queryType,
    this.mutationType,
    List<GraphQLFullType> types,
    List<GraphQLDirective> directives,
  })  : types = types ?? <GraphQLFullType>[],
        directives = directives ?? <GraphQLDirective>[];

  factory GraphQLSchema.fromJson(Map<String, dynamic> json) =>
      _$GraphQLSchemaFromJson(json['data']['__schema']);

  Map<String, dynamic> toJson() => _$GraphQLSchemaToJson(this);
}

@JsonSerializable()
class GraphQLFullType {
  final String kind;
  final String name;
  final String description;
  final List<GraphQLField> fields;
  final List<GraphQLField> inputFields;
  final List<GraphQLTypeRef> interfaces;
  final List<GraphQLEnumValue> enumValues;
  final List<GraphQLTypeRef> possibleTypes;

  GraphQLFullType({
    this.kind,
    this.name,
    this.description,
    List<GraphQLField> fields,
    List<GraphQLField> inputFields,
    List<GraphQLTypeRef> interfaces,
    List<GraphQLEnumValue> enumValues,
    List<GraphQLTypeRef> possibleTypes,
  })  : fields = fields ?? <GraphQLField>[],
        inputFields = inputFields ?? <GraphQLField>[],
        interfaces = interfaces ?? <GraphQLTypeRef>[],
        enumValues = enumValues ?? <GraphQLEnumValue>[],
        possibleTypes = possibleTypes ?? <GraphQLTypeRef>[];

  factory GraphQLFullType.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFullTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLFullTypeToJson(this);
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
  final List<GraphQLInputValue> args;
  final GraphQLTypeRef type;
  final bool isDeprecated;
  final String deprecatedReason;

  GraphQLField({
    this.name,
    this.description,
    List<GraphQLInputValue> args,
    this.type,
    this.isDeprecated,
    this.deprecatedReason,
  }) : args = args ?? <GraphQLInputValue>[];

  factory GraphQLField.fromJson(Map<String, dynamic> json) =>
      _$GraphQLFieldFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLFieldToJson(this);
}

@JsonSerializable()
class GraphQLTypeRef {
  final String kind;
  final String name;
  final GraphQLTypeRef ofType;

  GraphQLTypeRef({
    this.kind,
    this.name,
    this.ofType,
  });

  factory GraphQLTypeRef.fromJson(Map<String, dynamic> json) =>
      _$GraphQLTypeRefFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLTypeRefToJson(this);
}

@JsonSerializable()
class GraphQLInputValue {
  final String name;
  final String description;
  final GraphQLTypeRef type;
  final String defaultValue;

  GraphQLInputValue({
    this.name,
    this.description,
    this.type,
    this.defaultValue,
  });

  factory GraphQLInputValue.fromJson(Map<String, dynamic> json) =>
      _$GraphQLInputValueFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLInputValueToJson(this);
}

@JsonSerializable()
class GraphQLDirective {
  final String name;
  final String description;
  List<GraphQLInputValue> args;
  final String onOperation;
  final String onFragment;
  final String onField;

  GraphQLDirective({
    this.name,
    this.description,
    List<GraphQLInputValue> args,
    this.onOperation,
    this.onFragment,
    this.onField,
  }) : args = args ?? <GraphQLInputValue>[];

  factory GraphQLDirective.fromJson(Map<String, dynamic> json) =>
      _$GraphQLDirectiveFromJson(json);

  Map<String, dynamic> toJson() => _$GraphQLDirectiveToJson(this);
}
