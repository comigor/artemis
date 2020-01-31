// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'big_query.g.dart';

@JsonSerializable(explicitToJson: true)
class BigQuery$Query$Charmander with EquatableMixin {
  BigQuery$Query$Charmander();

  factory BigQuery$Query$Charmander.fromJson(Map<String, dynamic> json) =>
      _$BigQuery$Query$CharmanderFromJson(json);

  String number;

  List<String> types;

  @override
  List<Object> get props => [number, types];
  Map<String, dynamic> toJson() => _$BigQuery$Query$CharmanderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQuery$Query$Pokemon$Evolutions with EquatableMixin {
  BigQuery$Query$Pokemon$Evolutions();

  factory BigQuery$Query$Pokemon$Evolutions.fromJson(
          Map<String, dynamic> json) =>
      _$BigQuery$Query$Pokemon$EvolutionsFromJson(json);

  String number;

  String name;

  @override
  List<Object> get props => [number, name];
  Map<String, dynamic> toJson() =>
      _$BigQuery$Query$Pokemon$EvolutionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQuery$Query$Pokemon with EquatableMixin {
  BigQuery$Query$Pokemon();

  factory BigQuery$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$BigQuery$Query$PokemonFromJson(json);

  String number;

  String name;

  List<String> types;

  List<BigQuery$Query$Pokemon$Evolutions> evolutions;

  @override
  List<Object> get props => [number, name, types, evolutions];
  Map<String, dynamic> toJson() => _$BigQuery$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BigQuery$Query with EquatableMixin {
  BigQuery$Query();

  factory BigQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$BigQuery$QueryFromJson(json);

  BigQuery$Query$Charmander charmander;

  List<BigQuery$Query$Pokemon> pokemons;

  @override
  List<Object> get props => [charmander, pokemons];
  Map<String, dynamic> toJson() => _$BigQuery$QueryToJson(this);
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

class BigQueryQuery extends GraphQLQuery<BigQuery$Query, BigQueryArguments> {
  BigQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'big_query'),
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
                FieldNode(
                    name: NameNode(value: 'number'),
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
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'evolutions'),
                    alias: NameNode(value: 'evolutions'),
                    arguments: [],
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
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'big_query';

  @override
  final BigQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  BigQuery$Query parse(Map<String, dynamic> json) =>
      BigQuery$Query.fromJson(json);
}
