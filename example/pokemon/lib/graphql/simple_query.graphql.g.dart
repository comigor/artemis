// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'simple_query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleQuery$Query$Pokemon _$SimpleQuery$Query$PokemonFromJson(
        Map<String, dynamic> json) =>
    SimpleQuery$Query$Pokemon()
      ..number = json['number'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String?).toList();

Map<String, dynamic> _$SimpleQuery$Query$PokemonToJson(
        SimpleQuery$Query$Pokemon instance) =>
    <String, dynamic>{
      'number': instance.number,
      'types': instance.types,
    };

SimpleQuery$Query _$SimpleQuery$QueryFromJson(Map<String, dynamic> json) =>
    SimpleQuery$Query()
      ..pokemon = json['pokemon'] == null
          ? null
          : SimpleQuery$Query$Pokemon.fromJson(
              json['pokemon'] as Map<String, dynamic>);

Map<String, dynamic> _$SimpleQuery$QueryToJson(SimpleQuery$Query instance) =>
    <String, dynamic>{
      'pokemon': instance.pokemon?.toJson(),
    };
