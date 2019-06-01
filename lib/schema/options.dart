import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true)
class GeneratorOptions {
  final String customParserImport;
  @JsonKey(
    defaultValue: [],
  )
  final List<ScalarMap> scalarMapping;

  GeneratorOptions({
    this.customParserImport,
    this.scalarMapping,
  });

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorOptionsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ScalarMap {
  @JsonKey(name: 'graphql_type')
  final String graphQLType;
  final String dartType;
  @JsonKey(defaultValue: false)
  final bool useCustomParsers;

  ScalarMap({
    this.graphQLType,
    this.dartType,
    this.useCustomParsers = false,
  });

  factory ScalarMap.fromJson(Map<String, dynamic> json) =>
      _$ScalarMapFromJson(json);

  Map<String, dynamic> toJson() => _$ScalarMapToJson(this);
}
