// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/artemis.dart';

part 'simple_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SimpleQuery {
  Pokemon pokemon;

  SimpleQuery();

  factory SimpleQuery.fromJson(Map<String, dynamic> json) =>
      _$SimpleQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon {
  String number;
  List<String> types;

  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

class SimpleQueryQuery extends GraphQLQuery<SimpleQuery, JsonSerializable> {
  SimpleQueryQuery();

  @override
  final String query =
      'query simple_query { pokemon(name: "Charmander") { number types } }';
  @override
  final String operationName = 'simple_query';

  @override
  SimpleQuery parse(Map<String, dynamic> json) {
    return SimpleQuery.fromJson(json);
  }
}
