// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'fragment_query.g.dart';

mixin PokemonPartsMixin {
  String number;
  String name;
  List<String> types;
}

@JsonSerializable(explicitToJson: true)
class FragmentQuery with EquatableMixin {
  FragmentQuery();

  factory FragmentQuery.fromJson(Map<String, dynamic> json) =>
      _$FragmentQueryFromJson(json);

  Charmander charmander;

  List<Pokemon> pokemons;

  @override
  List<Object> get props => [charmander, pokemons];
  Map<String, dynamic> toJson() => _$FragmentQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Charmander with EquatableMixin, PokemonPartsMixin {
  Charmander();

  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);

  @override
  List<Object> get props => [number, name, types];
  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon with EquatableMixin, PokemonPartsMixin {
  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  List<Evolutions> evolutions;

  @override
  List<Object> get props => [number, name, types, evolutions];
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Evolutions with EquatableMixin, PokemonPartsMixin {
  Evolutions();

  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);

  @override
  List<Object> get props => [number, name, types];
  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FragmentQueryArguments extends JsonSerializable with EquatableMixin {
  FragmentQueryArguments({this.quantity});

  factory FragmentQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$FragmentQueryArgumentsFromJson(json);

  final int quantity;

  @override
  List<Object> get props => [quantity];
  Map<String, dynamic> toJson() => _$FragmentQueryArgumentsToJson(this);
}

class FragmentQueryQuery
    extends GraphQLQuery<FragmentQuery, FragmentQueryArguments> {
  FragmentQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    FragmentDefinitionNode(
        name: NameNode(value: 'PokemonParts'),
        typeCondition: TypeConditionNode(
            on: NamedTypeNode(
                name: NameNode(value: 'Pokemon'), isNonNull: false)),
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'number'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'name'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'types'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null)
        ])),
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'fragmentQuery'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'quantity')),
              type:
                  NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'pokemon'),
              alias: NameNode(value: 'charmander'),
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'name'),
                    value: StringValueNode(value: 'Charmander', isBlock: false))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'PokemonParts'), directives: [])
              ])),
          FieldNode(
              name: NameNode(value: 'pokemons'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'first'),
                    value: VariableNode(name: NameNode(value: 'quantity')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FragmentSpreadNode(
                    name: NameNode(value: 'PokemonParts'), directives: []),
                FieldNode(
                    name: NameNode(value: 'evolutions'),
                    alias: NameNode(value: 'evolutions'),
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: 'PokemonParts'), directives: [])
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'fragmentQuery';

  @override
  final FragmentQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  FragmentQuery parse(Map<String, dynamic> json) =>
      FragmentQuery.fromJson(json);
}
