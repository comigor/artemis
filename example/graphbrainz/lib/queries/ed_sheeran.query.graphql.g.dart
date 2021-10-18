// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'ed_sheeran.query.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdSheeran$Query$Node$Artist$ReleaseConnection$Release
    _$EdSheeran$Query$Node$Artist$ReleaseConnection$ReleaseFromJson(
            Map<String, dynamic> json) =>
        EdSheeran$Query$Node$Artist$ReleaseConnection$Release()
          ..id = json['id'] as String
          ..status = _$enumDecodeNullable(
              _$ReleaseStatusEnumMap, json['status'],
              unknownValue: ReleaseStatus.artemisUnknown);

Map<String, dynamic>
    _$EdSheeran$Query$Node$Artist$ReleaseConnection$ReleaseToJson(
            EdSheeran$Query$Node$Artist$ReleaseConnection$Release instance) =>
        <String, dynamic>{
          'id': instance.id,
          'status': _$ReleaseStatusEnumMap[instance.status],
        };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ReleaseStatusEnumMap = {
  ReleaseStatus.official: 'OFFICIAL',
  ReleaseStatus.promotion: 'PROMOTION',
  ReleaseStatus.bootleg: 'BOOTLEG',
  ReleaseStatus.pseudorelease: 'PSEUDORELEASE',
  ReleaseStatus.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

EdSheeran$Query$Node$Artist$ReleaseConnection
    _$EdSheeran$Query$Node$Artist$ReleaseConnectionFromJson(
            Map<String, dynamic> json) =>
        EdSheeran$Query$Node$Artist$ReleaseConnection()
          ..nodes = (json['nodes'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : EdSheeran$Query$Node$Artist$ReleaseConnection$Release
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$ReleaseConnectionToJson(
        EdSheeran$Query$Node$Artist$ReleaseConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes?.map((e) => e?.toJson()).toList(),
    };

EdSheeran$Query$Node$Artist$LifeSpan
    _$EdSheeran$Query$Node$Artist$LifeSpanFromJson(Map<String, dynamic> json) =>
        EdSheeran$Query$Node$Artist$LifeSpan()
          ..begin = json['begin'] == null
              ? null
              : DateTime.parse(json['begin'] as String);

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$LifeSpanToJson(
        EdSheeran$Query$Node$Artist$LifeSpan instance) =>
    <String, dynamic>{
      'begin': instance.begin?.toIso8601String(),
    };

EdSheeran$Query$Node$Artist$SpotifyArtist
    _$EdSheeran$Query$Node$Artist$SpotifyArtistFromJson(
            Map<String, dynamic> json) =>
        EdSheeran$Query$Node$Artist$SpotifyArtist()
          ..href = json['href'] as String;

Map<String, dynamic> _$EdSheeran$Query$Node$Artist$SpotifyArtistToJson(
        EdSheeran$Query$Node$Artist$SpotifyArtist instance) =>
    <String, dynamic>{
      'href': instance.href,
    };

EdSheeran$Query$Node$Artist _$EdSheeran$Query$Node$ArtistFromJson(
        Map<String, dynamic> json) =>
    EdSheeran$Query$Node$Artist()
      ..$$typename = json['__typename'] as String?
      ..id = json['id'] as String
      ..mbid = json['mbid'] as String
      ..name = json['name'] as String?
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

Map<String, dynamic> _$EdSheeran$Query$Node$ArtistToJson(
        EdSheeran$Query$Node$Artist instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'releases': instance.releases?.toJson(),
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
    };

EdSheeran$Query$Node _$EdSheeran$Query$NodeFromJson(
        Map<String, dynamic> json) =>
    EdSheeran$Query$Node()
      ..$$typename = json['__typename'] as String?
      ..id = json['id'] as String;

Map<String, dynamic> _$EdSheeran$Query$NodeToJson(
        EdSheeran$Query$Node instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
    };

EdSheeran$Query _$EdSheeran$QueryFromJson(Map<String, dynamic> json) =>
    EdSheeran$Query()
      ..node = json['node'] == null
          ? null
          : EdSheeran$Query$Node.fromJson(json['node'] as Map<String, dynamic>);

Map<String, dynamic> _$EdSheeran$QueryToJson(EdSheeran$Query instance) =>
    <String, dynamic>{
      'node': instance.node?.toJson(),
    };
