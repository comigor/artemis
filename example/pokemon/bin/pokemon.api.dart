// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'pokemon.api.g.dart';

@JsonSerializable()
class Query {
  Query query;
  List<Pokemon> pokemons;
  Pokemon pokemon;

  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}

@JsonSerializable()
class Pokemon {
  String id;
  String number;
  String name;
  PokemonDimension weight;
  PokemonDimension height;
  String classification;
  List<String> types;
  List<String> resistant;
  PokemonAttack attacks;
  List<String> weaknesses;
  double fleeRate;
  int maxCP;
  List<Pokemon> evolutions;
  PokemonEvolutionRequirement evolutionRequirements;
  int maxHP;
  String image;

  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
class PokemonDimension {
  String minimum;
  String maximum;

  PokemonDimension();

  factory PokemonDimension.fromJson(Map<String, dynamic> json) =>
      _$PokemonDimensionFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonDimensionToJson(this);
}

@JsonSerializable()
class PokemonAttack {
  List<Attack> fast;
  List<Attack> special;

  PokemonAttack();

  factory PokemonAttack.fromJson(Map<String, dynamic> json) =>
      _$PokemonAttackFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonAttackToJson(this);
}

@JsonSerializable()
class Attack {
  String name;
  String type;
  int damage;

  Attack();

  factory Attack.fromJson(Map<String, dynamic> json) => _$AttackFromJson(json);
  Map<String, dynamic> toJson() => _$AttackToJson(this);
}

@JsonSerializable()
class PokemonEvolutionRequirement {
  int amount;
  String name;

  PokemonEvolutionRequirement();

  factory PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) =>
      _$PokemonEvolutionRequirementFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonEvolutionRequirementToJson(this);
}
