// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLSchema _$GraphQLSchemaFromJson(Map<String, dynamic> json) {
  return GraphQLSchema(
      queryType: json['queryType'] == null
          ? null
          : GraphQLFullType.fromJson(json['queryType'] as Map<String, dynamic>),
      mutationType: json['mutationType'] == null
          ? null
          : GraphQLFullType.fromJson(
              json['mutationType'] as Map<String, dynamic>),
      types: (json['types'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLFullType.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      directives: (json['directives'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLDirective.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLSchemaToJson(GraphQLSchema instance) =>
    <String, dynamic>{
      'queryType': instance.queryType,
      'mutationType': instance.mutationType,
      'types': instance.types,
      'directives': instance.directives
    };

GraphQLFullType _$GraphQLFullTypeFromJson(Map<String, dynamic> json) {
  return GraphQLFullType(
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
              : GraphQLTypeRef.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      enumValues: (json['enumValues'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLEnumValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      possibleTypes: (json['possibleTypes'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLTypeRef.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLFullTypeToJson(GraphQLFullType instance) =>
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
          ?.map((e) => e == null
              ? null
              : GraphQLInputValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      type: json['type'] == null
          ? null
          : GraphQLTypeRef.fromJson(json['type'] as Map<String, dynamic>),
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

GraphQLTypeRef _$GraphQLTypeRefFromJson(Map<String, dynamic> json) {
  return GraphQLTypeRef(
      kind: json['kind'] as String,
      name: json['name'] as String,
      ofType: json['ofType'] == null
          ? null
          : GraphQLTypeRef.fromJson(json['ofType'] as Map<String, dynamic>));
}

Map<String, dynamic> _$GraphQLTypeRefToJson(GraphQLTypeRef instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'name': instance.name,
      'ofType': instance.ofType
    };

GraphQLInputValue _$GraphQLInputValueFromJson(Map<String, dynamic> json) {
  return GraphQLInputValue(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] == null
          ? null
          : GraphQLTypeRef.fromJson(json['type'] as Map<String, dynamic>),
      defaultValue: json['defaultValue'] as String);
}

Map<String, dynamic> _$GraphQLInputValueToJson(GraphQLInputValue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'defaultValue': instance.defaultValue
    };

GraphQLDirective _$GraphQLDirectiveFromJson(Map<String, dynamic> json) {
  return GraphQLDirective(
      name: json['name'] as String,
      description: json['description'] as String,
      args: (json['args'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLInputValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      onOperation: json['onOperation'] as String,
      onFragment: json['onFragment'] as String,
      onField: json['onField'] as String);
}

Map<String, dynamic> _$GraphQLDirectiveToJson(GraphQLDirective instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'args': instance.args,
      'onOperation': instance.onOperation,
      'onFragment': instance.onFragment,
      'onField': instance.onField
    };
