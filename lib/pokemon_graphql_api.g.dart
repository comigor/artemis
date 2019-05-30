// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_graphql_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query _$QueryFromJson(Map<String, dynamic> json) {
  return Query()
    ..query = json['query'] == null
        ? null
        : Query.fromJson(json['query'] as Map<String, dynamic>)
    ..pokemons = (json['pokemons'] as List)
        ?.map((e) =>
            e == null ? null : Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pokemon = json['pokemon'] == null
        ? null
        : Pokemon.fromJson(json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      'query': instance.query,
      'pokemons': instance.pokemons,
      'pokemon': instance.pokemon
    };

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon()
    ..id = json['id'] as String
    ..number = json['number'] as String
    ..name = json['name'] as String
    ..weight = json['weight'] == null
        ? null
        : PokemonDimension.fromJson(json['weight'] as Map<String, dynamic>)
    ..height = json['height'] == null
        ? null
        : PokemonDimension.fromJson(json['height'] as Map<String, dynamic>)
    ..classification = json['classification'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList()
    ..resistant = (json['resistant'] as List)?.map((e) => e as String)?.toList()
    ..attacks = json['attacks'] == null
        ? null
        : PokemonAttack.fromJson(json['attacks'] as Map<String, dynamic>)
    ..weaknesses =
        (json['weaknesses'] as List)?.map((e) => e as String)?.toList()
    ..fleeRate = (json['fleeRate'] as num)?.toDouble()
    ..maxCP = json['maxCP'] as int
    ..evolutions = (json['evolutions'] as List)
        ?.map((e) =>
            e == null ? null : Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..evolutionRequirements = json['evolutionRequirements'] == null
        ? null
        : PokemonEvolutionRequirement.fromJson(
            json['evolutionRequirements'] as Map<String, dynamic>)
    ..maxHP = json['maxHP'] as int
    ..image = json['image'] as String;
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'name': instance.name,
      'weight': instance.weight,
      'height': instance.height,
      'classification': instance.classification,
      'types': instance.types,
      'resistant': instance.resistant,
      'attacks': instance.attacks,
      'weaknesses': instance.weaknesses,
      'fleeRate': instance.fleeRate,
      'maxCP': instance.maxCP,
      'evolutions': instance.evolutions,
      'evolutionRequirements': instance.evolutionRequirements,
      'maxHP': instance.maxHP,
      'image': instance.image
    };

PokemonDimension _$PokemonDimensionFromJson(Map<String, dynamic> json) {
  return PokemonDimension()
    ..minimum = json['minimum'] as String
    ..maximum = json['maximum'] as String;
}

Map<String, dynamic> _$PokemonDimensionToJson(PokemonDimension instance) =>
    <String, dynamic>{'minimum': instance.minimum, 'maximum': instance.maximum};

PokemonAttack _$PokemonAttackFromJson(Map<String, dynamic> json) {
  return PokemonAttack()
    ..fast = (json['fast'] as List)
        ?.map((e) =>
            e == null ? null : Attack.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..special = (json['special'] as List)
        ?.map((e) =>
            e == null ? null : Attack.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PokemonAttackToJson(PokemonAttack instance) =>
    <String, dynamic>{'fast': instance.fast, 'special': instance.special};

Attack _$AttackFromJson(Map<String, dynamic> json) {
  return Attack()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..damage = json['damage'] as int;
}

Map<String, dynamic> _$AttackToJson(Attack instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'damage': instance.damage
    };

PokemonEvolutionRequirement _$PokemonEvolutionRequirementFromJson(
    Map<String, dynamic> json) {
  return PokemonEvolutionRequirement()
    ..amount = json['amount'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$PokemonEvolutionRequirementToJson(
        PokemonEvolutionRequirement instance) =>
    <String, dynamic>{'amount': instance.amount, 'name': instance.name};

__Schema _$__SchemaFromJson(Map<String, dynamic> json) {
  return __Schema()
    ..types = (json['types'] as List)
        ?.map((e) =>
            e == null ? null : __Type.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..queryType = json['queryType'] == null
        ? null
        : __Type.fromJson(json['queryType'] as Map<String, dynamic>)
    ..mutationType = json['mutationType'] == null
        ? null
        : __Type.fromJson(json['mutationType'] as Map<String, dynamic>)
    ..subscriptionType = json['subscriptionType'] == null
        ? null
        : __Type.fromJson(json['subscriptionType'] as Map<String, dynamic>)
    ..directives = (json['directives'] as List)
        ?.map((e) =>
            e == null ? null : __Directive.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$__SchemaToJson(__Schema instance) => <String, dynamic>{
      'types': instance.types,
      'queryType': instance.queryType,
      'mutationType': instance.mutationType,
      'subscriptionType': instance.subscriptionType,
      'directives': instance.directives
    };

__Type _$__TypeFromJson(Map<String, dynamic> json) {
  return __Type()
    ..kind = _$enumDecodeNullable(_$__TypeKindEnumMap, json['kind'])
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..fields = (json['fields'] as List)
        ?.map((e) =>
            e == null ? null : __Field.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..interfaces = (json['interfaces'] as List)
        ?.map((e) =>
            e == null ? null : __Type.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..possibleTypes = (json['possibleTypes'] as List)
        ?.map((e) =>
            e == null ? null : __Type.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..enumValues = (json['enumValues'] as List)
        ?.map((e) =>
            e == null ? null : __EnumValue.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..inputFields = (json['inputFields'] as List)
        ?.map((e) =>
            e == null ? null : __InputValue.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ofType = json['ofType'] == null
        ? null
        : __Type.fromJson(json['ofType'] as Map<String, dynamic>);
}

Map<String, dynamic> _$__TypeToJson(__Type instance) => <String, dynamic>{
      'kind': _$__TypeKindEnumMap[instance.kind],
      'name': instance.name,
      'description': instance.description,
      'fields': instance.fields,
      'interfaces': instance.interfaces,
      'possibleTypes': instance.possibleTypes,
      'enumValues': instance.enumValues,
      'inputFields': instance.inputFields,
      'ofType': instance.ofType
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

const _$__TypeKindEnumMap = <__TypeKind, dynamic>{
  __TypeKind.SCALAR: 'SCALAR',
  __TypeKind.OBJECT: 'OBJECT',
  __TypeKind.INTERFACE: 'INTERFACE',
  __TypeKind.UNION: 'UNION',
  __TypeKind.ENUM: 'ENUM',
  __TypeKind.INPUT_OBJECT: 'INPUT_OBJECT',
  __TypeKind.LIST: 'LIST',
  __TypeKind.NON_NULL: 'NON_NULL'
};

__Field _$__FieldFromJson(Map<String, dynamic> json) {
  return __Field()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..args = (json['args'] as List)
        ?.map((e) =>
            e == null ? null : __InputValue.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = json['type'] == null
        ? null
        : __Type.fromJson(json['type'] as Map<String, dynamic>)
    ..isDeprecated = json['isDeprecated'] as bool
    ..deprecationReason = json['deprecationReason'] as String;
}

Map<String, dynamic> _$__FieldToJson(__Field instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'args': instance.args,
      'type': instance.type,
      'isDeprecated': instance.isDeprecated,
      'deprecationReason': instance.deprecationReason
    };

__InputValue _$__InputValueFromJson(Map<String, dynamic> json) {
  return __InputValue()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..type = json['type'] == null
        ? null
        : __Type.fromJson(json['type'] as Map<String, dynamic>)
    ..defaultValue = json['defaultValue'] as String;
}

Map<String, dynamic> _$__InputValueToJson(__InputValue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'defaultValue': instance.defaultValue
    };

__EnumValue _$__EnumValueFromJson(Map<String, dynamic> json) {
  return __EnumValue()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..isDeprecated = json['isDeprecated'] as bool
    ..deprecationReason = json['deprecationReason'] as String;
}

Map<String, dynamic> _$__EnumValueToJson(__EnumValue instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isDeprecated': instance.isDeprecated,
      'deprecationReason': instance.deprecationReason
    };

__Directive _$__DirectiveFromJson(Map<String, dynamic> json) {
  return __Directive()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..locations = (json['locations'] as List)
        ?.map((e) => _$enumDecodeNullable(_$__DirectiveLocationEnumMap, e))
        ?.toList()
    ..args = (json['args'] as List)
        ?.map((e) =>
            e == null ? null : __InputValue.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..onOperation = json['onOperation'] as bool
    ..onFragment = json['onFragment'] as bool
    ..onField = json['onField'] as bool;
}

Map<String, dynamic> _$__DirectiveToJson(__Directive instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'locations': instance.locations
          ?.map((e) => _$__DirectiveLocationEnumMap[e])
          ?.toList(),
      'args': instance.args,
      'onOperation': instance.onOperation,
      'onFragment': instance.onFragment,
      'onField': instance.onField
    };

const _$__DirectiveLocationEnumMap = <__DirectiveLocation, dynamic>{
  __DirectiveLocation.QUERY: 'QUERY',
  __DirectiveLocation.MUTATION: 'MUTATION',
  __DirectiveLocation.SUBSCRIPTION: 'SUBSCRIPTION',
  __DirectiveLocation.FIELD: 'FIELD',
  __DirectiveLocation.FRAGMENT_DEFINITION: 'FRAGMENT_DEFINITION',
  __DirectiveLocation.FRAGMENT_SPREAD: 'FRAGMENT_SPREAD',
  __DirectiveLocation.INLINE_FRAGMENT: 'INLINE_FRAGMENT',
  __DirectiveLocation.SCHEMA: 'SCHEMA',
  __DirectiveLocation.SCALAR: 'SCALAR',
  __DirectiveLocation.OBJECT: 'OBJECT',
  __DirectiveLocation.FIELD_DEFINITION: 'FIELD_DEFINITION',
  __DirectiveLocation.ARGUMENT_DEFINITION: 'ARGUMENT_DEFINITION',
  __DirectiveLocation.INTERFACE: 'INTERFACE',
  __DirectiveLocation.UNION: 'UNION',
  __DirectiveLocation.ENUM: 'ENUM',
  __DirectiveLocation.ENUM_VALUE: 'ENUM_VALUE',
  __DirectiveLocation.INPUT_OBJECT: 'INPUT_OBJECT',
  __DirectiveLocation.INPUT_FIELD_DEFINITION: 'INPUT_FIELD_DEFINITION'
};
