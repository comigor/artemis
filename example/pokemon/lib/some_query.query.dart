// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'some_query.query.g.dart';

@JsonSerializable()
class SomeQuery {
  Pokemon pokemon;

  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SomeQueryToJson(this);
}

@JsonSerializable()
class Pokemon {
  String number;
  List<String> types;

  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
