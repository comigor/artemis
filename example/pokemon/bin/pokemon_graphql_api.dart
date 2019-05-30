import 'package:json_annotation/json_annotation.dart';


part 'pokemon_graphql_api.g.dart';

@JsonSerializable()
class GQL_Query {
  GQL_Query query;
  List<GQL_Pokemon> pokemons;
  GQL_Pokemon pokemon;
  
  GQL_Query();

  factory GQL_Query.fromJson(Map<String, dynamic> json) => _$GQL_QueryFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_QueryToJson(this);
}


@JsonSerializable()
class GQL_Pokemon {
  String id;
  String number;
  String name;
  GQL_PokemonDimension weight;
  GQL_PokemonDimension height;
  String classification;
  List<String> types;
  List<String> resistant;
  GQL_PokemonAttack attacks;
  List<String> weaknesses;
  double fleeRate;
  int maxCP;
  List<GQL_Pokemon> evolutions;
  GQL_PokemonEvolutionRequirement evolutionRequirements;
  int maxHP;
  String image;
  
  GQL_Pokemon();

  factory GQL_Pokemon.fromJson(Map<String, dynamic> json) => _$GQL_PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_PokemonToJson(this);
}



@JsonSerializable()
class GQL_PokemonDimension {
  String minimum;
  String maximum;
  
  GQL_PokemonDimension();

  factory GQL_PokemonDimension.fromJson(Map<String, dynamic> json) => _$GQL_PokemonDimensionFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_PokemonDimensionToJson(this);
}

@JsonSerializable()
class GQL_PokemonAttack {
  List<GQL_Attack> fast;
  List<GQL_Attack> special;
  
  GQL_PokemonAttack();

  factory GQL_PokemonAttack.fromJson(Map<String, dynamic> json) => _$GQL_PokemonAttackFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_PokemonAttackToJson(this);
}

@JsonSerializable()
class GQL_Attack {
  String name;
  String type;
  int damage;
  
  GQL_Attack();

  factory GQL_Attack.fromJson(Map<String, dynamic> json) => _$GQL_AttackFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_AttackToJson(this);
}


@JsonSerializable()
class GQL_PokemonEvolutionRequirement {
  int amount;
  String name;
  
  GQL_PokemonEvolutionRequirement();

  factory GQL_PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) => _$GQL_PokemonEvolutionRequirementFromJson(json);
  Map<String, dynamic> toJson() => _$GQL_PokemonEvolutionRequirementToJson(this);
}










