// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'simple_query.query.g.dart';

@JsonSerializable()
class SimpleQuery {
  Pokemon pokemon;

  SimpleQuery();
  factory SimpleQuery.fromJson(Map<String, dynamic> json) =>
      _$SimpleQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleQueryToJson(this);
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

Future<SimpleQuery> executeSimpleQueryQuery(String graphQLEndpoint,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint, body: {
    'operationName': 'simple_query',
    'query':
        'query simple_query { pokemon(name: "Charmander") { number types } }',
  });
  httpClient.close();

  return SimpleQuery.fromJson(json.decode(dataResponse.body)['data']);
}
