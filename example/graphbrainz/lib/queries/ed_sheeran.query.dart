// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:graphbrainz_example/coercers.dart';
part 'ed_sheeran.query.g.dart';

@JsonSerializable(explicitToJson: true)
class EdSheeran {
  EdSheeran();

  factory EdSheeran.fromJson(Map<String, dynamic> json) =>
      _$EdSheeranFromJson(json);

  Node node;

  Map<String, dynamic> toJson() => _$EdSheeranToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Node {
  Node();

  factory Node.fromJson(Map<String, dynamic> json) {
    switch (json['__typename']) {
      case 'Artist':
        return Artist.fromJson(json);
      default:
    }
    return _$NodeFromJson(json);
  }

  String id;

  @JsonKey(name: '__typename')
  String resolveType;

  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Artist':
        return (this as Artist).toJson();
      default:
    }
    return _$NodeToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class Artist implements Node, Entity {
  Artist();

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  String mbid;

  String name;

  LifeSpan lifeSpan;

  SpotifyArtist spotify;

  @override
  @JsonKey(name: '__typename')
  String resolveType;

  @override
  String id;

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LifeSpan {
  LifeSpan();

  factory LifeSpan.fromJson(Map<String, dynamic> json) =>
      _$LifeSpanFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;

  Map<String, dynamic> toJson() => _$LifeSpanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SpotifyArtist {
  SpotifyArtist();

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$SpotifyArtistFromJson(json);

  String href;

  Map<String, dynamic> toJson() => _$SpotifyArtistToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Entity {
  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) => _$EntityFromJson(json);

  String mbid;

  @JsonKey(name: '__typename')
  String resolveType;

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

class EdSheeranQuery extends GraphQLQuery<EdSheeran, JsonSerializable> {
  EdSheeranQuery();

  @override
  final String query =
      'query ed_sheeran { node(id: "QXJ0aXN0OmI4YTdjNTFmLTM2MmMtNGRjYi1hMjU5LWJjNmUwMDk1ZjBhNg==") { __typename id ... on Artist { mbid name lifeSpan { begin } spotify { href } } } }';

  @override
  final String operationName = 'ed_sheeran';

  @override
  EdSheeran parse(Map<String, dynamic> json) => EdSheeran.fromJson(json);
}
