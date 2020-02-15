// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fragments_glob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FragmentsGlob$Query$Pokemon$Pokemon
    _$FragmentsGlob$Query$Pokemon$PokemonFromJson(Map<String, dynamic> json) {
  return FragmentsGlob$Query$Pokemon$Pokemon()
    ..id = json['id'] as String
    ..weight = json['weight'] == null
        ? null
        : FragmentsGlob$Query$Pokemon$PokemonDimension.fromJson(
            json['weight'] as Map<String, dynamic>)
    ..attacks = json['attacks'] == null
        ? null
        : FragmentsGlob$Query$Pokemon$PokemonAttack.fromJson(
            json['attacks'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FragmentsGlob$Query$Pokemon$PokemonToJson(
        FragmentsGlob$Query$Pokemon$Pokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight?.toJson(),
      'attacks': instance.attacks?.toJson(),
    };

FragmentsGlob$Query$Pokemon _$FragmentsGlob$Query$PokemonFromJson(
    Map<String, dynamic> json) {
  return FragmentsGlob$Query$Pokemon()
    ..id = json['id'] as String
    ..weight = json['weight'] == null
        ? null
        : FragmentsGlob$Query$Pokemon$PokemonDimension.fromJson(
            json['weight'] as Map<String, dynamic>)
    ..attacks = json['attacks'] == null
        ? null
        : FragmentsGlob$Query$Pokemon$PokemonAttack.fromJson(
            json['attacks'] as Map<String, dynamic>)
    ..evolutions = (json['evolutions'] as List)
        ?.map((e) => e == null
            ? null
            : FragmentsGlob$Query$Pokemon$Pokemon.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FragmentsGlob$Query$PokemonToJson(
        FragmentsGlob$Query$Pokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight?.toJson(),
      'attacks': instance.attacks?.toJson(),
      'evolutions': instance.evolutions?.map((e) => e?.toJson())?.toList(),
    };

FragmentsGlob$Query _$FragmentsGlob$QueryFromJson(Map<String, dynamic> json) {
  return FragmentsGlob$Query()
    ..pokemon = json['pokemon'] == null
        ? null
        : FragmentsGlob$Query$Pokemon.fromJson(
            json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FragmentsGlob$QueryToJson(
        FragmentsGlob$Query instance) =>
    <String, dynamic>{
      'pokemon': instance.pokemon?.toJson(),
    };

FragmentsGlob$Query$Pokemon$PokemonDimension
    _$FragmentsGlob$Query$Pokemon$PokemonDimensionFromJson(
        Map<String, dynamic> json) {
  return FragmentsGlob$Query$Pokemon$PokemonDimension()
    ..minimum = json['minimum'] as String;
}

Map<String, dynamic> _$FragmentsGlob$Query$Pokemon$PokemonDimensionToJson(
        FragmentsGlob$Query$Pokemon$PokemonDimension instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
    };

FragmentsGlob$Query$Pokemon$PokemonAttack
    _$FragmentsGlob$Query$Pokemon$PokemonAttackFromJson(
        Map<String, dynamic> json) {
  return FragmentsGlob$Query$Pokemon$PokemonAttack()
    ..special = (json['special'] as List)
        ?.map((e) => e == null
            ? null
            : FragmentsGlob$Query$PokemonAttack$Attack.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FragmentsGlob$Query$Pokemon$PokemonAttackToJson(
        FragmentsGlob$Query$Pokemon$PokemonAttack instance) =>
    <String, dynamic>{
      'special': instance.special?.map((e) => e?.toJson())?.toList(),
    };

FragmentsGlob$Query$PokemonAttack$Attack
    _$FragmentsGlob$Query$PokemonAttack$AttackFromJson(
        Map<String, dynamic> json) {
  return FragmentsGlob$Query$PokemonAttack$Attack()
    ..name = json['name'] as String;
}

Map<String, dynamic> _$FragmentsGlob$Query$PokemonAttack$AttackToJson(
        FragmentsGlob$Query$PokemonAttack$Attack instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
