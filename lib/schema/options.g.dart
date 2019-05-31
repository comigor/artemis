// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map<String, dynamic> json) {
  return GeneratorOptions(
      scalarMapping: (json['scalar_mapping'] as List)
          ?.map((e) =>
              e == null ? null : ScalarMap.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{'scalar_mapping': instance.scalarMapping};

ScalarMap _$ScalarMapFromJson(Map<String, dynamic> json) {
  return ScalarMap(json['graphql_type'] as String, json['dart_type'] as String,
      json['use_custom_parsers'] as bool ?? false);
}

Map<String, dynamic> _$ScalarMapToJson(ScalarMap instance) => <String, dynamic>{
      'graphql_type': instance.graphQLType,
      'dart_type': instance.dartType,
      'use_custom_parsers': instance.useCustomParsers
    };
