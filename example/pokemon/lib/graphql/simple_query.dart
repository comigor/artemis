// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'simple_query.g.dart';

@JsonSerializable(explicitToJson: true)
class SimpleQuery with EquatableMixin {
  SimpleQuery();

  factory SimpleQuery.fromJson(Map<String, dynamic> json) =>
      _$SimpleQueryFromJson(json);

  Pokemon pokemon;

  @override
  List<Object> get props => [pokemon];
  Map<String, dynamic> toJson() => _$SimpleQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pokemon with EquatableMixin {
  Pokemon();

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  String number;

  List<String> types;

  @override
  List<Object> get props => [number, types];
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

class SimpleQueryQuery extends GraphQLQuery<SimpleQuery, JsonSerializable> {
  SimpleQueryQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'simple_query'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'pokemon'),
              alias: null,
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
              ]))
        ]))
  ]);

  @override
  final String operationName = 'simple_query';

  @override
  List<Object> get props => [document, operationName];
  @override
  SimpleQuery parse(Map<String, dynamic> json) => SimpleQuery.fromJson(json);
}
