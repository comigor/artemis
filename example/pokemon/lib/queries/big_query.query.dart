// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
part 'big_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class BigQuery {
  BigQuery();

  factory BigQuery.fromJson(Map<String, dynamic> json) =>
      _$BigQueryFromJson(json);

  Charmander charmander;

  List<Pokemon> pokemons;

  Map<String, dynamic> toJson() => _$BigQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Charmander {
  Charmander();

  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);

  String number;

  List<String> types;

  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon {
  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  String number;

  String name;

  List<String> types;

  List<Evolutions> evolutions;

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Evolutions {
  Evolutions();

  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);

  String number;

  String name;

  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQueryArguments extends JsonSerializable {
  BigQueryArguments({this.quantity});

  factory BigQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$BigQueryArgumentsFromJson(json);

  final int quantity;

  Map<String, dynamic> toJson() => _$BigQueryArgumentsToJson(this);
}

class BigQueryQuery extends GraphQLQuery<BigQuery, BigQueryArguments> {
  BigQueryQuery({this.variables});

  @override
  final String query =
      'query big_query(\$quantity: Int!) { charmander: pokemon(name: "Charmander") { number types } pokemons(first: \$quantity) { number name types evolutions: evolutions { number name } } }';

  @override
  final String operationName = 'big_query';

  @override
  final BigQueryArguments variables;

  @override
  BigQuery parse(Map<String, dynamic> json) => BigQuery.fromJson(json);
}
