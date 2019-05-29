// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

GraphQLType _$GraphQLTypeFromJson(Map<String, dynamic> json) {
  return GraphQLType(
      kind: _$enumDecodeNullable(_$GraphQLTypeKindEnumMap, json['kind']),
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
              : GraphQLInputValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      interfaces: (json['interfaces'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLType.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      enumValues: (json['enumValues'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLEnumValue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      possibleTypes: (json['possibleTypes'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLType.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLTypeToJson(GraphQLType instance) =>
    <String, dynamic>{
      'kind': _$GraphQLTypeKindEnumMap[instance.kind],
      'name': instance.name,
      'description': instance.description,
      'fields': instance.fields,
      'inputFields': instance.inputFields,
      'interfaces': instance.interfaces,
      'enumValues': instance.enumValues,
      'possibleTypes': instance.possibleTypes
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$GraphQLTypeKindEnumMap = <GraphQLTypeKind, dynamic>{
  GraphQLTypeKind.SCALAR: 'SCALAR',
  GraphQLTypeKind.OBJECT: 'OBJECT',
  GraphQLTypeKind.INTERFACE: 'INTERFACE',
  GraphQLTypeKind.UNION: 'UNION',
  GraphQLTypeKind.ENUM: 'ENUM',
  GraphQLTypeKind.INPUT_OBJECT: 'INPUT_OBJECT',
  GraphQLTypeKind.LIST: 'LIST',
  GraphQLTypeKind.NON_NULL: 'NON_NULL'
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
          : GraphQLType.fromJson(json['type'] as Map<String, dynamic>),
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

GraphQLInputValue _$GraphQLInputValueFromJson(Map<String, dynamic> json) {
  return GraphQLInputValue(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] == null
          ? null
          : GraphQLType.fromJson(json['type'] as Map<String, dynamic>),
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
      locations: (json['locations'] as List)
          ?.map((e) => e == null
              ? null
              : GraphQLInputValue.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GraphQLDirectiveToJson(GraphQLDirective instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'args': instance.args,
      'locations': instance.locations
          ?.map((e) => _$GraphQLDirectiveLocationEnumMap[e])
          ?.toList()
    };

const _$GraphQLDirectiveLocationEnumMap = <GraphQLDirectiveLocation, dynamic>{
  GraphQLDirectiveLocation.QUERY: 'QUERY',
  GraphQLDirectiveLocation.MUTATION: 'MUTATION',
  GraphQLDirectiveLocation.SUBSCRIPTION: 'SUBSCRIPTION',
  GraphQLDirectiveLocation.FIELD: 'FIELD',
  GraphQLDirectiveLocation.FRAGMENT_DEFINITION: 'FRAGMENT_DEFINITION',
  GraphQLDirectiveLocation.FRAGMENT_SPREAD: 'FRAGMENT_SPREAD',
  GraphQLDirectiveLocation.INLINE_FRAGMENT: 'INLINE_FRAGMENT',
  GraphQLDirectiveLocation.VARIABLE_DEFINITION: 'VARIABLE_DEFINITION',
  GraphQLDirectiveLocation.SCHEMA: 'SCHEMA',
  GraphQLDirectiveLocation.SCALAR: 'SCALAR',
  GraphQLDirectiveLocation.OBJECT: 'OBJECT',
  GraphQLDirectiveLocation.FIELD_DEFINITION: 'FIELD_DEFINITION',
  GraphQLDirectiveLocation.ARGUMENT_DEFINITION: 'ARGUMENT_DEFINITION',
  GraphQLDirectiveLocation.INTERFACE: 'INTERFACE',
  GraphQLDirectiveLocation.UNION: 'UNION',
  GraphQLDirectiveLocation.ENUM: 'ENUM',
  GraphQLDirectiveLocation.ENUM_VALUE: 'ENUM_VALUE',
  GraphQLDirectiveLocation.INPUT_OBJECT: 'INPUT_OBJECT',
  GraphQLDirectiveLocation.INPUT_FIELD_DEFINITION: 'INPUT_FIELD_DEFINITION'
};
