// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map json) {
  return GeneratorOptions(
      customParserImport: json['custom_parser_import'] as String,
      scalarMapping: (json['scalar_mapping'] as List)
              ?.map((e) => e == null
                  ? null
                  : ScalarMap.fromJson((e as Map)?.map(
                      (k, e) => MapEntry(k as String, e),
                    )))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'custom_parser_import': instance.customParserImport,
      'scalar_mapping': instance.scalarMapping
    };

ScalarMap _$ScalarMapFromJson(Map<String, dynamic> json) {
  return ScalarMap(
      graphQLType: json['graphql_type'] as String,
      dartType: json['dart_type'] as String,
      useCustomParsers: json['use_custom_parsers'] as bool ?? false);
}

Map<String, dynamic> _$ScalarMapToJson(ScalarMap instance) => <String, dynamic>{
      'graphql_type': instance.graphQLType,
      'dart_type': instance.dartType,
      'use_custom_parsers': instance.useCustomParsers
    };
