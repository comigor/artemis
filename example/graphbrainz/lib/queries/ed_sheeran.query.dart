// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:graphbrainz_example/coercers.dart';
import 'package:artemis/schema/graphql_query.dart';
import 'package:artemis/schema/graphql_error.dart';

part 'ed_sheeran.query.g.dart';

@JsonSerializable()
class EdSheeran {
  Node node;

  EdSheeran();

  factory EdSheeran.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranFromJson(json);
  Map<String, dynamic> toJson() => _$EdSheeranToJson(this);
}

@JsonSerializable()
class Node {
  String id;
  @JsonKey(name: '__typename')
  String resolveType;

  Node();

  factory Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename']) {
      case 'Artist':
        return Artist.fromJson(json);
      default:
    }
    return _$NodeFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Artist':
        return (this as Artist).toJson();
      default:
    }
    return _$NodeToJson(this);
  }
}

@JsonSerializable()
class Artist implements Node, Entity {
  String mbid;
  String name;
  LifeSpan lifeSpan;
  SpotifyArtist spotify;
  @override
  @JsonKey(name: '__typename')
  String resolveType;
  @override
  String id;

  Artist();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class LifeSpan {
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;

  LifeSpan();

  factory LifeSpan.fromJson(Map<String, dynamic> json) =>
      _$LifeSpanFromJson(json);
  Map<String, dynamic> toJson() => _$LifeSpanToJson(this);
}

@JsonSerializable()
class SpotifyArtist {
  String href;

  SpotifyArtist();

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$SpotifyArtistFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyArtistToJson(this);
}

@JsonSerializable()
class Entity {
  String mbid;
  @JsonKey(name: '__typename')
  String resolveType;

  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);
  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

class EdSheeranQuery extends GraphQLQuery<EdSheeran, void> {
  EdSheeranQuery();

  @override
  final String query =
      'query ed_sheeran { node(id: "QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==") { __typename id ... on Artist { mbid name lifeSpan { begin } spotify { href } } } }';

  @override
  EdSheeran parse(Map<String, dynamic> json) {
    return EdSheeran.fromJson(json);
  }
}

Future<GraphQLResponse<EdSheeran>> executeEdSheeranQuery(String graphQLEndpoint,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(
    graphQLEndpoint,
    body: json.encode({
      'operationName': 'ed_sheeran',
      'query':
          'query ed_sheeran { node(id: "QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==") { __typename id ... on Artist { mbid name lifeSpan { begin } spotify { href } } } }',
    }),
    headers: (client != null)
        ? null
        : {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
  );

  final Map<String, dynamic> jsonBody = json.decode(dataResponse.body);
  final response = GraphQLResponse<EdSheeran>.fromJson(jsonBody)
    ..data = EdSheeran.fromJson(jsonBody['data'] ?? <Map<String, dynamic>>{});

  if (client == null) {
    httpClient.close();
  }

  return response;
}
