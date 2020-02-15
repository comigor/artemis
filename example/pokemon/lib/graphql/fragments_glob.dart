// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'fragments_glob.g.dart';

mixin FragmentsGlob$PokemonMixin {
  String id;
  FragmentsGlob$Query$Pokemon$PokemonDimension weight;
  FragmentsGlob$Query$Pokemon$PokemonAttack attacks;
}
mixin FragmentsGlob$WeightMixin {
  String minimum;
}
mixin FragmentsGlob$PokemonAttackMixin {
  List<FragmentsGlob$Query$PokemonAttack$Attack> special;
}
mixin FragmentsGlob$AttackMixin {
  String name;
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon$Pokemon
    with EquatableMixin, FragmentsGlob$PokemonMixin {
  FragmentsGlob$Query$Pokemon$Pokemon();

  factory FragmentsGlob$Query$Pokemon$Pokemon.fromJson(
          Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object> get props => [id, weight, attacks];
  Map<String, dynamic> toJson() =>
      _$FragmentsGlob$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon
    with EquatableMixin, FragmentsGlob$PokemonMixin {
  FragmentsGlob$Query$Pokemon();

  factory FragmentsGlob$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$PokemonFromJson(json);

  List<FragmentsGlob$Query$Pokemon$Pokemon> evolutions;

  @override
  List<Object> get props => [id, weight, attacks, evolutions];
  Map<String, dynamic> toJson() => _$FragmentsGlob$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query with EquatableMixin {
  FragmentsGlob$Query();

  factory FragmentsGlob$Query.fromJson(Map<String, dynamic> json) =>
      _$FragmentsGlob$QueryFromJson(json);

  FragmentsGlob$Query$Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
  Map<String, dynamic> toJson() => _$FragmentsGlob$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon$PokemonDimension
    with EquatableMixin, FragmentsGlob$WeightMixin {
  FragmentsGlob$Query$Pokemon$PokemonDimension();

  factory FragmentsGlob$Query$Pokemon$PokemonDimension.fromJson(
          Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$Pokemon$PokemonDimensionFromJson(json);

  @override
  List<Object> get props => [minimum];
  Map<String, dynamic> toJson() =>
      _$FragmentsGlob$Query$Pokemon$PokemonDimensionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon$PokemonAttack
    with EquatableMixin, FragmentsGlob$PokemonAttackMixin {
  FragmentsGlob$Query$Pokemon$PokemonAttack();

  factory FragmentsGlob$Query$Pokemon$PokemonAttack.fromJson(
          Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$Pokemon$PokemonAttackFromJson(json);

  @override
  List<Object> get props => [special];
  Map<String, dynamic> toJson() =>
      _$FragmentsGlob$Query$Pokemon$PokemonAttackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$PokemonAttack$Attack
    with EquatableMixin, FragmentsGlob$AttackMixin {
  FragmentsGlob$Query$PokemonAttack$Attack();

  factory FragmentsGlob$Query$PokemonAttack$Attack.fromJson(
          Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$PokemonAttack$AttackFromJson(json);

  @override
  List<Object> get props => [name];
  Map<String, dynamic> toJson() =>
      _$FragmentsGlob$Query$PokemonAttack$AttackToJson(this);
}

class FragmentsGlobQuery
    extends GraphQLQuery<FragmentsGlob$Query, JsonSerializable> {
  FragmentsGlobQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: null,
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'pokemon'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'name'),
                    value: StringValueNode(value: 'Pikachu', isBlock: false))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'Pokemon'), directives: []),
                FieldNode(
                    name: NameNode(value: 'evolutions'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'Pokemon'), directives: [])
                    ]))
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'Pokemon'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Pokemon'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'id'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'weight'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'weight'), directives: [])
              ])),
          FieldNode(
              name: NameNode(value: 'attacks'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'pokemonAttack'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'weight'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'PokemonDimension'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'minimum'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'pokemonAttack'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'PokemonAttack'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'special'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'attack'), directives: [])
              ]))
        ])),
    FragmentDefinitionNode(
        name: NameNode(value: 'attack'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Attack'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ]))
  ]);

  @override
  final String operationName = 'fragments_glob';

  @override
  List<Object> get props => [document, operationName];
  @override
  FragmentsGlob$Query parse(Map<String, dynamic> json) =>
      FragmentsGlob$Query.fromJson(json);
}
