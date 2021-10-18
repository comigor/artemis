// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'fragments_glob.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FragmentsGlob$Query$Pokemon$Pokemon
    _$FragmentsGlob$Query$Pokemon$PokemonFromJson(Map<String, dynamic> json) =>
        FragmentsGlob$Query$Pokemon$Pokemon()
          ..id = json['id'] as String
          ..weight = json['weight'] == null
              ? null
              : PokemonMixin$PokemonDimension.fromJson(
                  json['weight'] as Map<String, dynamic>)
          ..attacks = json['attacks'] == null
              ? null
              : PokemonMixin$PokemonAttack.fromJson(
                  json['attacks'] as Map<String, dynamic>);

Map<String, dynamic> _$FragmentsGlob$Query$Pokemon$PokemonToJson(
        FragmentsGlob$Query$Pokemon$Pokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight?.toJson(),
      'attacks': instance.attacks?.toJson(),
    };

FragmentsGlob$Query$Pokemon _$FragmentsGlob$Query$PokemonFromJson(
        Map<String, dynamic> json) =>
    FragmentsGlob$Query$Pokemon()
      ..id = json['id'] as String
      ..weight = json['weight'] == null
          ? null
          : PokemonMixin$PokemonDimension.fromJson(
              json['weight'] as Map<String, dynamic>)
      ..attacks = json['attacks'] == null
          ? null
          : PokemonMixin$PokemonAttack.fromJson(
              json['attacks'] as Map<String, dynamic>)
      ..evolutions = (json['evolutions'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : FragmentsGlob$Query$Pokemon$Pokemon.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FragmentsGlob$Query$PokemonToJson(
        FragmentsGlob$Query$Pokemon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight?.toJson(),
      'attacks': instance.attacks?.toJson(),
      'evolutions': instance.evolutions?.map((e) => e?.toJson()).toList(),
    };

FragmentsGlob$Query _$FragmentsGlob$QueryFromJson(Map<String, dynamic> json) =>
    FragmentsGlob$Query()
      ..pokemon = json['pokemon'] == null
          ? null
          : FragmentsGlob$Query$Pokemon.fromJson(
              json['pokemon'] as Map<String, dynamic>);

Map<String, dynamic> _$FragmentsGlob$QueryToJson(
        FragmentsGlob$Query instance) =>
    <String, dynamic>{
      'pokemon': instance.pokemon?.toJson(),
    };

PokemonMixin$PokemonDimension _$PokemonMixin$PokemonDimensionFromJson(
        Map<String, dynamic> json) =>
    PokemonMixin$PokemonDimension()..minimum = json['minimum'] as String?;

Map<String, dynamic> _$PokemonMixin$PokemonDimensionToJson(
        PokemonMixin$PokemonDimension instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
    };

PokemonMixin$PokemonAttack _$PokemonMixin$PokemonAttackFromJson(
        Map<String, dynamic> json) =>
    PokemonMixin$PokemonAttack()
      ..special = (json['special'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PokemonAttackMixin$Attack.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PokemonMixin$PokemonAttackToJson(
        PokemonMixin$PokemonAttack instance) =>
    <String, dynamic>{
      'special': instance.special?.map((e) => e?.toJson()).toList(),
    };

PokemonAttackMixin$Attack _$PokemonAttackMixin$AttackFromJson(
        Map<String, dynamic> json) =>
    PokemonAttackMixin$Attack()..name = json['name'] as String?;

Map<String, dynamic> _$PokemonAttackMixin$AttackToJson(
        PokemonAttackMixin$Attack instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
