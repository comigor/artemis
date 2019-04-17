// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQL _$GraphQLFromJson(Map<String, dynamic> json) {
  return GraphQL(
      data: json['data'] == null
          ? null
          : GraphQLSchema.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GraphQLToJson(GraphQL instance) =>
    <String, dynamic>{'data': instance.data};

GraphQLSchema _$GraphQLSchemaFromJson(Map<String, dynamic> json) {
  return GraphQLSchema(
      queryType: json['queryType'] == null
          ? null
          : GraphQLType.fromJson(json['queryType'] as Map<String, dynamic>),
      mutationType: json['mutationType'] == null
          ? null
          : GraphQLType.fromJson(json['mutationType'] as Map<String, dynamic>),
      types: (json['types'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLType.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      directives: json['directives'] as List);
}

Map<String, dynamic> _$GraphQLSchemaToJson(GraphQLSchema instance) =>
    <String, dynamic>{
      'queryType': instance.queryType,
      'mutationType': instance.mutationType,
      'types': instance.types,
      'directives': instance.directives
    };

GraphQLType _$GraphQLTypeFromJson(Map<String, dynamic> json) {
  return GraphQLType(
      kind: json['kind'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      fields: (json['fields'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLField.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      inputFields: (json['inputFields'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLField.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      interfaces: (json['interfaces'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLFieldType.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      enumValues: (json['enumValues'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLEnumValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      possibleTypes: (json['possibleTypes'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLFieldType.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLTypeToJson(GraphQLType instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'name': instance.name,
      'description': instance.description,
      'fields': instance.fields,
      'inputFields': instance.inputFields,
      'interfaces': instance.interfaces,
      'enumValues': instance.enumValues,
      'possibleTypes': instance.possibleTypes
    };

GraphQLEnumValue _$GraphQLEnumValueFromJson(Map<String, dynamic> json) {
  return GraphQLEnumValue(
      name: json['name'] as String,
      description: json['description'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      deprecatedReason: json['deprecatedReason'] as String);
}

Map<String, dynamic> _$GraphQLEnumValueToJson(GraphQLEnumValue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isDeprecated': instance.isDeprecated,
      'deprecatedReason': instance.deprecatedReason
    };

GraphQLField _$GraphQLFieldFromJson(Map<String, dynamic> json) {
  return GraphQLField(
      name: json['name'] as String,
      description: json['description'] as String,
      args: (json['args'] as List)
          ?.map((e) =>
              e == null ? null : GraphQLArg.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      type: json['type'] == null
          ? null
          : GraphQLFieldType.fromJson(json['type'] as Map<String, dynamic>),
      isDeprecated: json['isDeprecated'] as bool,
      deprecatedReason: json['deprecatedReason'] as String);
}

Map<String, dynamic> _$GraphQLFieldToJson(GraphQLField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'args': instance.args,
      'type': instance.type,
      'isDeprecated': instance.isDeprecated,
      'deprecatedReason': instance.deprecatedReason
    };

GraphQLFieldType _$GraphQLFieldTypeFromJson(Map<String, dynamic> json) {
  return GraphQLFieldType(
      kind: json['kind'] as String,
      name: json['name'] as String,
      ofType: json['ofType'] == null
          ? null
          : GraphQLFieldType.fromJson(json['ofType'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GraphQLFieldTypeToJson(GraphQLFieldType instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'name': instance.name,
      'ofType': instance.ofType
    };

GraphQLArg _$GraphQLArgFromJson(Map<String, dynamic> json) {
  return GraphQLArg(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] == null
          ? null
          : GraphQLFieldType.fromJson(json['type'] as Map<String, dynamic>),
      defaultValue: json['defaultValue'] as String);
}

Map<String, dynamic> _$GraphQLArgToJson(GraphQLArg instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'defaultValue': instance.defaultValue
    };
