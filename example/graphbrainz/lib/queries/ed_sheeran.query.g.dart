// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ed_sheeran.query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdSheeran _$EdSheeranFromJson(Map<String, dynamic> json) {
  return EdSheeran()
    ..node = json['node'] == null
        ? null
        : Node.fromJson(json['node'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EdSheeranToJson(EdSheeran instance) =>
    <String, dynamic>{'node': instance.node?.toJson()};

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node()
    ..id = json['id'] as String
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$NodeToJson(Node instance) =>
    <String, dynamic>{'id': instance.id, '__typename': instance.resolveType};

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist()
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : SpotifyArtist.fromJson(json['spotify'] as Map<String, dynamic>)
    ..resolveType = json['__typename'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      '__typename': instance.resolveType,
      'id': instance.id
    };

LifeSpan _$LifeSpanFromJson(Map<String, dynamic> json) {
  return LifeSpan()
    ..begin = fromGraphQLDateToDartDateTime(json['begin'] as String);
}

Map<String, dynamic> _$LifeSpanToJson(LifeSpan instance) =>
    <String, dynamic>{'begin': fromDartDateTimeToGraphQLDate(instance.begin)};

SpotifyArtist _$SpotifyArtistFromJson(Map<String, dynamic> json) {
  return SpotifyArtist()..href = json['href'] as String;
}

Map<String, dynamic> _$SpotifyArtistToJson(SpotifyArtist instance) =>
    <String, dynamic>{'href': instance.href};

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return Entity()
    ..mbid = json['mbid'] as String
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      'mbid': instance.mbid,
      '__typename': instance.resolveType
    };
