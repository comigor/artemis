// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratorOptions _$GeneratorOptionsFromJson(Map json) {
  return GeneratorOptions(
    generateHelpers: json['generate_helpers'] as bool ?? true,
    scalarMapping: (json['scalar_mapping'] as List)
            ?.map((e) => e == null
                ? null
                : ScalarMap.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
    fragmentsGlob: json['fragments_glob'] as String,
    schemaMapping: (json['schema_mapping'] as List)
            ?.map((e) => e == null
                ? null
                : SchemaMap.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$GeneratorOptionsToJson(GeneratorOptions instance) =>
    <String, dynamic>{
      'generate_helpers': instance.generateHelpers,
      'scalar_mapping': instance.scalarMapping,
      'fragments_glob': instance.fragmentsGlob,
      'schema_mapping': instance.schemaMapping,
    };

DartType _$DartTypeFromJson(Map<String, dynamic> json) {
  return DartType(
    name: json['name'] as String,
    imports: (json['imports'] as List)?.map((e) => e as String)?.toList() ?? [],
  );
}

Map<String, dynamic> _$DartTypeToJson(DartType instance) => <String, dynamic>{
      'name': instance.name,
      'imports': instance.imports,
    };

ScalarMap _$ScalarMapFromJson(Map<String, dynamic> json) {
  return ScalarMap(
    graphQLType: json['graphql_type'] as String,
    dartType:
        json['dart_type'] == null ? null : DartType.fromJson(json['dart_type']),
    customParserImport: json['custom_parser_import'] as String,
  );
}

Map<String, dynamic> _$ScalarMapToJson(ScalarMap instance) => <String, dynamic>{
      'graphql_type': instance.graphQLType,
      'dart_type': instance.dartType,
      'custom_parser_import': instance.customParserImport,
    };

SchemaMap _$SchemaMapFromJson(Map<String, dynamic> json) {
  return SchemaMap(
    output: json['output'] as String,
    schema: json['schema'] as String,
    queriesGlob: json['queries_glob'] as String,
    typeNameField: json['type_name_field'] as String ?? '__typename',
  );
}

Map<String, dynamic> _$SchemaMapToJson(SchemaMap instance) => <String, dynamic>{
      'output': instance.output,
      'schema': instance.schema,
      'queries_glob': instance.queriesGlob,
      'type_name_field': instance.typeNameField,
    };
