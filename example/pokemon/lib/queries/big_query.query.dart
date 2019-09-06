// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'big_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class BigQuery with EquatableMixin {
  BigQuery();

  factory BigQuery.fromJson(Map<String, dynamic> json) =>
      _$BigQueryFromJson(json);

  Charmander charmander;

  List<Pokemon> pokemons;

  @override
  List<Object> get props => [charmander, pokemons];
  Map<String, dynamic> toJson() => _$BigQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Charmander with EquatableMixin {
  Charmander();

  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);

  String number;

  List<String> types;

  @override
  List<Object> get props => [number, types];
  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon with EquatableMixin {
  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  String number;

  String name;

  List<String> types;

  List<Evolutions> evolutions;

  @override
  List<Object> get props => [number, name, types, evolutions];
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Evolutions with EquatableMixin {
  Evolutions();

  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);

  String number;

  String name;

  @override
  List<Object> get props => [number, name];
  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQueryArguments extends JsonSerializable with EquatableMixin {
  BigQueryArguments({this.quantity});

  factory BigQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$BigQueryArgumentsFromJson(json);

  final int quantity;

  @override
  List<Object> get props => [quantity];
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
  List<Object> get props => [query, operationName, variables];
  @override
  BigQuery parse(Map<String, dynamic> json) => BigQuery.fromJson(json);
}
