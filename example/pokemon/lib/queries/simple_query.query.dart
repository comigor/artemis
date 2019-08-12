// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/schema/graphql_query.dart';
import 'package:artemis/schema/graphql_error.dart';

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

class SimpleQueryQuery extends GraphQLQuery<SimpleQuery, void> {
  SimpleQueryQuery();

  @override
  final String query =
      'query simple_query { pokemon(name: "Charmander") { number types } }';

  @override
  SimpleQuery parse(Map<String, dynamic> json) {
    return SimpleQuery.fromJson(json);
  }
}

Future<GraphQLResponse<SimpleQuery>> executeSimpleQueryQuery(
    String graphQLEndpoint,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(
    graphQLEndpoint,
    body: json.encode({
      'operationName': 'simple_query',
      'query':
          'query simple_query { pokemon(name: "Charmander") { number types } }',
    }),
    headers: (client != null)
        ? null
        : {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
  );

  final Map<String, dynamic> jsonBody = json.decode(dataResponse.body);
  final response = GraphQLResponse<SimpleQuery>.fromJson(jsonBody)
    ..data = SimpleQuery.fromJson(jsonBody['data'] ?? <Map<String, dynamic>>{});

  if (client == null) {
    httpClient.close();
  }

  return response;
}
