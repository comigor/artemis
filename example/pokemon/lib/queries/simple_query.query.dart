// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
part 'simple_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SimpleQuery {
  SimpleQuery();

  factory SimpleQuery.fromJson(Map<String, dynamic> json) =>
      _$SimpleQueryFromJson(json);

  Pokemon pokemon;

  Map<String, dynamic> toJson() => _$SimpleQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon {
  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  String number;

  List<String> types;

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
  SimpleQuery parse(Map<String, dynamic> json) => SimpleQuery.fromJson(json);
}
