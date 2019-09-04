// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'big_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BigQuery _$BigQueryFromJson(Map<String, dynamic> json) {
  return BigQuery()
    ..charmander = json['charmander'] == null
        ? null
        : Charmander.fromJson(json['charmander'] as Map<String, dynamic>)
    ..pokemons = (json['pokemons'] as List)
        ?.map((e) =>
            e == null ? null : Pokemon.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BigQueryToJson(BigQuery instance) => <String, dynamic>{
      'charmander': instance.charmander?.toJson(),
      'pokemons': instance.pokemons?.map((e) => e?.toJson())?.toList(),
    };

Charmander _$CharmanderFromJson(Map<String, dynamic> json) {
  return Charmander()
    ..number = json['number'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CharmanderToJson(Charmander instance) =>
    <String, dynamic>{
      'number': instance.number,
      'types': instance.types,
    };

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon()
    ..number = json['number'] as String
    ..name = json['name'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList()
    ..evolutions = (json['evolutions'] as List)
        ?.map((e) =>
            e == null ? null : Evolutions.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
      'evolutions': instance.evolutions?.map((e) => e?.toJson())?.toList(),
    };

Evolutions _$EvolutionsFromJson(Map<String, dynamic> json) {
  return Evolutions()
    ..number = json['number'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$EvolutionsToJson(Evolutions instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
    };

BigQueryArguments _$BigQueryArgumentsFromJson(Map<String, dynamic> json) {
  return BigQueryArguments(
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$BigQueryArgumentsToJson(BigQueryArguments instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };
