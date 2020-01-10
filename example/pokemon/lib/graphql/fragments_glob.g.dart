// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fragments_glob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FragmentsGlob _$FragmentsGlobFromJson(Map<String, dynamic> json) {
  return FragmentsGlob()
    ..pokemon = json['pokemon'] == null
        ? null
        : Pokemon.fromJson(json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FragmentsGlobToJson(FragmentsGlob instance) =>
    <String, dynamic>{
      'pokemon': instance.pokemon?.toJson(),
    };

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon()
    ..id = json['id'] as String
    ..weight = json['weight'] == null
        ? null
        : PokemonDimension.fromJson(json['weight'] as Map<String, dynamic>)
    ..attacks = json['attacks'] == null
        ? null
        : PokemonAttack.fromJson(json['attacks'] as Map<String, dynamic>)
    ..evolutions = (json['evolutions'] as List)
        ?.map((e) =>
            e == null ? null : Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight?.toJson(),
      'attacks': instance.attacks?.toJson(),
      'evolutions': instance.evolutions?.map((e) => e?.toJson())?.toList(),
    };

PokemonDimension _$PokemonDimensionFromJson(Map<String, dynamic> json) {
  return PokemonDimension()..minimum = json['minimum'] as String;
}

Map<String, dynamic> _$PokemonDimensionToJson(PokemonDimension instance) =>
    <String, dynamic>{
      'minimum': instance.minimum,
    };

PokemonAttack _$PokemonAttackFromJson(Map<String, dynamic> json) {
  return PokemonAttack()
    ..special = (json['special'] as List)
        ?.map((e) =>
            e == null ? null : Attack.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PokemonAttackToJson(PokemonAttack instance) =>
    <String, dynamic>{
      'special': instance.special?.map((e) => e?.toJson())?.toList(),
    };

Attack _$AttackFromJson(Map<String, dynamic> json) {
  return Attack()..name = json['name'] as String;
}

Map<String, dynamic> _$AttackToJson(Attack instance) => <String, dynamic>{
      'name': instance.name,
    };
