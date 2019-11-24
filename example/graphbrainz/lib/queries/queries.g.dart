// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSummary _$ArtistSummaryFromJson(Map<String, dynamic> json) {
  return ArtistSummary()
    ..lookup = json['lookup'] == null
        ? null
        : ArtistSummaryLookupQuery.fromJson(
            json['lookup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistSummaryToJson(ArtistSummary instance) =>
    <String, dynamic>{
      'lookup': instance.lookup?.toJson(),
    };

ArtistSummaryLookupQuery _$ArtistSummaryLookupQueryFromJson(
    Map<String, dynamic> json) {
  return ArtistSummaryLookupQuery()
    ..artist = json['artist'] == null
        ? null
        : ArtistSummaryArtist.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistSummaryLookupQueryToJson(
        ArtistSummaryLookupQuery instance) =>
    <String, dynamic>{
      'artist': instance.artist?.toJson(),
    };

ArtistSummaryArtist _$ArtistSummaryArtistFromJson(Map<String, dynamic> json) {
  return ArtistSummaryArtist()
    ..albums = json['albums'] == null
        ? null
        : ArtistSummaryAlbums.fromJson(json['albums'] as Map<String, dynamic>)
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : ArtistSummaryLifeSpan.fromJson(
            json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : ArtistSummarySpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$ArtistSummaryArtistToJson(
        ArtistSummaryArtist instance) =>
    <String, dynamic>{
      'albums': instance.albums?.toJson(),
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      '__typename': instance.resolveType,
    };

ArtistSummaryAlbums _$ArtistSummaryAlbumsFromJson(Map<String, dynamic> json) {
  return ArtistSummaryAlbums()
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : ArtistSummaryRelease.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ArtistSummaryAlbumsToJson(
        ArtistSummaryAlbums instance) =>
    <String, dynamic>{
      'nodes': instance.nodes?.map((e) => e?.toJson())?.toList(),
    };

ArtistSummaryRelease _$ArtistSummaryReleaseFromJson(Map<String, dynamic> json) {
  return ArtistSummaryRelease()
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..date = fromGraphQLDateToDartDateTime(json['date'] as String)
    ..status = _$enumDecodeNullable(
        _$ArtistSummaryReleaseStatusEnumMap, json['status'])
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$ArtistSummaryReleaseToJson(
        ArtistSummaryRelease instance) =>
    <String, dynamic>{
      'mbid': instance.mbid,
      'title': instance.title,
      'date': fromDartDateTimeToGraphQLDate(instance.date),
      'status': _$ArtistSummaryReleaseStatusEnumMap[instance.status],
      '__typename': instance.resolveType,
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$ArtistSummaryReleaseStatusEnumMap =
    <ArtistSummaryReleaseStatus, dynamic>{
  ArtistSummaryReleaseStatus.OFFICIAL: 'OFFICIAL',
  ArtistSummaryReleaseStatus.PROMOTION: 'PROMOTION',
  ArtistSummaryReleaseStatus.BOOTLEG: 'BOOTLEG',
  ArtistSummaryReleaseStatus.PSEUDORELEASE: 'PSEUDORELEASE'
};

ArtistSummaryNode _$ArtistSummaryNodeFromJson(Map<String, dynamic> json) {
  return ArtistSummaryNode()..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$ArtistSummaryNodeToJson(ArtistSummaryNode instance) =>
    <String, dynamic>{
      '__typename': instance.resolveType,
    };

ArtistSummaryEntity _$ArtistSummaryEntityFromJson(Map<String, dynamic> json) {
  return ArtistSummaryEntity()
    ..mbid = json['mbid'] as String
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$ArtistSummaryEntityToJson(
        ArtistSummaryEntity instance) =>
    <String, dynamic>{
      'mbid': instance.mbid,
      '__typename': instance.resolveType,
    };

ArtistSummaryLifeSpan _$ArtistSummaryLifeSpanFromJson(
    Map<String, dynamic> json) {
  return ArtistSummaryLifeSpan()
    ..begin = fromGraphQLDateToDartDateTime(json['begin'] as String);
}

Map<String, dynamic> _$ArtistSummaryLifeSpanToJson(
        ArtistSummaryLifeSpan instance) =>
    <String, dynamic>{
      'begin': fromDartDateTimeToGraphQLDate(instance.begin),
    };

ArtistSummarySpotifyArtist _$ArtistSummarySpotifyArtistFromJson(
    Map<String, dynamic> json) {
  return ArtistSummarySpotifyArtist()..href = json['href'] as String;
}

Map<String, dynamic> _$ArtistSummarySpotifyArtistToJson(
        ArtistSummarySpotifyArtist instance) =>
    <String, dynamic>{
      'href': instance.href,
    };

ArtistSummaryArguments _$ArtistSummaryArgumentsFromJson(
    Map<String, dynamic> json) {
  return ArtistSummaryArguments(
    mbid: json['mbid'] as String,
  );
}

Map<String, dynamic> _$ArtistSummaryArgumentsToJson(
        ArtistSummaryArguments instance) =>
    <String, dynamic>{
      'mbid': instance.mbid,
    };

EdSheeran _$EdSheeranFromJson(Map<String, dynamic> json) {
  return EdSheeran()
    ..node = json['node'] == null
        ? null
        : EdSheeranNode.fromJson(json['node'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EdSheeranToJson(EdSheeran instance) => <String, dynamic>{
      'node': instance.node?.toJson(),
    };

EdSheeranNode _$EdSheeranNodeFromJson(Map<String, dynamic> json) {
  return EdSheeranNode()
    ..id = json['id'] as String
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$EdSheeranNodeToJson(EdSheeranNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      '__typename': instance.resolveType,
    };

EdSheeranArtist _$EdSheeranArtistFromJson(Map<String, dynamic> json) {
  return EdSheeranArtist()
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : EdSheeranLifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : EdSheeranSpotifyArtist.fromJson(
            json['spotify'] as Map<String, dynamic>)
    ..resolveType = json['__typename'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$EdSheeranArtistToJson(EdSheeranArtist instance) =>
    <String, dynamic>{
      'mbid': instance.mbid,
      'name': instance.name,
      'lifeSpan': instance.lifeSpan?.toJson(),
      'spotify': instance.spotify?.toJson(),
      '__typename': instance.resolveType,
      'id': instance.id,
    };

EdSheeranLifeSpan _$EdSheeranLifeSpanFromJson(Map<String, dynamic> json) {
  return EdSheeranLifeSpan()
    ..begin = fromGraphQLDateToDartDateTime(json['begin'] as String);
}

Map<String, dynamic> _$EdSheeranLifeSpanToJson(EdSheeranLifeSpan instance) =>
    <String, dynamic>{
      'begin': fromDartDateTimeToGraphQLDate(instance.begin),
    };

EdSheeranSpotifyArtist _$EdSheeranSpotifyArtistFromJson(
    Map<String, dynamic> json) {
  return EdSheeranSpotifyArtist()..href = json['href'] as String;
}

Map<String, dynamic> _$EdSheeranSpotifyArtistToJson(
        EdSheeranSpotifyArtist instance) =>
    <String, dynamic>{
      'href': instance.href,
    };

EdSheeranEntity _$EdSheeranEntityFromJson(Map<String, dynamic> json) {
  return EdSheeranEntity()
    ..mbid = json['mbid'] as String
    ..resolveType = json['__typename'] as String;
}

Map<String, dynamic> _$EdSheeranEntityToJson(EdSheeranEntity instance) =>
    <String, dynamic>{
      'mbid': instance.mbid,
      '__typename': instance.resolveType,
    };
