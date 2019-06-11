// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.api.dart';

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
