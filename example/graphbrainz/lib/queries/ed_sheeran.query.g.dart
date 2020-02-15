// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ed_sheeran.query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdSheeran$Query$Node$Artist$ReleaseConnection$Release
    _$EdSheeran$Query$Node$Artist$ReleaseConnection$ReleaseFromJson(
        Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist$ReleaseConnection$Release()
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..releases = json['releases'] == null
        ? null
        : EdSheeran$Query$Node$Artist$ReleaseConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : EdSheeran$Query$Node$Artist$ReleaseConnection$Release.fromJson(
                e as Map<String, dynamic>))
        ?.toList()
    ..id = json['id'] as String
    ..status = _$enumDecodeNullable(
        _$EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatusEnumMap,
        json['status'],
        unknownValue:
            EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus
                .ARTEMIS_UNKNOWN);
}

Map<String, dynamic>
    _$EdSheeran$Query$Node$Artist$ReleaseConnection$ReleaseToJson(
            EdSheeran$Query$Node$Artist$ReleaseConnection$Release instance) =>
        <String, dynamic>{
          '__typename': instance.typeName,
          'mbid': instance.mbid,
          'name': instance.name,
          'releases': instance.releases?.toJson(),
          'lifeSpan': instance.lifeSpan?.toJson(),
          'spotify': instance.spotify?.toJson(),
          'nodes': instance.nodes?.map((e) => e?.toJson())?.toList(),
          'id': instance.id,
          'status':
              _$EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatusEnumMap[
                  instance.status],
        };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatusEnumMap =
    {
  EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus.OFFICIAL:
      'OFFICIAL',
  EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus.PROMOTION:
      'PROMOTION',
  EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus.BOOTLEG:
      'BOOTLEG',
  EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus
      .PSEUDORELEASE: 'PSEUDORELEASE',
  EdSheeran$Query$Node$Artist$ReleaseConnection$Release$ReleaseStatus
      .ARTEMIS_UNKNOWN: 'ARTEMIS_UNKNOWN',
};

EdSheeran$Query$Node$Artist$ReleaseConnection
    _$EdSheeran$Query$Node$Artist$ReleaseConnectionFromJson(
        Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist$ReleaseConnection()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..releases = json['releases'] == null
        ? null
        : EdSheeran$Query$Node$Artist$ReleaseConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeran$Query$Node$Artist$LifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeran$Query$Node$Artist$SpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : EdSheeran$Query$Node$Artist$ReleaseConnection$Release.fromJson(
                e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$ReleaseConnectionToJson(
        EdSheeran$Query$Node$Artist$ReleaseConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.typeName,
      'mbid': instance.mbid,
      'name': instance.name,
      'releases': instance.releases?.toJson(),
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      'nodes': instance.nodes?.map((e) => e?.toJson())?.toList(),
    };

EdSheeran$Query$Node$Artist$LifeSpan
    _$EdSheeran$Query$Node$Artist$LifeSpanFromJson(Map<String, dynamic> json) {
  return EdSheeran$Query$Node$Artist$LifeSpan()
    ..id = json['id'] as String
    ..typeName = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..releases = json['releases'] == null
        ? null
        : EdSheeran$Query$Node$Artist$ReleaseConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
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
      'releases': instance.releases?.toJson(),
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
    ..releases = json['releases'] == null
        ? null
        : EdSheeran$Query$Node$Artist$ReleaseConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
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
      'releases': instance.releases?.toJson(),
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
    ..releases = json['releases'] == null
        ? null
        : EdSheeran$Query$Node$Artist$ReleaseConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
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
      'releases': instance.releases?.toJson(),
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
