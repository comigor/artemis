// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'some_query.query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SomeQuery _$SomeQueryFromJson(Map<String, dynamic> json) {
  return SomeQuery()
    ..pokemon = json['pokemon'] == null
        ? null
        : Pokemon.fromJson(json['pokemon'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SomeQueryToJson(SomeQuery instance) =>
    <String, dynamic>{'pokemon': instance.pokemon};

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon()
    ..number = json['number'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) =>
    <String, dynamic>{'number': instance.number, 'types': instance.types};
