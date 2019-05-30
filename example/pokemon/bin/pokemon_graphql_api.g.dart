// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_graphql_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GQL_Query _$GQL_QueryFromJson(Map<String, dynamic> json) {
  return GQL_Query()
    ..query = json['query'] == null
        ? null
        : GQL_Query.fromJson(json['query'] as Map<String, dynamic>)
    ..pokemons = (json['pokemons'] as List)
        ?.map((e) =>
            e == null ? null : GQL_Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pokemon = json['pokemon'] == null
        ? null
        : GQL_Pokemon.fromJson(json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GQL_QueryToJson(GQL_Query instance) => <String, dynamic>{
      'query': instance.query,
      'pokemons': instance.pokemons,
      'pokemon': instance.pokemon
    };

GQL_Pokemon _$GQL_PokemonFromJson(Map<String, dynamic> json) {
  return GQL_Pokemon()
    ..id = json['id'] as String
    ..number = json['number'] as String
    ..name = json['name'] as String
    ..weight = json['weight'] == null
        ? null
        : GQL_PokemonDimension.fromJson(json['weight'] as Map<String, dynamic>)
    ..height = json['height'] == null
        ? null
        : GQL_PokemonDimension.fromJson(json['height'] as Map<String, dynamic>)
    ..classification = json['classification'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList()
    ..resistant = (json['resistant'] as List)?.map((e) => e as String)?.toList()
    ..attacks = json['attacks'] == null
        ? null
        : GQL_PokemonAttack.fromJson(json['attacks'] as Map<String, dynamic>)
    ..weaknesses =
        (json['weaknesses'] as List)?.map((e) => e as String)?.toList()
    ..fleeRate = (json['fleeRate'] as num)?.toDouble()
    ..maxCP = json['maxCP'] as int
    ..evolutions = (json['evolutions'] as List)
        ?.map((e) =>
            e == null ? null : GQL_Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..evolutionRequirements = json['evolutionRequirements'] == null
        ? null
        : GQL_PokemonEvolutionRequirement.fromJson(
            json['evolutionRequirements'] as Map<String, dynamic>)
    ..maxHP = json['maxHP'] as int
    ..image = json['image'] as String;
}

Map<String, dynamic> _$GQL_PokemonToJson(GQL_Pokemon instance) =>
    <String, dynamic>{
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

GQL_PokemonDimension _$GQL_PokemonDimensionFromJson(Map<String, dynamic> json) {
  return GQL_PokemonDimension()
    ..minimum = json['minimum'] as String
    ..maximum = json['maximum'] as String;
}

Map<String, dynamic> _$GQL_PokemonDimensionToJson(
        GQL_PokemonDimension instance) =>
    <String, dynamic>{'minimum': instance.minimum, 'maximum': instance.maximum};

GQL_PokemonAttack _$GQL_PokemonAttackFromJson(Map<String, dynamic> json) {
  return GQL_PokemonAttack()
    ..fast = (json['fast'] as List)
        ?.map((e) =>
            e == null ? null : GQL_Attack.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..special = (json['special'] as List)
        ?.map((e) =>
            e == null ? null : GQL_Attack.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GQL_PokemonAttackToJson(GQL_PokemonAttack instance) =>
    <String, dynamic>{'fast': instance.fast, 'special': instance.special};

GQL_Attack _$GQL_AttackFromJson(Map<String, dynamic> json) {
  return GQL_Attack()
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..damage = json['damage'] as int;
}

Map<String, dynamic> _$GQL_AttackToJson(GQL_Attack instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'damage': instance.damage
    };

GQL_PokemonEvolutionRequirement _$GQL_PokemonEvolutionRequirementFromJson(
    Map<String, dynamic> json) {
  return GQL_PokemonEvolutionRequirement()
    ..amount = json['amount'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$GQL_PokemonEvolutionRequirementToJson(
        GQL_PokemonEvolutionRequirement instance) =>
    <String, dynamic>{'amount': instance.amount, 'name': instance.name};
