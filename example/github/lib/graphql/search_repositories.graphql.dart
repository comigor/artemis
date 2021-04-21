// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';

part 'search_repositories.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository
    extends SearchRepositories$Query$SearchResultItemConnection$SearchResultItem
    with EquatableMixin {
  SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository();

  factory SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository.fromJson(
          Map<String, dynamic> json) =>
      _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$RepositoryFromJson(
          json);

  late String name;

  @override
  List<Object?> get props => [name];

  Map<String, dynamic> toJson() =>
      _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$RepositoryToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class SearchRepositories$Query$SearchResultItemConnection$SearchResultItem
    extends JsonSerializable with EquatableMixin {
  SearchRepositories$Query$SearchResultItemConnection$SearchResultItem();

  factory SearchRepositories$Query$SearchResultItemConnection$SearchResultItem.fromJson(
      Map<String, dynamic> json) {
    switch (json['__typename'].toString()) {
      case r'Repository':
        return SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository
            .fromJson(json);
      default:
    }
    return _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItemFromJson(
        json);
  }

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [$$typename];

  Map<String, dynamic> toJson() {
    switch ($$typename) {
      case r'Repository':
        return (this
                as SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository)
            .toJson();
      default:
    }
    return _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItemToJson(
        this);
  }
}

@JsonSerializable(explicitToJson: true)
class SearchRepositories$Query$SearchResultItemConnection
    extends JsonSerializable with EquatableMixin {
  SearchRepositories$Query$SearchResultItemConnection();

  factory SearchRepositories$Query$SearchResultItemConnection.fromJson(
          Map<String, dynamic> json) =>
      _$SearchRepositories$Query$SearchResultItemConnectionFromJson(json);

  List<SearchRepositories$Query$SearchResultItemConnection$SearchResultItem?>?
      nodes;

  @override
  List<Object?> get props => [nodes];

  Map<String, dynamic> toJson() =>
      _$SearchRepositories$Query$SearchResultItemConnectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchRepositories$Query extends JsonSerializable with EquatableMixin {
  SearchRepositories$Query();

  factory SearchRepositories$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchRepositories$QueryFromJson(json);

  late SearchRepositories$Query$SearchResultItemConnection search;

  @override
  List<Object?> get props => [search];

  Map<String, dynamic> toJson() => _$SearchRepositories$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchRepositoriesArguments extends JsonSerializable with EquatableMixin {
  SearchRepositoriesArguments({required this.query});

  @override
  factory SearchRepositoriesArguments.fromJson(Map<String, dynamic> json) =>
      _$SearchRepositoriesArgumentsFromJson(json);

  late String query;

  @override
  List<Object?> get props => [query];

  @override
  Map<String, dynamic> toJson() => _$SearchRepositoriesArgumentsToJson(this);
}

final SEARCH_REPOSITORIES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'search_repositories'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'query')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'search'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'first'),
                  value: IntValueNode(value: '10')),
              ArgumentNode(
                  name: NameNode(value: 'type'),
                  value: EnumValueNode(name: NameNode(value: 'REPOSITORY'))),
              ArgumentNode(
                  name: NameNode(value: 'query'),
                  value: VariableNode(name: NameNode(value: 'query')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'nodes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    InlineFragmentNode(
                        typeCondition: TypeConditionNode(
                            on: NamedTypeNode(
                                name: NameNode(value: 'Repository'),
                                isNonNull: false)),
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ]))
            ]))
      ]))
]);

class SearchRepositoriesQuery extends GraphQLQuery<SearchRepositories$Query,
    SearchRepositoriesArguments> {
  SearchRepositoriesQuery({required this.variables});

  @override
  final DocumentNode document = SEARCH_REPOSITORIES_QUERY_DOCUMENT;

  @override
  final String operationName = 'search_repositories';

  @override
  final SearchRepositoriesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];

  @override
  SearchRepositories$Query parse(Map<String, dynamic> json) =>
      SearchRepositories$Query.fromJson(json);
}
