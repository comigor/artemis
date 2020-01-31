// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleQuery$Query$Pokemon _$SimpleQuery$Query$PokemonFromJson(
    Map<String, dynamic> json) {
  return SimpleQuery$Query$Pokemon()
    ..number = json['number'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SimpleQuery$Query$PokemonToJson(
        SimpleQuery$Query$Pokemon instance) =>
    <String, dynamic>{
      'number': instance.number,
      'types': instance.types,
    };

SimpleQuery$Query _$SimpleQuery$QueryFromJson(Map<String, dynamic> json) {
  return SimpleQuery$Query()
    ..pokemon = json['pokemon'] == null
        ? null
        : SimpleQuery$Query$Pokemon.fromJson(
            json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SimpleQuery$QueryToJson(SimpleQuery$Query instance) =>
    <String, dynamic>{
      'pokemon': instance.pokemon?.toJson(),
    };
