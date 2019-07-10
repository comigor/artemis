// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/schema/graphql_error.dart';

part 'big_query.query.g.dart';

@JsonSerializable()
class BigQuery {
  Charmander charmander;
  List<Pokemon> pokemons;

  BigQuery();

  factory BigQuery.fromJson(Map<String, dynamic> json) =>
      _$BigQueryFromJson(json);
  Map<String, dynamic> toJson() => _$BigQueryToJson(this);
}

@JsonSerializable()
class Charmander {
  String number;
  List<String> types;

  Charmander();

  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);
  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable()
class Pokemon {
  String number;
  String name;
  List<String> types;
  List<Evolutions> evolutions;

  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
class Evolutions {
  String number;
  String name;

  Evolutions();

  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);
  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

Future<GraphQLResponse<BigQuery>> executeBigQueryQuery(
    String graphQLEndpoint, int quantity,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(
    graphQLEndpoint,
    body: json.encode({
      'operationName': 'big_query',
      'query':
          'query big_query(\$quantity: Int!) { charmander: pokemon(name: "Charmander") { number types } pokemons(first: \$quantity) { number name types evolutions: evolutions { number name } } }',
      'variables': {'quantity': quantity},
    }),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  final jsonBody = json.decode(dataResponse.body);
  final response = GraphQLResponse<BigQuery>.fromJson(jsonBody)
    ..data = BigQuery.fromJson(jsonBody['data'] ?? {});

  if (client == null) {
    httpClient.close();
  }

  return response;
}
