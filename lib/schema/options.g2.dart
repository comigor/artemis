// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map json) {
  return GeneratorOptions(
      prefix: json['prefix'] as String ?? '',
      customParserImport: json['custom_parser_import'] as String,
      generateHelpers: json['generate_helpers'] as bool ?? true,
      scalarMapping: (json['scalar_mapping'] as List)
              ?.map((e) => e == null
                  ? null
                  : ScalarMap.fromJson((e as Map)?.map(
                      (k, e) => MapEntry(k as String, e),
                    )))
              ?.toList() ??
          [],
      schemaMapping: (json['schema_mapping'] as List)
              ?.map((e) => e == null
                  ? null
                  : SchemaMap.fromJson((e as Map)?.map(
                      (k, e) => MapEntry(k as String, e),
                    )))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'custom_parser_import': instance.customParserImport,
      'generate_helpers': instance.generateHelpers,
      'scalar_mapping': instance.scalarMapping,
      'schema_mapping': instance.schemaMapping
    };

ScalarMap _$ScalarMapFromJson(Map<String, dynamic> json) {
  return ScalarMap(
      graphQLType: json['graphql_type'] as String,
      dartType: json['dart_type'] as String,
      useCustomParser: json['use_custom_parser'] as bool ?? false);
}

Map<String, dynamic> _$ScalarMapToJson(ScalarMap instance) => <String, dynamic>{
      'graphql_type': instance.graphQLType,
      'dart_type': instance.dartType,
      'use_custom_parser': instance.useCustomParser
    };

SchemaMap _$SchemaMapFromJson(Map<String, dynamic> json) {
  return SchemaMap(
      schema: json['schema'] as String,
      queriesGlob: json['queries_glob'] as String,
      resolveTypeField:
          json['resolve_type_field'] as String ?? '__resolveType');
}

Map<String, dynamic> _$SchemaMapToJson(SchemaMap instance) => <String, dynamic>{
      'schema': instance.schema,
      'queries_glob': instance.queriesGlob,
      'resolve_type_field': instance.resolveTypeField
    };
