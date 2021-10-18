// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'big_query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BigQuery$Query$Charmander _$BigQuery$Query$CharmanderFromJson(
        Map<String, dynamic> json) =>
    BigQuery$Query$Charmander()
      ..number = json['number'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String?).toList();

Map<String, dynamic> _$BigQuery$Query$CharmanderToJson(
        BigQuery$Query$Charmander instance) =>
    <String, dynamic>{
      'number': instance.number,
      'types': instance.types,
    };

BigQuery$Query$Pokemon$Evolutions _$BigQuery$Query$Pokemon$EvolutionsFromJson(
        Map<String, dynamic> json) =>
    BigQuery$Query$Pokemon$Evolutions()
      ..number = json['number'] as String?
      ..name = json['name'] as String?;

Map<String, dynamic> _$BigQuery$Query$Pokemon$EvolutionsToJson(
        BigQuery$Query$Pokemon$Evolutions instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
    };

BigQuery$Query$Pokemon _$BigQuery$Query$PokemonFromJson(
        Map<String, dynamic> json) =>
    BigQuery$Query$Pokemon()
      ..number = json['number'] as String?
      ..name = json['name'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String?).toList()
      ..evolutions = (json['evolutions'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BigQuery$Query$Pokemon$Evolutions.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BigQuery$Query$PokemonToJson(
        BigQuery$Query$Pokemon instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
      'evolutions': instance.evolutions?.map((e) => e?.toJson()).toList(),
    };

BigQuery$Query _$BigQuery$QueryFromJson(Map<String, dynamic> json) =>
    BigQuery$Query()
      ..charmander = json['charmander'] == null
          ? null
          : BigQuery$Query$Charmander.fromJson(
              json['charmander'] as Map<String, dynamic>)
      ..pokemons = (json['pokemons'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BigQuery$Query$Pokemon.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BigQuery$QueryToJson(BigQuery$Query instance) =>
    <String, dynamic>{
      'charmander': instance.charmander?.toJson(),
      'pokemons': instance.pokemons?.map((e) => e?.toJson()).toList(),
    };

BigQueryArguments _$BigQueryArgumentsFromJson(Map<String, dynamic> json) =>
    BigQueryArguments(
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$BigQueryArgumentsToJson(BigQueryArguments instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };
