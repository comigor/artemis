// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'simple_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SimpleQuery$Query$Pokemon extends JsonSerializable with EquatableMixin {
  SimpleQuery$Query$Pokemon();

  factory SimpleQuery$Query$Pokemon.fromJson(Map<String, dynamic> json) =>
      _$SimpleQuery$Query$PokemonFromJson(json);

  String? number;

  List<String?>? types;

  @override
  List<Object?> get props => [number, types];
  @override
  Map<String, dynamic> toJson() => _$SimpleQuery$Query$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SimpleQuery$Query extends JsonSerializable with EquatableMixin {
  SimpleQuery$Query();

  factory SimpleQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SimpleQuery$QueryFromJson(json);

  SimpleQuery$Query$Pokemon? pokemon;

  @override
  List<Object?> get props => [pokemon];
  @override
  Map<String, dynamic> toJson() => _$SimpleQuery$QueryToJson(this);
}

final SIMPLE_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
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

class SimpleQueryQuery
    extends GraphQLQuery<SimpleQuery$Query, JsonSerializable> {
  SimpleQueryQuery();

  @override
  final DocumentNode document = SIMPLE_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = 'simple_query';

  @override
  List<Object?> get props => [document, operationName];
  @override
  SimpleQuery$Query parse(Map<String, dynamic> json) =>
      SimpleQuery$Query.fromJson(json);
}
