// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ed_sheeran.query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdSheeran$Query$Node$Artist$LifeSpan
    _$EdSheeran$Query$Node$Artist$LifeSpanFromJson(Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist$LifeSpan()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..begin =
        json['begin'] == null ? null : DateTime.parse(json['begin'] as String);
}

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$LifeSpanToJson(
        EdSheeran$Query$Node$Artist$LifeSpan instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.typeName,
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      'begin': instance.begin?.toIso8601String(),
    };

EdSheeran$Query$Node$Artist$SpotifyArtist
    _$EdSheeran$Query$Node$Artist$SpotifyArtistFromJson(
        Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist$SpotifyArtist()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..href = json['href'] as String;
}

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$SpotifyArtistToJson(
        EdSheeran$Query$Node$Artist$SpotifyArtist instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.typeName,
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      'href': instance.href,
    };

EdSheeran$Query$Node$Artist _$EdSheeran$Query$Node$ArtistFromJson(
    Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EdSheeran$Query$Node$ArtistToJson(
        EdSheeran$Query$Node$Artist instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.typeName,
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
    };

EdSheeran$Query$Node _$EdSheeran$Query$NodeFromJson(Map<String, dynamic> json) {
  return EdSheeran$Query$Node()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String;
}

Map<String, dynamic> _$EdSheeran$Query$NodeToJson(
        EdSheeran$Query$Node instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.typeName,
    };

EdSheeran$Query _$EdSheeran$QueryFromJson(Map<String, dynamic> json) {
  return EdSheeran$Query()
    ..node = json['node'] == null
        ? null
        : EdSheeran$Query$Node.fromJson(json['node'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EdSheeran$QueryToJson(EdSheeran$Query instance) =>
    <String, dynamic>{
      'node': instance.node?.toJson(),
    };
