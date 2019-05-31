import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeneratorOptions {
  final String import;
  final String scalarMapping;

  GeneratorOptions({
    this.import,
    this.scalarMapping,
  });

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorOptionsToJson(this);
}
