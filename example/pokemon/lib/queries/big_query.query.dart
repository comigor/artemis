// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:artemis/schema/graphql_query.dart';
import 'package:artemis/schema/graphql_error.dart';

part 'big_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class BigQuery {
  Charmander charmander;
  List<Pokemon> pokemons;

  BigQuery();

  factory BigQuery.fromJson(Map<String, dynamic> json) =>
      _$BigQueryFromJson(json);
  Map<String, dynamic> toJson() => _$BigQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Charmander {
  String number;
  List<String> types;

  Charmander();

  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);
  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable(explicitToJson: true)
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

@JsonSerializable(explicitToJson: true)
class Evolutions {
  String number;
  String name;

  Evolutions();

  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);
  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQueryArguments extends JsonSerializable {
  BigQueryArguments({this.quantity});

  final int quantity;

  factory BigQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$BigQueryArgumentsFromJson(json);
  Map<String, dynamic> toJson() => _$BigQueryArgumentsToJson(this);
}

class BigQueryQuery extends GraphQLQuery<BigQuery, BigQueryArguments> {
  BigQueryQuery({this.variables});
  @override
  final BigQueryArguments variables;
  @override
  final String query =
      'query big_query(\$quantity: Int!) { charmander: pokemon(name: "Charmander") { number types } pokemons(first: \$quantity) { number name types evolutions: evolutions { number name } } }';
  @override
  final String operationName = 'big_query';

  @override
  BigQuery parse(Map<String, dynamic> json) {
    return BigQuery.fromJson(json);
  }
}
