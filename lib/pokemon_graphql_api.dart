import 'package:json_annotation/json_annotation.dart';
import 'package:graphql_builder/coercers.dart';
  
part 'pokemon_graphql_api.g.dart';

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

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}



@JsonSerializable()
class PokemonDimension {
  String minimum;
  String maximum;
  
  PokemonDimension();

  factory PokemonDimension.fromJson(Map<String, dynamic> json) => _$PokemonDimensionFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonDimensionToJson(this);
}

@JsonSerializable()
class PokemonAttack {
  List<Attack> fast;
  List<Attack> special;
  
  PokemonAttack();

  factory PokemonAttack.fromJson(Map<String, dynamic> json) => _$PokemonAttackFromJson(json);
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

  factory PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) => _$PokemonEvolutionRequirementFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonEvolutionRequirementToJson(this);
}

@JsonSerializable()
class __Schema {
  List<__Type> types;
  __Type queryType;
  __Type mutationType;
  __Type subscriptionType;
  List<__Directive> directives;
  
  __Schema();

  factory __Schema.fromJson(Map<String, dynamic> json) => _$__SchemaFromJson(json);
  Map<String, dynamic> toJson() => _$__SchemaToJson(this);
}

@JsonSerializable()
class __Type {
  __TypeKind kind;
  String name;
  String description;
  List<__Field> fields;
  List<__Type> interfaces;
  List<__Type> possibleTypes;
  List<__EnumValue> enumValues;
  List<__InputValue> inputFields;
  __Type ofType;
  
  __Type();

  factory __Type.fromJson(Map<String, dynamic> json) => _$__TypeFromJson(json);
  Map<String, dynamic> toJson() => _$__TypeToJson(this);
}

enum __TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
}


@JsonSerializable()
class __Field {
  String name;
  String description;
  List<__InputValue> args;
  __Type type;
  bool isDeprecated;
  String deprecationReason;
  
  __Field();

  factory __Field.fromJson(Map<String, dynamic> json) => _$__FieldFromJson(json);
  Map<String, dynamic> toJson() => _$__FieldToJson(this);
}

@JsonSerializable()
class __InputValue {
  String name;
  String description;
  __Type type;
  String defaultValue;
  
  __InputValue();

  factory __InputValue.fromJson(Map<String, dynamic> json) => _$__InputValueFromJson(json);
  Map<String, dynamic> toJson() => _$__InputValueToJson(this);
}

@JsonSerializable()
class __EnumValue {
  String name;
  String description;
  bool isDeprecated;
  String deprecationReason;
  
  __EnumValue();

  factory __EnumValue.fromJson(Map<String, dynamic> json) => _$__EnumValueFromJson(json);
  Map<String, dynamic> toJson() => _$__EnumValueToJson(this);
}

@JsonSerializable()
class __Directive {
  String name;
  String description;
  List<__DirectiveLocation> locations;
  List<__InputValue> args;
  bool onOperation;
  bool onFragment;
  bool onField;
  
  __Directive();

  factory __Directive.fromJson(Map<String, dynamic> json) => _$__DirectiveFromJson(json);
  Map<String, dynamic> toJson() => _$__DirectiveToJson(this);
}

enum __DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
}

