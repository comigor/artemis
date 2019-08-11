// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:artemis/schema/graphql_query.dart';
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

class BigQueryArguments {
  BigQueryArguments({this.quantity});

  final int quantity;

  Map<String, dynamic> toMap() {
    return {'quantity': this.quantity};
  }
}

class BigQueryQuery extends GraphQLQuery<BigQuery> {
  BigQueryQuery({BigQueryArguments arguments}) : variables = arguments.toMap();

  @override
  final Map<String, dynamic> variables;

  @override
  final String query =
      'query big_query(\$quantity: Int!) { charmander: pokemon(name: "Charmander") { number types } pokemons(first: \$quantity) { number name types evolutions: evolutions { number name } } }';

  @override
  BigQuery parse(Map<String, dynamic> json) {
    return BigQuery.fromJson(json);
  }
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
    headers: (client != null)
        ? null
        : {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
  );

  final Map<String, dynamic> jsonBody = json.decode(dataResponse.body);
  final response = GraphQLResponse<BigQuery>.fromJson(jsonBody)
    ..data = BigQuery.fromJson(jsonBody['data'] ?? <Map<String, dynamic>>{});

  if (client == null) {
    httpClient.close();
  }

  return response;
}
