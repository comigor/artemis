// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ed_sheeran.query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdSheeran _$EdSheeranFromJson(Map<String, dynamic> json) {
  return EdSheeran(
    node: json['node'] == null
        ? null
        : Node.fromJson(json['node'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EdSheeranToJson(EdSheeran instance) => <String, dynamic>{
      'node': instance.node?.toJson(),
    };

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node(
    id: json['id'] as String,
  )..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'id': instance.id,
      '__typename': instance.resolveType,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    mbid: json['mbid'] as String,
    name: json['name'] as String,
    releases: json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>),
    lifeSpan: json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>),
    spotify: json['spotify'] == null
        ? null
        : SpotifyArtist.fromJson(json['spotify'] as Map<String, dynamic>),
  )
    ..resolveType = json['__typename'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'mbid': instance.mbid,
      'name': instance.name,
      'releases': instance.releases?.toJson(),
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      '__typename': instance.resolveType,
      'id': instance.id,
    };

ReleaseConnection _$ReleaseConnectionFromJson(Map<String, dynamic> json) {
  return ReleaseConnection(
    nodes: (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Release.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReleaseConnectionToJson(ReleaseConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes?.map((e) => e?.toJson())?.toList(),
    };

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return Release()
    ..id = json['id'] as String
    ..status = _$enumDecodeNullable(_$ReleaseStatusEnumMap, json['status'],
        unknownValue: ReleaseStatus.ARTEMIS_UNKNOWN)
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$ReleaseStatusEnumMap[instance.status],
      '__typename': instance.resolveType,
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

const _$ReleaseStatusEnumMap = {
  ReleaseStatus.OFFICIAL: 'OFFICIAL',
  ReleaseStatus.PROMOTION: 'PROMOTION',
  ReleaseStatus.BOOTLEG: 'BOOTLEG',
  ReleaseStatus.PSEUDORELEASE: 'PSEUDORELEASE',
  ReleaseStatus.ARTEMIS_UNKNOWN: 'ARTEMIS_UNKNOWN',
};

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return Entity()..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$EntityToJson(Entity instance) => <String, dynamic>{
      '__typename': instance.resolveType,
    };

LifeSpan _$LifeSpanFromJson(Map<String, dynamic> json) {
  return LifeSpan()
    ..begin = fromGraphQLDateToDartDateTime(json['begin'] as String);
}

Map<String, dynamic> _$LifeSpanToJson(LifeSpan instance) => <String, dynamic>{
      'begin': fromDartDateTimeToGraphQLDate(instance.begin),
    };

SpotifyArtist _$SpotifyArtistFromJson(Map<String, dynamic> json) {
  return SpotifyArtist(
    href: json['href'] as String,
  );
}

Map<String, dynamic> _$SpotifyArtistToJson(SpotifyArtist instance) =>
    <String, dynamic>{
      'href': instance.href,
    };
