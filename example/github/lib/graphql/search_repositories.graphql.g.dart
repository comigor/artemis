// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'search_repositories.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository
    _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$RepositoryFromJson(
        Map<String, dynamic> json) {
  return SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository()
    ..$$typename = json['__typename'] as String?
    ..name = json['name'] as String;
}

Map<String, dynamic>
    _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$RepositoryToJson(
            SearchRepositories$Query$SearchResultItemConnection$SearchResultItem$Repository
                instance) =>
        <String, dynamic>{
          '__typename': instance.$$typename,
          'name': instance.name,
        };

SearchRepositories$Query$SearchResultItemConnection$SearchResultItem
    _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItemFromJson(
        Map<String, dynamic> json) {
  return SearchRepositories$Query$SearchResultItemConnection$SearchResultItem()
    ..$$typename = json['__typename'] as String?;
}

Map<String, dynamic>
    _$SearchRepositories$Query$SearchResultItemConnection$SearchResultItemToJson(
            SearchRepositories$Query$SearchResultItemConnection$SearchResultItem
                instance) =>
        <String, dynamic>{
          '__typename': instance.$$typename,
        };

SearchRepositories$Query$SearchResultItemConnection
    _$SearchRepositories$Query$SearchResultItemConnectionFromJson(
        Map<String, dynamic> json) {
  return SearchRepositories$Query$SearchResultItemConnection()
    ..nodes = (json['nodes'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : SearchRepositories$Query$SearchResultItemConnection$SearchResultItem
                .fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic>
    _$SearchRepositories$Query$SearchResultItemConnectionToJson(
            SearchRepositories$Query$SearchResultItemConnection instance) =>
        <String, dynamic>{
          'nodes': instance.nodes?.map((e) => e?.toJson()).toList(),
        };

SearchRepositories$Query _$SearchRepositories$QueryFromJson(
    Map<String, dynamic> json) {
  return SearchRepositories$Query()
    ..search = SearchRepositories$Query$SearchResultItemConnection.fromJson(
        json['search'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SearchRepositories$QueryToJson(
        SearchRepositories$Query instance) =>
    <String, dynamic>{
      'search': instance.search.toJson(),
    };

SearchRepositoriesArguments _$SearchRepositoriesArgumentsFromJson(
    Map<String, dynamic> json) {
  return SearchRepositoriesArguments(
    query: json['query'] as String,
  );
}

Map<String, dynamic> _$SearchRepositoriesArgumentsToJson(
        SearchRepositoriesArguments instance) =>
    <String, dynamic>{
      'query': instance.query,
    };
