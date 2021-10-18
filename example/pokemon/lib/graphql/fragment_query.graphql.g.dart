// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'fragment_query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FragmentQuery$Query$Charmander _$FragmentQuery$Query$CharmanderFromJson(
        Map<String, dynamic> json) =>
    FragmentQuery$Query$Charmander()
      ..number = json['number'] as String?
      ..name = json['name'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String?).toList();

Map<String, dynamic> _$FragmentQuery$Query$CharmanderToJson(
        FragmentQuery$Query$Charmander instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
    };

FragmentQuery$Query$Pokemon$Evolutions
    _$FragmentQuery$Query$Pokemon$EvolutionsFromJson(
            Map<String, dynamic> json) =>
        FragmentQuery$Query$Pokemon$Evolutions()
          ..number = json['number'] as String?
          ..name = json['name'] as String?
          ..types = (json['types'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList();

Map<String, dynamic> _$FragmentQuery$Query$Pokemon$EvolutionsToJson(
        FragmentQuery$Query$Pokemon$Evolutions instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
    };

FragmentQuery$Query$Pokemon _$FragmentQuery$Query$PokemonFromJson(
        Map<String, dynamic> json) =>
    FragmentQuery$Query$Pokemon()
      ..number = json['number'] as String?
      ..name = json['name'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String?).toList()
      ..evolutions = (json['evolutions'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : FragmentQuery$Query$Pokemon$Evolutions.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FragmentQuery$Query$PokemonToJson(
        FragmentQuery$Query$Pokemon instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
      'evolutions': instance.evolutions?.map((e) => e?.toJson()).toList(),
    };

FragmentQuery$Query _$FragmentQuery$QueryFromJson(Map<String, dynamic> json) =>
    FragmentQuery$Query()
      ..charmander = json['charmander'] == null
          ? null
          : FragmentQuery$Query$Charmander.fromJson(
              json['charmander'] as Map<String, dynamic>)
      ..pokemons = (json['pokemons'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : FragmentQuery$Query$Pokemon.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FragmentQuery$QueryToJson(
        FragmentQuery$Query instance) =>
    <String, dynamic>{
      'charmander': instance.charmander?.toJson(),
      'pokemons': instance.pokemons?.map((e) => e?.toJson()).toList(),
    };

FragmentQueryArguments _$FragmentQueryArgumentsFromJson(
        Map<String, dynamic> json) =>
    FragmentQueryArguments(
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$FragmentQueryArgumentsToJson(
        FragmentQueryArguments instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };
