// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'fragments_glob.graphql.g.dart';

mixin PokemonMixin {
  late String id;
  PokemonMixin$PokemonDimension? weight;
  PokemonMixin$PokemonAttack? attacks;
}
mixin WeightMixin {
  String? minimum;
}
mixin PokemonAttackMixin {
  List<PokemonAttackMixin$Attack?>? special;
}
mixin AttackMixin {
  String? name;
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonMixin {
  FragmentsGlob$Query$Pokemon$Pokemon();

  factory FragmentsGlob$Query$Pokemon$Pokemon.fromJson(
          Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$Pokemon$PokemonFromJson(json);

  @override
  List<Object?> get props => [id, weight, attacks];
  @override
  Map<String, dynamic> toJson() =>
      _$FragmentsGlob$Query$Pokemon$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query$Pokemon extends JsonSerializable
    with EquatableMixin, PokemonMixin {
  FragmentsGlob$Query$Pokemon();

  factory FragmentsGlob$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$FragmentsGlob$Query$PokemonFromJson(json);

  List<FragmentsGlob$Query$Pokemon$Pokemon?>? evolutions;

  @override
  List<Object?> get props => [id, weight, attacks, evolutions];
  @override
  Map<String, dynamic> toJson() => _$FragmentsGlob$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentsGlob$Query extends JsonSerializable with EquatableMixin {
  FragmentsGlob$Query();

  factory FragmentsGlob$Query.fromJson(Map<String, dynamic> json) =>
      _$FragmentsGlob$QueryFromJson(json);

  FragmentsGlob$Query$Pokemon? pokemon;

  @override
  List<Object?> get props => [pokemon];
  @override
  Map<String, dynamic> toJson() => _$FragmentsGlob$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonDimension extends JsonSerializable
    with EquatableMixin, WeightMixin {
  PokemonMixin$PokemonDimension();

  factory PokemonMixin$PokemonDimension.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonDimensionFromJson(json);

  @override
  List<Object?> get props => [minimum];
  @override
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonDimensionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonMixin$PokemonAttack extends JsonSerializable
    with EquatableMixin, PokemonAttackMixin {
  PokemonMixin$PokemonAttack();

  factory PokemonMixin$PokemonAttack.fromJson(Map<String, dynamic> json) =>
      _$PokemonMixin$PokemonAttackFromJson(json);

  @override
  List<Object?> get props => [special];
  @override
  Map<String, dynamic> toJson() => _$PokemonMixin$PokemonAttackToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonAttackMixin$Attack extends JsonSerializable
    with EquatableMixin, AttackMixin {
  PokemonAttackMixin$Attack();

  factory PokemonAttackMixin$Attack.fromJson(Map<String, dynamic> json) =>
      _$PokemonAttackMixin$AttackFromJson(json);

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() => _$PokemonAttackMixin$AttackToJson(this);
}

final FRAGMENTS_GLOB_QUERY_DOCUMENT = DocumentNode(definitions: [
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
          on: NamedTypeNode(name: NameNode(value: 'Attack'), isNonNull: false)),
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

class FragmentsGlobQuery
    extends GraphQLQuery<FragmentsGlob$Query, JsonSerializable> {
  FragmentsGlobQuery();

  @override
  final DocumentNode document = FRAGMENTS_GLOB_QUERY_DOCUMENT;

  @override
  final String operationName = 'fragments_glob';

  @override
  List<Object?> get props => [document, operationName];
  @override
  FragmentsGlob$Query parse(Map<String, dynamic> json) =>
      FragmentsGlob$Query.fromJson(json);
}
