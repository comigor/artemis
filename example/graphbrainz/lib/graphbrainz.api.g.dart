// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphbrainz.api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query _$QueryFromJson(Map<String, dynamic> json) {
  return Query()
    ..typename = json['__typename'] as String
    ..lookup = json['lookup'] == null
        ? null
        : LookupQuery.fromJson(json['lookup'] as Map<String, dynamic>)
    ..browse = json['browse'] == null
        ? null
        : BrowseQuery.fromJson(json['browse'] as Map<String, dynamic>)
    ..search = json['search'] == null
        ? null
        : SearchQuery.fromJson(json['search'] as Map<String, dynamic>)
    ..node = json['node'] == null
        ? null
        : Node.fromJson(json['node'] as Map<String, dynamic>)
    ..lastFM = json['lastFM'] == null
        ? null
        : LastFMQuery.fromJson(json['lastFM'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : SpotifyQuery.fromJson(json['spotify'] as Map<String, dynamic>);
}

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      '__typename': instance.typename,
      'lookup': instance.lookup,
      'browse': instance.browse,
      'search': instance.search,
      'node': instance.node,
      'lastFM': instance.lastFM,
      'spotify': instance.spotify
    };

LookupQuery _$LookupQueryFromJson(Map<String, dynamic> json) {
  return LookupQuery()
    ..typename = json['__typename'] as String
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..artist = json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>)
    ..collection = json['collection'] == null
        ? null
        : Collection.fromJson(json['collection'] as Map<String, dynamic>)
    ..disc = json['disc'] == null
        ? null
        : Disc.fromJson(json['disc'] as Map<String, dynamic>)
    ..event = json['event'] == null
        ? null
        : Event.fromJson(json['event'] as Map<String, dynamic>)
    ..instrument = json['instrument'] == null
        ? null
        : Instrument.fromJson(json['instrument'] as Map<String, dynamic>)
    ..label = json['label'] == null
        ? null
        : Label.fromJson(json['label'] as Map<String, dynamic>)
    ..place = json['place'] == null
        ? null
        : Place.fromJson(json['place'] as Map<String, dynamic>)
    ..recording = json['recording'] == null
        ? null
        : Recording.fromJson(json['recording'] as Map<String, dynamic>)
    ..release = json['release'] == null
        ? null
        : Release.fromJson(json['release'] as Map<String, dynamic>)
    ..releaseGroup = json['releaseGroup'] == null
        ? null
        : ReleaseGroup.fromJson(json['releaseGroup'] as Map<String, dynamic>)
    ..series = json['series'] == null
        ? null
        : Series.fromJson(json['series'] as Map<String, dynamic>)
    ..url = json['url'] == null
        ? null
        : URL.fromJson(json['url'] as Map<String, dynamic>)
    ..work = json['work'] == null
        ? null
        : Work.fromJson(json['work'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LookupQueryToJson(LookupQuery instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'area': instance.area,
      'artist': instance.artist,
      'collection': instance.collection,
      'disc': instance.disc,
      'event': instance.event,
      'instrument': instance.instrument,
      'label': instance.label,
      'place': instance.place,
      'recording': instance.recording,
      'release': instance.release,
      'releaseGroup': instance.releaseGroup,
      'series': instance.series,
      'url': instance.url,
      'work': instance.work
    };

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..sortName = json['sortName'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isoCodes = (json['isoCodes'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..events = json['events'] == null
        ? null
        : EventConnection.fromJson(json['events'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : LabelConnection.fromJson(json['labels'] as Map<String, dynamic>)
    ..places = json['places'] == null
        ? null
        : PlaceConnection.fromJson(json['places'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..lastFM = json['lastFM'] == null
        ? null
        : LastFMCountry.fromJson(json['lastFM'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'sortName': instance.sortName,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'isoCodes': instance.isoCodes,
      'type': instance.type,
      'typeID': instance.typeID,
      'artists': instance.artists,
      'events': instance.events,
      'labels': instance.labels,
      'places': instance.places,
      'releases': instance.releases,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'tags': instance.tags,
      'lastFM': instance.lastFM
    };

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$NodeToJson(Node instance) =>
    <String, dynamic>{'__typename': instance.typename, 'id': instance.id};

Entity _$EntityFromJson(Map<String, dynamic> json) {
  return Entity()
    ..typename = json['__typename'] as String
    ..mbid = json['mbid'] as String;
}

Map<String, dynamic> _$EntityToJson(Entity instance) =>
    <String, dynamic>{'__typename': instance.typename, 'mbid': instance.mbid};

Alias _$AliasFromJson(Map<String, dynamic> json) {
  return Alias()
    ..typename = json['__typename'] as String
    ..name = json['name'] as String
    ..sortName = json['sortName'] as String
    ..locale = json['locale'] as String
    ..primary = json['primary'] as bool
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String;
}

Map<String, dynamic> _$AliasToJson(Alias instance) => <String, dynamic>{
      '__typename': instance.typename,
      'name': instance.name,
      'sortName': instance.sortName,
      'locale': instance.locale,
      'primary': instance.primary,
      'type': instance.type,
      'typeID': instance.typeID
    };

ArtistConnection _$ArtistConnectionFromJson(Map<String, dynamic> json) {
  return ArtistConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : ArtistEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$ArtistConnectionToJson(ArtistConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) {
  return PageInfo()
    ..typename = json['__typename'] as String
    ..hasNextPage = json['hasNextPage'] as bool
    ..hasPreviousPage = json['hasPreviousPage'] as bool
    ..startCursor = json['startCursor'] as String
    ..endCursor = json['endCursor'] as String;
}

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      '__typename': instance.typename,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'startCursor': instance.startCursor,
      'endCursor': instance.endCursor
    };

ArtistEdge _$ArtistEdgeFromJson(Map<String, dynamic> json) {
  return ArtistEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Artist.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$ArtistEdgeToJson(ArtistEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..sortName = json['sortName'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..country = json['country'] as String
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..beginArea = json['beginArea'] == null
        ? null
        : Area.fromJson(json['beginArea'] as Map<String, dynamic>)
    ..endArea = json['endArea'] == null
        ? null
        : Area.fromJson(json['endArea'] as Map<String, dynamic>)
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..gender = json['gender'] as String
    ..genderID = json['genderID'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..ipis = (json['ipis'] as List)?.map((e) => e as String)?.toList()
    ..isnis = (json['isnis'] as List)?.map((e) => e as String)?.toList()
    ..recordings = json['recordings'] == null
        ? null
        : RecordingConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : ReleaseGroupConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..works = json['works'] == null
        ? null
        : WorkConnection.fromJson(json['works'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..fanArt = json['fanArt'] == null
        ? null
        : FanArtArtist.fromJson(json['fanArt'] as Map<String, dynamic>)
    ..mediaWikiImages = (json['mediaWikiImages'] as List)
        ?.map((e) => e == null
            ? null
            : MediaWikiImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..theAudioDB = json['theAudioDB'] == null
        ? null
        : TheAudioDBArtist.fromJson(json['theAudioDB'] as Map<String, dynamic>)
    ..discogs = json['discogs'] == null
        ? null
        : DiscogsArtist.fromJson(json['discogs'] as Map<String, dynamic>)
    ..lastFM = json['lastFM'] == null
        ? null
        : LastFMArtist.fromJson(json['lastFM'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : SpotifyArtist.fromJson(json['spotify'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'sortName': instance.sortName,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'country': instance.country,
      'area': instance.area,
      'beginArea': instance.beginArea,
      'endArea': instance.endArea,
      'lifeSpan': instance.lifeSpan,
      'gender': instance.gender,
      'genderID': instance.genderID,
      'type': instance.type,
      'typeID': instance.typeID,
      'ipis': instance.ipis,
      'isnis': instance.isnis,
      'recordings': instance.recordings,
      'releases': instance.releases,
      'releaseGroups': instance.releaseGroups,
      'works': instance.works,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags,
      'fanArt': instance.fanArt,
      'mediaWikiImages': instance.mediaWikiImages,
      'theAudioDB': instance.theAudioDB,
      'discogs': instance.discogs,
      'lastFM': instance.lastFM,
      'spotify': instance.spotify
    };

LifeSpan _$LifeSpanFromJson(Map<String, dynamic> json) {
  return LifeSpan()
    ..typename = json['__typename'] as String
    ..begin = json['begin'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['begin'] as String)
    ..end = json['end'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['end'] as String)
    ..ended = json['ended'] as bool;
}

Map<String, dynamic> _$LifeSpanToJson(LifeSpan instance) => <String, dynamic>{
      '__typename': instance.typename,
      'begin': instance.begin == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.begin),
      'end': instance.end == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.end),
      'ended': instance.ended
    };

RecordingConnection _$RecordingConnectionFromJson(Map<String, dynamic> json) {
  return RecordingConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : RecordingEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Recording.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$RecordingConnectionToJson(
        RecordingConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

RecordingEdge _$RecordingEdgeFromJson(Map<String, dynamic> json) {
  return RecordingEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Recording.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$RecordingEdgeToJson(RecordingEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Recording _$RecordingFromJson(Map<String, dynamic> json) {
  return Recording()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredit = (json['artistCredit'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredits = (json['artistCredits'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isrcs = (json['isrcs'] as List)?.map((e) => e as String)?.toList()
    ..length = json['length'] == null
        ? null
        : Duration(microseconds: json['length'] as int)
    ..video = json['video'] as bool
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..theAudioDB = json['theAudioDB'] == null
        ? null
        : TheAudioDBTrack.fromJson(json['theAudioDB'] as Map<String, dynamic>)
    ..lastFM = json['lastFM'] == null
        ? null
        : LastFMTrack.fromJson(json['lastFM'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : SpotifyTrack.fromJson(json['spotify'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RecordingToJson(Recording instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'title': instance.title,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'artistCredit': instance.artistCredit,
      'artistCredits': instance.artistCredits,
      'isrcs': instance.isrcs,
      'length': instance.length?.inMicroseconds,
      'video': instance.video,
      'artists': instance.artists,
      'releases': instance.releases,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags,
      'theAudioDB': instance.theAudioDB,
      'lastFM': instance.lastFM,
      'spotify': instance.spotify
    };

ArtistCredit _$ArtistCreditFromJson(Map<String, dynamic> json) {
  return ArtistCredit()
    ..typename = json['__typename'] as String
    ..artist = json['artist'] == null
        ? null
        : Artist.fromJson(json['artist'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..joinPhrase = json['joinPhrase'] as String;
}

Map<String, dynamic> _$ArtistCreditToJson(ArtistCredit instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'artist': instance.artist,
      'name': instance.name,
      'joinPhrase': instance.joinPhrase
    };

ReleaseConnection _$ReleaseConnectionFromJson(Map<String, dynamic> json) {
  return ReleaseConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : ReleaseEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Release.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$ReleaseConnectionToJson(ReleaseConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

ReleaseEdge _$ReleaseEdgeFromJson(Map<String, dynamic> json) {
  return ReleaseEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Release.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$ReleaseEdgeToJson(ReleaseEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return Release()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredit = (json['artistCredit'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredits = (json['artistCredits'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..releaseEvents = (json['releaseEvents'] as List)
        ?.map((e) =>
            e == null ? null : ReleaseEvent.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..date = json['date'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['date'] as String)
    ..country = json['country'] as String
    ..asin = json['asin'] as String
    ..barcode = json['barcode'] as String
    ..status = _$enumDecodeNullable(_$ReleaseStatusEnumMap, json['status'])
    ..statusID = json['statusID'] as String
    ..packaging = json['packaging'] as String
    ..packagingID = json['packagingID'] as String
    ..quality = json['quality'] as String
    ..media = (json['media'] as List)
        ?.map((e) =>
            e == null ? null : Medium.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : LabelConnection.fromJson(json['labels'] as Map<String, dynamic>)
    ..recordings = json['recordings'] == null
        ? null
        : RecordingConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : ReleaseGroupConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..coverArtArchive = json['coverArtArchive'] == null
        ? null
        : CoverArtArchiveRelease.fromJson(
            json['coverArtArchive'] as Map<String, dynamic>)
    ..discogs = json['discogs'] == null
        ? null
        : DiscogsRelease.fromJson(json['discogs'] as Map<String, dynamic>)
    ..lastFM = json['lastFM'] == null
        ? null
        : LastFMAlbum.fromJson(json['lastFM'] as Map<String, dynamic>)
    ..spotify = json['spotify'] == null
        ? null
        : SpotifyAlbum.fromJson(json['spotify'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'title': instance.title,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'artistCredit': instance.artistCredit,
      'artistCredits': instance.artistCredits,
      'releaseEvents': instance.releaseEvents,
      'date': instance.date == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.date),
      'country': instance.country,
      'asin': instance.asin,
      'barcode': instance.barcode,
      'status': _$ReleaseStatusEnumMap[instance.status],
      'statusID': instance.statusID,
      'packaging': instance.packaging,
      'packagingID': instance.packagingID,
      'quality': instance.quality,
      'media': instance.media,
      'artists': instance.artists,
      'labels': instance.labels,
      'recordings': instance.recordings,
      'releaseGroups': instance.releaseGroups,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'tags': instance.tags,
      'coverArtArchive': instance.coverArtArchive,
      'discogs': instance.discogs,
      'lastFM': instance.lastFM,
      'spotify': instance.spotify
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

const _$ReleaseStatusEnumMap = <ReleaseStatus, dynamic>{
  ReleaseStatus.OFFICIAL: 'OFFICIAL',
  ReleaseStatus.PROMOTION: 'PROMOTION',
  ReleaseStatus.BOOTLEG: 'BOOTLEG',
  ReleaseStatus.PSEUDORELEASE: 'PSEUDORELEASE'
};

ReleaseEvent _$ReleaseEventFromJson(Map<String, dynamic> json) {
  return ReleaseEvent()
    ..typename = json['__typename'] as String
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..date = json['date'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['date'] as String);
}

Map<String, dynamic> _$ReleaseEventToJson(ReleaseEvent instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'area': instance.area,
      'date': instance.date == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.date)
    };

Medium _$MediumFromJson(Map<String, dynamic> json) {
  return Medium()
    ..typename = json['__typename'] as String
    ..title = json['title'] as String
    ..format = json['format'] as String
    ..formatID = json['formatID'] as String
    ..position = json['position'] as int
    ..trackCount = json['trackCount'] as int
    ..discs = (json['discs'] as List)
        ?.map(
            (e) => e == null ? null : Disc.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tracks = (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MediumToJson(Medium instance) => <String, dynamic>{
      '__typename': instance.typename,
      'title': instance.title,
      'format': instance.format,
      'formatID': instance.formatID,
      'position': instance.position,
      'trackCount': instance.trackCount,
      'discs': instance.discs,
      'tracks': instance.tracks
    };

Disc _$DiscFromJson(Map<String, dynamic> json) {
  return Disc()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..discID = json['discID'] as String
    ..offsetCount = json['offsetCount'] as int
    ..offsets = (json['offsets'] as List)?.map((e) => e as int)?.toList()
    ..sectors = json['sectors'] as int
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DiscToJson(Disc instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'discID': instance.discID,
      'offsetCount': instance.offsetCount,
      'offsets': instance.offsets,
      'sectors': instance.sectors,
      'releases': instance.releases
    };

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track()
    ..typename = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..position = json['position'] as int
    ..number = json['number'] as String
    ..length = json['length'] == null
        ? null
        : Duration(microseconds: json['length'] as int)
    ..recording = json['recording'] == null
        ? null
        : Recording.fromJson(json['recording'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      '__typename': instance.typename,
      'mbid': instance.mbid,
      'title': instance.title,
      'position': instance.position,
      'number': instance.number,
      'length': instance.length?.inMicroseconds,
      'recording': instance.recording
    };

LabelConnection _$LabelConnectionFromJson(Map<String, dynamic> json) {
  return LabelConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : LabelEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map(
            (e) => e == null ? null : Label.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$LabelConnectionToJson(LabelConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

LabelEdge _$LabelEdgeFromJson(Map<String, dynamic> json) {
  return LabelEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Label.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$LabelEdgeToJson(LabelEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Label _$LabelFromJson(Map<String, dynamic> json) {
  return Label()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..sortName = json['sortName'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..country = json['country'] as String
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..labelCode = json['labelCode'] as int
    ..ipis = (json['ipis'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..fanArt = json['fanArt'] == null
        ? null
        : FanArtLabel.fromJson(json['fanArt'] as Map<String, dynamic>)
    ..mediaWikiImages = (json['mediaWikiImages'] as List)
        ?.map((e) => e == null
            ? null
            : MediaWikiImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..discogs = json['discogs'] == null
        ? null
        : DiscogsLabel.fromJson(json['discogs'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'sortName': instance.sortName,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'country': instance.country,
      'area': instance.area,
      'lifeSpan': instance.lifeSpan,
      'labelCode': instance.labelCode,
      'ipis': instance.ipis,
      'type': instance.type,
      'typeID': instance.typeID,
      'releases': instance.releases,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags,
      'fanArt': instance.fanArt,
      'mediaWikiImages': instance.mediaWikiImages,
      'discogs': instance.discogs
    };

Relationships _$RelationshipsFromJson(Map<String, dynamic> json) {
  return Relationships()
    ..typename = json['__typename'] as String
    ..areas = json['areas'] == null
        ? null
        : RelationshipConnection.fromJson(json['areas'] as Map<String, dynamic>)
    ..artists = json['artists'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['artists'] as Map<String, dynamic>)
    ..events = json['events'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['events'] as Map<String, dynamic>)
    ..instruments = json['instruments'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['instruments'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['labels'] as Map<String, dynamic>)
    ..places = json['places'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['places'] as Map<String, dynamic>)
    ..recordings = json['recordings'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['releases'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..series = json['series'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['series'] as Map<String, dynamic>)
    ..urls = json['urls'] == null
        ? null
        : RelationshipConnection.fromJson(json['urls'] as Map<String, dynamic>)
    ..works = json['works'] == null
        ? null
        : RelationshipConnection.fromJson(
            json['works'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RelationshipsToJson(Relationships instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'areas': instance.areas,
      'artists': instance.artists,
      'events': instance.events,
      'instruments': instance.instruments,
      'labels': instance.labels,
      'places': instance.places,
      'recordings': instance.recordings,
      'releases': instance.releases,
      'releaseGroups': instance.releaseGroups,
      'series': instance.series,
      'urls': instance.urls,
      'works': instance.works
    };

RelationshipConnection _$RelationshipConnectionFromJson(
    Map<String, dynamic> json) {
  return RelationshipConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : RelationshipEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Relationship.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$RelationshipConnectionToJson(
        RelationshipConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

RelationshipEdge _$RelationshipEdgeFromJson(Map<String, dynamic> json) {
  return RelationshipEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Relationship.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$RelationshipEdgeToJson(RelationshipEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  return Relationship()
    ..typename = json['__typename'] as String
    ..target = json['target'] == null
        ? null
        : Entity.fromJson(json['target'] as Map<String, dynamic>)
    ..direction = json['direction'] as String
    ..targetType = json['targetType'] as String
    ..sourceCredit = json['sourceCredit'] as String
    ..targetCredit = json['targetCredit'] as String
    ..begin = json['begin'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['begin'] as String)
    ..end = json['end'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['end'] as String)
    ..ended = json['ended'] as bool
    ..attributes =
        (json['attributes'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String;
}

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'target': instance.target,
      'direction': instance.direction,
      'targetType': instance.targetType,
      'sourceCredit': instance.sourceCredit,
      'targetCredit': instance.targetCredit,
      'begin': instance.begin == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.begin),
      'end': instance.end == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.end),
      'ended': instance.ended,
      'attributes': instance.attributes,
      'type': instance.type,
      'typeID': instance.typeID
    };

CollectionConnection _$CollectionConnectionFromJson(Map<String, dynamic> json) {
  return CollectionConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : CollectionEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Collection.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$CollectionConnectionToJson(
        CollectionConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

CollectionEdge _$CollectionEdgeFromJson(Map<String, dynamic> json) {
  return CollectionEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Collection.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$CollectionEdgeToJson(CollectionEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..editor = json['editor'] as String
    ..entityType = json['entityType'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..areas = json['areas'] == null
        ? null
        : AreaConnection.fromJson(json['areas'] as Map<String, dynamic>)
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..events = json['events'] == null
        ? null
        : EventConnection.fromJson(json['events'] as Map<String, dynamic>)
    ..instruments = json['instruments'] == null
        ? null
        : InstrumentConnection.fromJson(
            json['instruments'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : LabelConnection.fromJson(json['labels'] as Map<String, dynamic>)
    ..places = json['places'] == null
        ? null
        : PlaceConnection.fromJson(json['places'] as Map<String, dynamic>)
    ..recordings = json['recordings'] == null
        ? null
        : RecordingConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : ReleaseGroupConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..series = json['series'] == null
        ? null
        : SeriesConnection.fromJson(json['series'] as Map<String, dynamic>)
    ..works = json['works'] == null
        ? null
        : WorkConnection.fromJson(json['works'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'editor': instance.editor,
      'entityType': instance.entityType,
      'type': instance.type,
      'typeID': instance.typeID,
      'areas': instance.areas,
      'artists': instance.artists,
      'events': instance.events,
      'instruments': instance.instruments,
      'labels': instance.labels,
      'places': instance.places,
      'recordings': instance.recordings,
      'releases': instance.releases,
      'releaseGroups': instance.releaseGroups,
      'series': instance.series,
      'works': instance.works
    };

AreaConnection _$AreaConnectionFromJson(Map<String, dynamic> json) {
  return AreaConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : AreaEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map(
            (e) => e == null ? null : Area.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$AreaConnectionToJson(AreaConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

AreaEdge _$AreaEdgeFromJson(Map<String, dynamic> json) {
  return AreaEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Area.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$AreaEdgeToJson(AreaEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

EventConnection _$EventConnectionFromJson(Map<String, dynamic> json) {
  return EventConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : EventEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$EventConnectionToJson(EventConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

EventEdge _$EventEdgeFromJson(Map<String, dynamic> json) {
  return EventEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Event.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$EventEdgeToJson(EventEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..time = json['time'] == null
        ? null
        : fromGraphQLTimeToDartDateTime(json['time'] as String)
    ..cancelled = json['cancelled'] as bool
    ..setlist = json['setlist'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'lifeSpan': instance.lifeSpan,
      'time': instance.time == null
          ? null
          : fromDartDateTimeToGraphQLTime(instance.time),
      'cancelled': instance.cancelled,
      'setlist': instance.setlist,
      'type': instance.type,
      'typeID': instance.typeID,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating()
    ..typename = json['__typename'] as String
    ..voteCount = json['voteCount'] as int
    ..value = (json['value'] as num)?.toDouble();
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      '__typename': instance.typename,
      'voteCount': instance.voteCount,
      'value': instance.value
    };

TagConnection _$TagConnectionFromJson(Map<String, dynamic> json) {
  return TagConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : TagEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$TagConnectionToJson(TagConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

TagEdge _$TagEdgeFromJson(Map<String, dynamic> json) {
  return TagEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Tag.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$TagEdgeToJson(TagEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..typename = json['__typename'] as String
    ..name = json['name'] as String
    ..count = json['count'] as int;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      '__typename': instance.typename,
      'name': instance.name,
      'count': instance.count
    };

InstrumentConnection _$InstrumentConnectionFromJson(Map<String, dynamic> json) {
  return InstrumentConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : InstrumentEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Instrument.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$InstrumentConnectionToJson(
        InstrumentConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

InstrumentEdge _$InstrumentEdgeFromJson(Map<String, dynamic> json) {
  return InstrumentEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Instrument.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$InstrumentEdgeToJson(InstrumentEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Instrument _$InstrumentFromJson(Map<String, dynamic> json) {
  return Instrument()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..description = json['description'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..mediaWikiImages = (json['mediaWikiImages'] as List)
        ?.map((e) => e == null
            ? null
            : MediaWikiImage.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$InstrumentToJson(Instrument instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'description': instance.description,
      'type': instance.type,
      'typeID': instance.typeID,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'tags': instance.tags,
      'mediaWikiImages': instance.mediaWikiImages
    };

MediaWikiImage _$MediaWikiImageFromJson(Map<String, dynamic> json) {
  return MediaWikiImage()
    ..typename = json['__typename'] as String
    ..url = json['url'] as String
    ..descriptionURL = json['descriptionURL'] as String
    ..user = json['user'] as String
    ..size = json['size'] as int
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..canonicalTitle = json['canonicalTitle'] as String
    ..objectName = json['objectName'] as String
    ..descriptionHTML = json['descriptionHTML'] as String
    ..originalDateTimeHTML = json['originalDateTimeHTML'] as String
    ..categories =
        (json['categories'] as List)?.map((e) => e as String)?.toList()
    ..artistHTML = json['artistHTML'] as String
    ..creditHTML = json['creditHTML'] as String
    ..licenseShortName = json['licenseShortName'] as String
    ..licenseURL = json['licenseURL'] as String
    ..metadata = (json['metadata'] as List)
        ?.map((e) => e == null
            ? null
            : MediaWikiImageMetadata.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MediaWikiImageToJson(MediaWikiImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'url': instance.url,
      'descriptionURL': instance.descriptionURL,
      'user': instance.user,
      'size': instance.size,
      'width': instance.width,
      'height': instance.height,
      'canonicalTitle': instance.canonicalTitle,
      'objectName': instance.objectName,
      'descriptionHTML': instance.descriptionHTML,
      'originalDateTimeHTML': instance.originalDateTimeHTML,
      'categories': instance.categories,
      'artistHTML': instance.artistHTML,
      'creditHTML': instance.creditHTML,
      'licenseShortName': instance.licenseShortName,
      'licenseURL': instance.licenseURL,
      'metadata': instance.metadata
    };

MediaWikiImageMetadata _$MediaWikiImageMetadataFromJson(
    Map<String, dynamic> json) {
  return MediaWikiImageMetadata()
    ..typename = json['__typename'] as String
    ..name = json['name'] as String
    ..value = json['value'] as String
    ..source = json['source'] as String;
}

Map<String, dynamic> _$MediaWikiImageMetadataToJson(
        MediaWikiImageMetadata instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'name': instance.name,
      'value': instance.value,
      'source': instance.source
    };

PlaceConnection _$PlaceConnectionFromJson(Map<String, dynamic> json) {
  return PlaceConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : PlaceEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map(
            (e) => e == null ? null : Place.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$PlaceConnectionToJson(PlaceConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

PlaceEdge _$PlaceEdgeFromJson(Map<String, dynamic> json) {
  return PlaceEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Place.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$PlaceEdgeToJson(PlaceEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..address = json['address'] as String
    ..area = json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>)
    ..coordinates = json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
    ..lifeSpan = json['lifeSpan'] == null
        ? null
        : LifeSpan.fromJson(json['lifeSpan'] as Map<String, dynamic>)
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..events = json['events'] == null
        ? null
        : EventConnection.fromJson(json['events'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..mediaWikiImages = (json['mediaWikiImages'] as List)
        ?.map((e) => e == null
            ? null
            : MediaWikiImage.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'address': instance.address,
      'area': instance.area,
      'coordinates': instance.coordinates,
      'lifeSpan': instance.lifeSpan,
      'type': instance.type,
      'typeID': instance.typeID,
      'events': instance.events,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'tags': instance.tags,
      'mediaWikiImages': instance.mediaWikiImages
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return Coordinates()
    ..typename = json['__typename'] as String
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble();
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'latitude': instance.latitude,
      'longitude': instance.longitude
    };

ReleaseGroupConnection _$ReleaseGroupConnectionFromJson(
    Map<String, dynamic> json) {
  return ReleaseGroupConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : ReleaseGroupEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : ReleaseGroup.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$ReleaseGroupConnectionToJson(
        ReleaseGroupConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

ReleaseGroupEdge _$ReleaseGroupEdgeFromJson(Map<String, dynamic> json) {
  return ReleaseGroupEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : ReleaseGroup.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$ReleaseGroupEdgeToJson(ReleaseGroupEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

ReleaseGroup _$ReleaseGroupFromJson(Map<String, dynamic> json) {
  return ReleaseGroup()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredit = (json['artistCredit'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artistCredits = (json['artistCredits'] as List)
        ?.map((e) =>
            e == null ? null : ArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..firstReleaseDate = json['firstReleaseDate'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['firstReleaseDate'] as String)
    ..primaryType =
        _$enumDecodeNullable(_$ReleaseGroupTypeEnumMap, json['primaryType'])
    ..primaryTypeID = json['primaryTypeID'] as String
    ..secondaryTypes = (json['secondaryTypes'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ReleaseGroupTypeEnumMap, e))
        ?.toList()
    ..secondaryTypeIDs =
        (json['secondaryTypeIDs'] as List)?.map((e) => e as String)?.toList()
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>)
    ..coverArtArchive = json['coverArtArchive'] == null
        ? null
        : CoverArtArchiveRelease.fromJson(
            json['coverArtArchive'] as Map<String, dynamic>)
    ..fanArt = json['fanArt'] == null
        ? null
        : FanArtAlbum.fromJson(json['fanArt'] as Map<String, dynamic>)
    ..theAudioDB = json['theAudioDB'] == null
        ? null
        : TheAudioDBAlbum.fromJson(json['theAudioDB'] as Map<String, dynamic>)
    ..discogs = json['discogs'] == null
        ? null
        : DiscogsMaster.fromJson(json['discogs'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReleaseGroupToJson(ReleaseGroup instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'title': instance.title,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'artistCredit': instance.artistCredit,
      'artistCredits': instance.artistCredits,
      'firstReleaseDate': instance.firstReleaseDate == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.firstReleaseDate),
      'primaryType': _$ReleaseGroupTypeEnumMap[instance.primaryType],
      'primaryTypeID': instance.primaryTypeID,
      'secondaryTypes': instance.secondaryTypes
          ?.map((e) => _$ReleaseGroupTypeEnumMap[e])
          ?.toList(),
      'secondaryTypeIDs': instance.secondaryTypeIDs,
      'artists': instance.artists,
      'releases': instance.releases,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags,
      'coverArtArchive': instance.coverArtArchive,
      'fanArt': instance.fanArt,
      'theAudioDB': instance.theAudioDB,
      'discogs': instance.discogs
    };

const _$ReleaseGroupTypeEnumMap = <ReleaseGroupType, dynamic>{
  ReleaseGroupType.ALBUM: 'ALBUM',
  ReleaseGroupType.SINGLE: 'SINGLE',
  ReleaseGroupType.EP: 'EP',
  ReleaseGroupType.OTHER: 'OTHER',
  ReleaseGroupType.BROADCAST: 'BROADCAST',
  ReleaseGroupType.COMPILATION: 'COMPILATION',
  ReleaseGroupType.SOUNDTRACK: 'SOUNDTRACK',
  ReleaseGroupType.SPOKENWORD: 'SPOKENWORD',
  ReleaseGroupType.INTERVIEW: 'INTERVIEW',
  ReleaseGroupType.AUDIOBOOK: 'AUDIOBOOK',
  ReleaseGroupType.LIVE: 'LIVE',
  ReleaseGroupType.REMIX: 'REMIX',
  ReleaseGroupType.DJMIX: 'DJMIX',
  ReleaseGroupType.MIXTAPE: 'MIXTAPE',
  ReleaseGroupType.DEMO: 'DEMO',
  ReleaseGroupType.NAT: 'NAT'
};

CoverArtArchiveRelease _$CoverArtArchiveReleaseFromJson(
    Map<String, dynamic> json) {
  return CoverArtArchiveRelease()
    ..typename = json['__typename'] as String
    ..front = json['front'] as String
    ..back = json['back'] as String
    ..images = (json['images'] as List)
        ?.map((e) => e == null
            ? null
            : CoverArtArchiveImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..artwork = json['artwork'] as bool
    ..count = json['count'] as int
    ..release = json['release'] == null
        ? null
        : Release.fromJson(json['release'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CoverArtArchiveReleaseToJson(
        CoverArtArchiveRelease instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'front': instance.front,
      'back': instance.back,
      'images': instance.images,
      'artwork': instance.artwork,
      'count': instance.count,
      'release': instance.release
    };

CoverArtArchiveImage _$CoverArtArchiveImageFromJson(Map<String, dynamic> json) {
  return CoverArtArchiveImage()
    ..typename = json['__typename'] as String
    ..fileID = json['fileID'] as String
    ..image = json['image'] as String
    ..thumbnails = json['thumbnails'] == null
        ? null
        : CoverArtArchiveImageThumbnails.fromJson(
            json['thumbnails'] as Map<String, dynamic>)
    ..front = json['front'] as bool
    ..back = json['back'] as bool
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList()
    ..edit = json['edit'] as int
    ..approved = json['approved'] as bool
    ..comment = json['comment'] as String;
}

Map<String, dynamic> _$CoverArtArchiveImageToJson(
        CoverArtArchiveImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'fileID': instance.fileID,
      'image': instance.image,
      'thumbnails': instance.thumbnails,
      'front': instance.front,
      'back': instance.back,
      'types': instance.types,
      'edit': instance.edit,
      'approved': instance.approved,
      'comment': instance.comment
    };

CoverArtArchiveImageThumbnails _$CoverArtArchiveImageThumbnailsFromJson(
    Map<String, dynamic> json) {
  return CoverArtArchiveImageThumbnails()
    ..typename = json['__typename'] as String
    ..small = json['small'] as String
    ..large = json['large'] as String;
}

Map<String, dynamic> _$CoverArtArchiveImageThumbnailsToJson(
        CoverArtArchiveImageThumbnails instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'small': instance.small,
      'large': instance.large
    };

FanArtAlbum _$FanArtAlbumFromJson(Map<String, dynamic> json) {
  return FanArtAlbum()
    ..typename = json['__typename'] as String
    ..albumCovers = (json['albumCovers'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..discImages = (json['discImages'] as List)
        ?.map((e) => e == null
            ? null
            : FanArtDiscImage.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FanArtAlbumToJson(FanArtAlbum instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'albumCovers': instance.albumCovers,
      'discImages': instance.discImages
    };

FanArtImage _$FanArtImageFromJson(Map<String, dynamic> json) {
  return FanArtImage()
    ..typename = json['__typename'] as String
    ..imageID = json['imageID'] as String
    ..url = json['url'] as String
    ..likeCount = json['likeCount'] as int;
}

Map<String, dynamic> _$FanArtImageToJson(FanArtImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'imageID': instance.imageID,
      'url': instance.url,
      'likeCount': instance.likeCount
    };

FanArtDiscImage _$FanArtDiscImageFromJson(Map<String, dynamic> json) {
  return FanArtDiscImage()
    ..typename = json['__typename'] as String
    ..imageID = json['imageID'] as String
    ..url = json['url'] as String
    ..likeCount = json['likeCount'] as int
    ..discNumber = json['discNumber'] as int
    ..size = json['size'] as int;
}

Map<String, dynamic> _$FanArtDiscImageToJson(FanArtDiscImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'imageID': instance.imageID,
      'url': instance.url,
      'likeCount': instance.likeCount,
      'discNumber': instance.discNumber,
      'size': instance.size
    };

TheAudioDBAlbum _$TheAudioDBAlbumFromJson(Map<String, dynamic> json) {
  return TheAudioDBAlbum()
    ..typename = json['__typename'] as String
    ..albumID = json['albumID'] as String
    ..artistID = json['artistID'] as String
    ..description = json['description'] as String
    ..review = json['review'] as String
    ..salesCount = (json['salesCount'] as num)?.toDouble()
    ..score = (json['score'] as num)?.toDouble()
    ..scoreVotes = (json['scoreVotes'] as num)?.toDouble()
    ..discImage = json['discImage'] as String
    ..spineImage = json['spineImage'] as String
    ..frontImage = json['frontImage'] as String
    ..backImage = json['backImage'] as String
    ..genre = json['genre'] as String
    ..mood = json['mood'] as String
    ..style = json['style'] as String
    ..speed = json['speed'] as String
    ..theme = json['theme'] as String;
}

Map<String, dynamic> _$TheAudioDBAlbumToJson(TheAudioDBAlbum instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'albumID': instance.albumID,
      'artistID': instance.artistID,
      'description': instance.description,
      'review': instance.review,
      'salesCount': instance.salesCount,
      'score': instance.score,
      'scoreVotes': instance.scoreVotes,
      'discImage': instance.discImage,
      'spineImage': instance.spineImage,
      'frontImage': instance.frontImage,
      'backImage': instance.backImage,
      'genre': instance.genre,
      'mood': instance.mood,
      'style': instance.style,
      'speed': instance.speed,
      'theme': instance.theme
    };

DiscogsMaster _$DiscogsMasterFromJson(Map<String, dynamic> json) {
  return DiscogsMaster()
    ..typename = json['__typename'] as String
    ..masterID = json['masterID'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..artistCredits = (json['artistCredits'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..styles = (json['styles'] as List)?.map((e) => e as String)?.toList()
    ..forSaleCount = json['forSaleCount'] as int
    ..lowestPrice = (json['lowestPrice'] as num)?.toDouble()
    ..year = json['year'] as int
    ..mainRelease = json['mainRelease'] == null
        ? null
        : DiscogsRelease.fromJson(json['mainRelease'] as Map<String, dynamic>)
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..videos = (json['videos'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsVideo.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..dataQuality = json['dataQuality'] as String;
}

Map<String, dynamic> _$DiscogsMasterToJson(DiscogsMaster instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'masterID': instance.masterID,
      'title': instance.title,
      'url': instance.url,
      'artistCredits': instance.artistCredits,
      'genres': instance.genres,
      'styles': instance.styles,
      'forSaleCount': instance.forSaleCount,
      'lowestPrice': instance.lowestPrice,
      'year': instance.year,
      'mainRelease': instance.mainRelease,
      'images': instance.images,
      'videos': instance.videos,
      'dataQuality': instance.dataQuality
    };

DiscogsArtistCredit _$DiscogsArtistCreditFromJson(Map<String, dynamic> json) {
  return DiscogsArtistCredit()
    ..typename = json['__typename'] as String
    ..name = json['name'] as String
    ..nameVariation = json['nameVariation'] as String
    ..joinPhrase = json['joinPhrase'] as String
    ..roles = (json['roles'] as List)?.map((e) => e as String)?.toList()
    ..tracks = (json['tracks'] as List)?.map((e) => e as String)?.toList()
    ..artist = json['artist'] == null
        ? null
        : DiscogsArtist.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DiscogsArtistCreditToJson(
        DiscogsArtistCredit instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'name': instance.name,
      'nameVariation': instance.nameVariation,
      'joinPhrase': instance.joinPhrase,
      'roles': instance.roles,
      'tracks': instance.tracks,
      'artist': instance.artist
    };

DiscogsArtist _$DiscogsArtistFromJson(Map<String, dynamic> json) {
  return DiscogsArtist()
    ..typename = json['__typename'] as String
    ..artistID = json['artistID'] as String
    ..name = json['name'] as String
    ..nameVariations =
        (json['nameVariations'] as List)?.map((e) => e as String)?.toList()
    ..realName = json['realName'] as String
    ..aliases = (json['aliases'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsArtist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..url = json['url'] as String
    ..urls = (json['urls'] as List)?.map((e) => e as String)?.toList()
    ..profile = json['profile'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..members = (json['members'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsArtistMember.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..dataQuality = json['dataQuality'] as String;
}

Map<String, dynamic> _$DiscogsArtistToJson(DiscogsArtist instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'artistID': instance.artistID,
      'name': instance.name,
      'nameVariations': instance.nameVariations,
      'realName': instance.realName,
      'aliases': instance.aliases,
      'url': instance.url,
      'urls': instance.urls,
      'profile': instance.profile,
      'images': instance.images,
      'members': instance.members,
      'dataQuality': instance.dataQuality
    };

DiscogsImage _$DiscogsImageFromJson(Map<String, dynamic> json) {
  return DiscogsImage()
    ..typename = json['__typename'] as String
    ..url = json['url'] as String
    ..type = _$enumDecodeNullable(_$DiscogsImageTypeEnumMap, json['type'])
    ..width = json['width'] as int
    ..height = json['height'] as int
    ..thumbnail = json['thumbnail'] as String;
}

Map<String, dynamic> _$DiscogsImageToJson(DiscogsImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'url': instance.url,
      'type': _$DiscogsImageTypeEnumMap[instance.type],
      'width': instance.width,
      'height': instance.height,
      'thumbnail': instance.thumbnail
    };

const _$DiscogsImageTypeEnumMap = <DiscogsImageType, dynamic>{
  DiscogsImageType.PRIMARY: 'PRIMARY',
  DiscogsImageType.SECONDARY: 'SECONDARY'
};

DiscogsArtistMember _$DiscogsArtistMemberFromJson(Map<String, dynamic> json) {
  return DiscogsArtistMember()
    ..typename = json['__typename'] as String
    ..active = json['active'] as bool
    ..name = json['name'] as String
    ..artist = json['artist'] == null
        ? null
        : DiscogsArtist.fromJson(json['artist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DiscogsArtistMemberToJson(
        DiscogsArtistMember instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'active': instance.active,
      'name': instance.name,
      'artist': instance.artist
    };

DiscogsRelease _$DiscogsReleaseFromJson(Map<String, dynamic> json) {
  return DiscogsRelease()
    ..typename = json['__typename'] as String
    ..releaseID = json['releaseID'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..artistCredits = (json['artistCredits'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..extraArtistCredits = (json['extraArtistCredits'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsArtistCredit.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..styles = (json['styles'] as List)?.map((e) => e as String)?.toList()
    ..forSaleCount = json['forSaleCount'] as int
    ..lowestPrice = (json['lowestPrice'] as num)?.toDouble()
    ..year = json['year'] as int
    ..notes = json['notes'] as String
    ..country = json['country'] as String
    ..master = json['master'] == null
        ? null
        : DiscogsMaster.fromJson(json['master'] as Map<String, dynamic>)
    ..thumbnail = json['thumbnail'] as String
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..videos = (json['videos'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsVideo.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..community = json['community'] == null
        ? null
        : DiscogsCommunity.fromJson(json['community'] as Map<String, dynamic>)
    ..dataQuality = json['dataQuality'] as String;
}

Map<String, dynamic> _$DiscogsReleaseToJson(DiscogsRelease instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'releaseID': instance.releaseID,
      'title': instance.title,
      'url': instance.url,
      'artistCredits': instance.artistCredits,
      'extraArtistCredits': instance.extraArtistCredits,
      'genres': instance.genres,
      'styles': instance.styles,
      'forSaleCount': instance.forSaleCount,
      'lowestPrice': instance.lowestPrice,
      'year': instance.year,
      'notes': instance.notes,
      'country': instance.country,
      'master': instance.master,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
      'videos': instance.videos,
      'community': instance.community,
      'dataQuality': instance.dataQuality
    };

DiscogsVideo _$DiscogsVideoFromJson(Map<String, dynamic> json) {
  return DiscogsVideo()
    ..typename = json['__typename'] as String
    ..url = json['url'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int)
    ..embed = json['embed'] as bool;
}

Map<String, dynamic> _$DiscogsVideoToJson(DiscogsVideo instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration?.inMicroseconds,
      'embed': instance.embed
    };

DiscogsCommunity _$DiscogsCommunityFromJson(Map<String, dynamic> json) {
  return DiscogsCommunity()
    ..typename = json['__typename'] as String
    ..status = json['status'] as String
    ..rating = json['rating'] == null
        ? null
        : DiscogsRating.fromJson(json['rating'] as Map<String, dynamic>)
    ..haveCount = json['haveCount'] as int
    ..wantCount = json['wantCount'] as int
    ..contributors = (json['contributors'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsUser.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..submitter = json['submitter'] == null
        ? null
        : DiscogsUser.fromJson(json['submitter'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DiscogsCommunityToJson(DiscogsCommunity instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'status': instance.status,
      'rating': instance.rating,
      'haveCount': instance.haveCount,
      'wantCount': instance.wantCount,
      'contributors': instance.contributors,
      'submitter': instance.submitter
    };

DiscogsRating _$DiscogsRatingFromJson(Map<String, dynamic> json) {
  return DiscogsRating()
    ..typename = json['__typename'] as String
    ..voteCount = json['voteCount'] as int
    ..value = (json['value'] as num)?.toDouble();
}

Map<String, dynamic> _$DiscogsRatingToJson(DiscogsRating instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'voteCount': instance.voteCount,
      'value': instance.value
    };

DiscogsUser _$DiscogsUserFromJson(Map<String, dynamic> json) {
  return DiscogsUser()
    ..typename = json['__typename'] as String
    ..username = json['username'] as String;
}

Map<String, dynamic> _$DiscogsUserToJson(DiscogsUser instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'username': instance.username
    };

SeriesConnection _$SeriesConnectionFromJson(Map<String, dynamic> json) {
  return SeriesConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : SeriesEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : Series.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$SeriesConnectionToJson(SeriesConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

SeriesEdge _$SeriesEdgeFromJson(Map<String, dynamic> json) {
  return SeriesEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Series.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$SeriesEdgeToJson(SeriesEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return Series()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..disambiguation = json['disambiguation'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'name': instance.name,
      'disambiguation': instance.disambiguation,
      'type': instance.type,
      'typeID': instance.typeID,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'tags': instance.tags
    };

WorkConnection _$WorkConnectionFromJson(Map<String, dynamic> json) {
  return WorkConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) =>
            e == null ? null : WorkEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map(
            (e) => e == null ? null : Work.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$WorkConnectionToJson(WorkConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

WorkEdge _$WorkEdgeFromJson(Map<String, dynamic> json) {
  return WorkEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : Work.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..score = json['score'] as int;
}

Map<String, dynamic> _$WorkEdgeToJson(WorkEdge instance) => <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'score': instance.score
    };

Work _$WorkFromJson(Map<String, dynamic> json) {
  return Work()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..disambiguation = json['disambiguation'] as String
    ..aliases = (json['aliases'] as List)
        ?.map(
            (e) => e == null ? null : Alias.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..iswcs = (json['iswcs'] as List)?.map((e) => e as String)?.toList()
    ..language = json['language'] as String
    ..type = json['type'] as String
    ..typeID = json['typeID'] as String
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..rating = json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>)
    ..tags = json['tags'] == null
        ? null
        : TagConnection.fromJson(json['tags'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'title': instance.title,
      'disambiguation': instance.disambiguation,
      'aliases': instance.aliases,
      'iswcs': instance.iswcs,
      'language': instance.language,
      'type': instance.type,
      'typeID': instance.typeID,
      'artists': instance.artists,
      'relationships': instance.relationships,
      'collections': instance.collections,
      'rating': instance.rating,
      'tags': instance.tags
    };

FanArtLabel _$FanArtLabelFromJson(Map<String, dynamic> json) {
  return FanArtLabel()
    ..typename = json['__typename'] as String
    ..logos = (json['logos'] as List)
        ?.map((e) => e == null
            ? null
            : FanArtLabelImage.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FanArtLabelToJson(FanArtLabel instance) =>
    <String, dynamic>{'__typename': instance.typename, 'logos': instance.logos};

FanArtLabelImage _$FanArtLabelImageFromJson(Map<String, dynamic> json) {
  return FanArtLabelImage()
    ..typename = json['__typename'] as String
    ..imageID = json['imageID'] as String
    ..url = json['url'] as String
    ..likeCount = json['likeCount'] as int
    ..color = json['color'] as String;
}

Map<String, dynamic> _$FanArtLabelImageToJson(FanArtLabelImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'imageID': instance.imageID,
      'url': instance.url,
      'likeCount': instance.likeCount,
      'color': instance.color
    };

DiscogsLabel _$DiscogsLabelFromJson(Map<String, dynamic> json) {
  return DiscogsLabel()
    ..typename = json['__typename'] as String
    ..labelID = json['labelID'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String
    ..profile = json['profile'] as String
    ..contactInfo = json['contactInfo'] as String
    ..parentLabel = json['parentLabel'] == null
        ? null
        : DiscogsLabel.fromJson(json['parentLabel'] as Map<String, dynamic>)
    ..subLabels = (json['subLabels'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsLabel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : DiscogsImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..dataQuality = json['dataQuality'] as String;
}

Map<String, dynamic> _$DiscogsLabelToJson(DiscogsLabel instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'labelID': instance.labelID,
      'name': instance.name,
      'url': instance.url,
      'profile': instance.profile,
      'contactInfo': instance.contactInfo,
      'parentLabel': instance.parentLabel,
      'subLabels': instance.subLabels,
      'images': instance.images,
      'dataQuality': instance.dataQuality
    };

LastFMAlbum _$LastFMAlbumFromJson(Map<String, dynamic> json) {
  return LastFMAlbum()
    ..typename = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..image = json['image'] as String
    ..listenerCount = (json['listenerCount'] as num)?.toDouble()
    ..playCount = (json['playCount'] as num)?.toDouble()
    ..description = json['description'] == null
        ? null
        : LastFMWikiContent.fromJson(
            json['description'] as Map<String, dynamic>)
    ..artist = json['artist'] == null
        ? null
        : LastFMArtist.fromJson(json['artist'] as Map<String, dynamic>)
    ..topTags = json['topTags'] == null
        ? null
        : LastFMTagConnection.fromJson(json['topTags'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMAlbumToJson(LastFMAlbum instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'mbid': instance.mbid,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
      'listenerCount': instance.listenerCount,
      'playCount': instance.playCount,
      'description': instance.description,
      'artist': instance.artist,
      'topTags': instance.topTags
    };

LastFMWikiContent _$LastFMWikiContentFromJson(Map<String, dynamic> json) {
  return LastFMWikiContent()
    ..typename = json['__typename'] as String
    ..summaryHTML = json['summaryHTML'] as String
    ..contentHTML = json['contentHTML'] as String
    ..publishDate = json['publishDate'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['publishDate'] as String)
    ..publishTime = json['publishTime'] == null
        ? null
        : fromGraphQLTimeToDartDateTime(json['publishTime'] as String)
    ..url = json['url'] as String;
}

Map<String, dynamic> _$LastFMWikiContentToJson(LastFMWikiContent instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'summaryHTML': instance.summaryHTML,
      'contentHTML': instance.contentHTML,
      'publishDate': instance.publishDate == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.publishDate),
      'publishTime': instance.publishTime == null
          ? null
          : fromDartDateTimeToGraphQLTime(instance.publishTime),
      'url': instance.url
    };

LastFMArtist _$LastFMArtistFromJson(Map<String, dynamic> json) {
  return LastFMArtist()
    ..typename = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String
    ..image = json['image'] as String
    ..listenerCount = (json['listenerCount'] as num)?.toDouble()
    ..playCount = (json['playCount'] as num)?.toDouble()
    ..similarArtists = json['similarArtists'] == null
        ? null
        : LastFMArtistConnection.fromJson(
            json['similarArtists'] as Map<String, dynamic>)
    ..topAlbums = json['topAlbums'] == null
        ? null
        : LastFMAlbumConnection.fromJson(
            json['topAlbums'] as Map<String, dynamic>)
    ..topTags = json['topTags'] == null
        ? null
        : LastFMTagConnection.fromJson(json['topTags'] as Map<String, dynamic>)
    ..topTracks = json['topTracks'] == null
        ? null
        : LastFMTrackConnection.fromJson(
            json['topTracks'] as Map<String, dynamic>)
    ..biography = json['biography'] == null
        ? null
        : LastFMWikiContent.fromJson(json['biography'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMArtistToJson(LastFMArtist instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'mbid': instance.mbid,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'listenerCount': instance.listenerCount,
      'playCount': instance.playCount,
      'similarArtists': instance.similarArtists,
      'topAlbums': instance.topAlbums,
      'topTags': instance.topTags,
      'topTracks': instance.topTracks,
      'biography': instance.biography
    };

LastFMArtistConnection _$LastFMArtistConnectionFromJson(
    Map<String, dynamic> json) {
  return LastFMArtistConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : LastFMArtistEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : LastFMArtist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$LastFMArtistConnectionToJson(
        LastFMArtistConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

LastFMArtistEdge _$LastFMArtistEdgeFromJson(Map<String, dynamic> json) {
  return LastFMArtistEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : LastFMArtist.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..matchScore = (json['matchScore'] as num)?.toDouble();
}

Map<String, dynamic> _$LastFMArtistEdgeToJson(LastFMArtistEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'matchScore': instance.matchScore
    };

LastFMAlbumConnection _$LastFMAlbumConnectionFromJson(
    Map<String, dynamic> json) {
  return LastFMAlbumConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : LastFMAlbumEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : LastFMAlbum.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$LastFMAlbumConnectionToJson(
        LastFMAlbumConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

LastFMAlbumEdge _$LastFMAlbumEdgeFromJson(Map<String, dynamic> json) {
  return LastFMAlbumEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : LastFMAlbum.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String;
}

Map<String, dynamic> _$LastFMAlbumEdgeToJson(LastFMAlbumEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor
    };

LastFMTagConnection _$LastFMTagConnectionFromJson(Map<String, dynamic> json) {
  return LastFMTagConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : LastFMTagEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : LastFMTag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$LastFMTagConnectionToJson(
        LastFMTagConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

LastFMTagEdge _$LastFMTagEdgeFromJson(Map<String, dynamic> json) {
  return LastFMTagEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : LastFMTag.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..tagCount = json['tagCount'] as int;
}

Map<String, dynamic> _$LastFMTagEdgeToJson(LastFMTagEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'tagCount': instance.tagCount
    };

LastFMTag _$LastFMTagFromJson(Map<String, dynamic> json) {
  return LastFMTag()
    ..typename = json['__typename'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String;
}

Map<String, dynamic> _$LastFMTagToJson(LastFMTag instance) => <String, dynamic>{
      '__typename': instance.typename,
      'name': instance.name,
      'url': instance.url
    };

LastFMTrackConnection _$LastFMTrackConnectionFromJson(
    Map<String, dynamic> json) {
  return LastFMTrackConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : LastFMTrackEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) =>
            e == null ? null : LastFMTrack.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$LastFMTrackConnectionToJson(
        LastFMTrackConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

LastFMTrackEdge _$LastFMTrackEdgeFromJson(Map<String, dynamic> json) {
  return LastFMTrackEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : LastFMTrack.fromJson(json['node'] as Map<String, dynamic>)
    ..cursor = json['cursor'] as String
    ..matchScore = (json['matchScore'] as num)?.toDouble();
}

Map<String, dynamic> _$LastFMTrackEdgeToJson(LastFMTrackEdge instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'node': instance.node,
      'cursor': instance.cursor,
      'matchScore': instance.matchScore
    };

LastFMTrack _$LastFMTrackFromJson(Map<String, dynamic> json) {
  return LastFMTrack()
    ..typename = json['__typename'] as String
    ..mbid = json['mbid'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int)
    ..listenerCount = (json['listenerCount'] as num)?.toDouble()
    ..playCount = (json['playCount'] as num)?.toDouble()
    ..description = json['description'] == null
        ? null
        : LastFMWikiContent.fromJson(
            json['description'] as Map<String, dynamic>)
    ..artist = json['artist'] == null
        ? null
        : LastFMArtist.fromJson(json['artist'] as Map<String, dynamic>)
    ..album = json['album'] == null
        ? null
        : LastFMAlbum.fromJson(json['album'] as Map<String, dynamic>)
    ..similarTracks = json['similarTracks'] == null
        ? null
        : LastFMTrackConnection.fromJson(
            json['similarTracks'] as Map<String, dynamic>)
    ..topTags = json['topTags'] == null
        ? null
        : LastFMTagConnection.fromJson(json['topTags'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMTrackToJson(LastFMTrack instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'mbid': instance.mbid,
      'title': instance.title,
      'url': instance.url,
      'duration': instance.duration?.inMicroseconds,
      'listenerCount': instance.listenerCount,
      'playCount': instance.playCount,
      'description': instance.description,
      'artist': instance.artist,
      'album': instance.album,
      'similarTracks': instance.similarTracks,
      'topTags': instance.topTags
    };

SpotifyAlbum _$SpotifyAlbumFromJson(Map<String, dynamic> json) {
  return SpotifyAlbum()
    ..typename = json['__typename'] as String
    ..albumID = json['albumID'] as String
    ..uri = json['uri'] as String
    ..href = json['href'] as String
    ..title = json['title'] as String
    ..albumType =
        _$enumDecodeNullable(_$ReleaseGroupTypeEnumMap, json['albumType'])
    ..artists = (json['artists'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyArtist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['availableMarkets'] as List)?.map((e) => e as String)?.toList()
    ..copyrights = (json['copyrights'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyCopyright.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..externalIDs = (json['externalIDs'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyExternalID.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..externalURLs = (json['externalURLs'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyExternalURL.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : SpotifyImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..label = json['label'] as String
    ..popularity = json['popularity'] as int
    ..releaseDate = json['releaseDate'] == null
        ? null
        : fromGraphQLDateToDartDateTime(json['releaseDate'] as String);
}

Map<String, dynamic> _$SpotifyAlbumToJson(SpotifyAlbum instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'albumID': instance.albumID,
      'uri': instance.uri,
      'href': instance.href,
      'title': instance.title,
      'albumType': _$ReleaseGroupTypeEnumMap[instance.albumType],
      'artists': instance.artists,
      'availableMarkets': instance.availableMarkets,
      'copyrights': instance.copyrights,
      'externalIDs': instance.externalIDs,
      'externalURLs': instance.externalURLs,
      'genres': instance.genres,
      'images': instance.images,
      'label': instance.label,
      'popularity': instance.popularity,
      'releaseDate': instance.releaseDate == null
          ? null
          : fromDartDateTimeToGraphQLDate(instance.releaseDate)
    };

SpotifyArtist _$SpotifyArtistFromJson(Map<String, dynamic> json) {
  return SpotifyArtist()
    ..typename = json['__typename'] as String
    ..artistID = json['artistID'] as String
    ..uri = json['uri'] as String
    ..href = json['href'] as String
    ..name = json['name'] as String
    ..externalURLs = (json['externalURLs'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyExternalURL.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..genres = (json['genres'] as List)?.map((e) => e as String)?.toList()
    ..popularity = json['popularity'] as int
    ..images = (json['images'] as List)
        ?.map((e) =>
            e == null ? null : SpotifyImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..topTracks = (json['topTracks'] as List)
        ?.map((e) =>
            e == null ? null : SpotifyTrack.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..relatedArtists = (json['relatedArtists'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyArtist.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SpotifyArtistToJson(SpotifyArtist instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'artistID': instance.artistID,
      'uri': instance.uri,
      'href': instance.href,
      'name': instance.name,
      'externalURLs': instance.externalURLs,
      'genres': instance.genres,
      'popularity': instance.popularity,
      'images': instance.images,
      'topTracks': instance.topTracks,
      'relatedArtists': instance.relatedArtists
    };

SpotifyExternalURL _$SpotifyExternalURLFromJson(Map<String, dynamic> json) {
  return SpotifyExternalURL()
    ..typename = json['__typename'] as String
    ..type = json['type'] as String
    ..url = json['url'] as String;
}

Map<String, dynamic> _$SpotifyExternalURLToJson(SpotifyExternalURL instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'type': instance.type,
      'url': instance.url
    };

SpotifyImage _$SpotifyImageFromJson(Map<String, dynamic> json) {
  return SpotifyImage()
    ..typename = json['__typename'] as String
    ..url = json['url'] as String
    ..width = json['width'] as int
    ..height = json['height'] as int;
}

Map<String, dynamic> _$SpotifyImageToJson(SpotifyImage instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height
    };

SpotifyTrack _$SpotifyTrackFromJson(Map<String, dynamic> json) {
  return SpotifyTrack()
    ..typename = json['__typename'] as String
    ..trackID = json['trackID'] as String
    ..uri = json['uri'] as String
    ..href = json['href'] as String
    ..title = json['title'] as String
    ..audioFeatures = json['audioFeatures'] == null
        ? null
        : SpotifyAudioFeatures.fromJson(
            json['audioFeatures'] as Map<String, dynamic>)
    ..album = json['album'] == null
        ? null
        : SpotifyAlbum.fromJson(json['album'] as Map<String, dynamic>)
    ..artists = (json['artists'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyArtist.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..availableMarkets =
        (json['availableMarkets'] as List)?.map((e) => e as String)?.toList()
    ..discNumber = json['discNumber'] as int
    ..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int)
    ..explicit = json['explicit'] as bool
    ..externalIDs = (json['externalIDs'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyExternalID.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..externalURLs = (json['externalURLs'] as List)
        ?.map((e) => e == null
            ? null
            : SpotifyExternalURL.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..popularity = json['popularity'] as int
    ..previewURL = json['previewURL'] as String
    ..trackNumber = json['trackNumber'] as int
    ..musicBrainz = json['musicBrainz'] == null
        ? null
        : Recording.fromJson(json['musicBrainz'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SpotifyTrackToJson(SpotifyTrack instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'trackID': instance.trackID,
      'uri': instance.uri,
      'href': instance.href,
      'title': instance.title,
      'audioFeatures': instance.audioFeatures,
      'album': instance.album,
      'artists': instance.artists,
      'availableMarkets': instance.availableMarkets,
      'discNumber': instance.discNumber,
      'duration': instance.duration?.inMicroseconds,
      'explicit': instance.explicit,
      'externalIDs': instance.externalIDs,
      'externalURLs': instance.externalURLs,
      'popularity': instance.popularity,
      'previewURL': instance.previewURL,
      'trackNumber': instance.trackNumber,
      'musicBrainz': instance.musicBrainz
    };

SpotifyAudioFeatures _$SpotifyAudioFeaturesFromJson(Map<String, dynamic> json) {
  return SpotifyAudioFeatures()
    ..typename = json['__typename'] as String
    ..acousticness = (json['acousticness'] as num)?.toDouble()
    ..danceability = (json['danceability'] as num)?.toDouble()
    ..duration = json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int)
    ..energy = (json['energy'] as num)?.toDouble()
    ..instrumentalness = (json['instrumentalness'] as num)?.toDouble()
    ..key = json['key'] as int
    ..keyName = json['keyName'] as String
    ..liveness = (json['liveness'] as num)?.toDouble()
    ..loudness = (json['loudness'] as num)?.toDouble()
    ..mode = _$enumDecodeNullable(_$SpotifyTrackModeEnumMap, json['mode'])
    ..speechiness = (json['speechiness'] as num)?.toDouble()
    ..tempo = (json['tempo'] as num)?.toDouble()
    ..timeSignature = (json['timeSignature'] as num)?.toDouble()
    ..valence = (json['valence'] as num)?.toDouble();
}

Map<String, dynamic> _$SpotifyAudioFeaturesToJson(
        SpotifyAudioFeatures instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'acousticness': instance.acousticness,
      'danceability': instance.danceability,
      'duration': instance.duration?.inMicroseconds,
      'energy': instance.energy,
      'instrumentalness': instance.instrumentalness,
      'key': instance.key,
      'keyName': instance.keyName,
      'liveness': instance.liveness,
      'loudness': instance.loudness,
      'mode': _$SpotifyTrackModeEnumMap[instance.mode],
      'speechiness': instance.speechiness,
      'tempo': instance.tempo,
      'timeSignature': instance.timeSignature,
      'valence': instance.valence
    };

const _$SpotifyTrackModeEnumMap = <SpotifyTrackMode, dynamic>{
  SpotifyTrackMode.MAJOR: 'MAJOR',
  SpotifyTrackMode.MINOR: 'MINOR'
};

SpotifyExternalID _$SpotifyExternalIDFromJson(Map<String, dynamic> json) {
  return SpotifyExternalID()
    ..typename = json['__typename'] as String
    ..type = json['type'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$SpotifyExternalIDToJson(SpotifyExternalID instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'type': instance.type,
      'id': instance.id
    };

SpotifyCopyright _$SpotifyCopyrightFromJson(Map<String, dynamic> json) {
  return SpotifyCopyright()
    ..typename = json['__typename'] as String
    ..text = json['text'] as String
    ..type = _$enumDecodeNullable(_$SpotifyCopyrightTypeEnumMap, json['type']);
}

Map<String, dynamic> _$SpotifyCopyrightToJson(SpotifyCopyright instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'text': instance.text,
      'type': _$SpotifyCopyrightTypeEnumMap[instance.type]
    };

const _$SpotifyCopyrightTypeEnumMap = <SpotifyCopyrightType, dynamic>{
  SpotifyCopyrightType.COPYRIGHT: 'COPYRIGHT',
  SpotifyCopyrightType.PERFORMANCE: 'PERFORMANCE'
};

TheAudioDBTrack _$TheAudioDBTrackFromJson(Map<String, dynamic> json) {
  return TheAudioDBTrack()
    ..typename = json['__typename'] as String
    ..trackID = json['trackID'] as String
    ..albumID = json['albumID'] as String
    ..artistID = json['artistID'] as String
    ..description = json['description'] as String
    ..thumbnail = json['thumbnail'] as String
    ..score = (json['score'] as num)?.toDouble()
    ..scoreVotes = (json['scoreVotes'] as num)?.toDouble()
    ..trackNumber = json['trackNumber'] as int
    ..musicVideo = json['musicVideo'] == null
        ? null
        : TheAudioDBMusicVideo.fromJson(
            json['musicVideo'] as Map<String, dynamic>)
    ..genre = json['genre'] as String
    ..mood = json['mood'] as String
    ..style = json['style'] as String
    ..theme = json['theme'] as String;
}

Map<String, dynamic> _$TheAudioDBTrackToJson(TheAudioDBTrack instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'trackID': instance.trackID,
      'albumID': instance.albumID,
      'artistID': instance.artistID,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'score': instance.score,
      'scoreVotes': instance.scoreVotes,
      'trackNumber': instance.trackNumber,
      'musicVideo': instance.musicVideo,
      'genre': instance.genre,
      'mood': instance.mood,
      'style': instance.style,
      'theme': instance.theme
    };

TheAudioDBMusicVideo _$TheAudioDBMusicVideoFromJson(Map<String, dynamic> json) {
  return TheAudioDBMusicVideo()
    ..typename = json['__typename'] as String
    ..url = json['url'] as String
    ..companyName = json['companyName'] as String
    ..directorName = json['directorName'] as String
    ..screenshots =
        (json['screenshots'] as List)?.map((e) => e as String)?.toList()
    ..viewCount = (json['viewCount'] as num)?.toDouble()
    ..likeCount = (json['likeCount'] as num)?.toDouble()
    ..dislikeCount = (json['dislikeCount'] as num)?.toDouble()
    ..commentCount = (json['commentCount'] as num)?.toDouble();
}

Map<String, dynamic> _$TheAudioDBMusicVideoToJson(
        TheAudioDBMusicVideo instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'url': instance.url,
      'companyName': instance.companyName,
      'directorName': instance.directorName,
      'screenshots': instance.screenshots,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'dislikeCount': instance.dislikeCount,
      'commentCount': instance.commentCount
    };

FanArtArtist _$FanArtArtistFromJson(Map<String, dynamic> json) {
  return FanArtArtist()
    ..typename = json['__typename'] as String
    ..backgrounds = (json['backgrounds'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..banners = (json['banners'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..logos = (json['logos'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..logosHD = (json['logosHD'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..thumbnails = (json['thumbnails'] as List)
        ?.map((e) =>
            e == null ? null : FanArtImage.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$FanArtArtistToJson(FanArtArtist instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'backgrounds': instance.backgrounds,
      'banners': instance.banners,
      'logos': instance.logos,
      'logosHD': instance.logosHD,
      'thumbnails': instance.thumbnails
    };

TheAudioDBArtist _$TheAudioDBArtistFromJson(Map<String, dynamic> json) {
  return TheAudioDBArtist()
    ..typename = json['__typename'] as String
    ..artistID = json['artistID'] as String
    ..biography = json['biography'] as String
    ..memberCount = json['memberCount'] as int
    ..banner = json['banner'] as String
    ..fanArt = (json['fanArt'] as List)?.map((e) => e as String)?.toList()
    ..logo = json['logo'] as String
    ..thumbnail = json['thumbnail'] as String
    ..genre = json['genre'] as String
    ..mood = json['mood'] as String
    ..style = json['style'] as String;
}

Map<String, dynamic> _$TheAudioDBArtistToJson(TheAudioDBArtist instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'artistID': instance.artistID,
      'biography': instance.biography,
      'memberCount': instance.memberCount,
      'banner': instance.banner,
      'fanArt': instance.fanArt,
      'logo': instance.logo,
      'thumbnail': instance.thumbnail,
      'genre': instance.genre,
      'mood': instance.mood,
      'style': instance.style
    };

LastFMCountry _$LastFMCountryFromJson(Map<String, dynamic> json) {
  return LastFMCountry()
    ..typename = json['__typename'] as String
    ..topArtists = json['topArtists'] == null
        ? null
        : LastFMArtistConnection.fromJson(
            json['topArtists'] as Map<String, dynamic>)
    ..topTracks = json['topTracks'] == null
        ? null
        : LastFMTrackConnection.fromJson(
            json['topTracks'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMCountryToJson(LastFMCountry instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'topArtists': instance.topArtists,
      'topTracks': instance.topTracks
    };

URL _$URLFromJson(Map<String, dynamic> json) {
  return URL()
    ..typename = json['__typename'] as String
    ..id = json['id'] as String
    ..mbid = json['mbid'] as String
    ..resource = json['resource'] as String
    ..relationships = json['relationships'] == null
        ? null
        : Relationships.fromJson(json['relationships'] as Map<String, dynamic>);
}

Map<String, dynamic> _$URLToJson(URL instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'mbid': instance.mbid,
      'resource': instance.resource,
      'relationships': instance.relationships
    };

BrowseQuery _$BrowseQueryFromJson(Map<String, dynamic> json) {
  return BrowseQuery()
    ..typename = json['__typename'] as String
    ..areas = json['areas'] == null
        ? null
        : AreaConnection.fromJson(json['areas'] as Map<String, dynamic>)
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..collections = json['collections'] == null
        ? null
        : CollectionConnection.fromJson(
            json['collections'] as Map<String, dynamic>)
    ..events = json['events'] == null
        ? null
        : EventConnection.fromJson(json['events'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : LabelConnection.fromJson(json['labels'] as Map<String, dynamic>)
    ..places = json['places'] == null
        ? null
        : PlaceConnection.fromJson(json['places'] as Map<String, dynamic>)
    ..recordings = json['recordings'] == null
        ? null
        : RecordingConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : ReleaseGroupConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..works = json['works'] == null
        ? null
        : WorkConnection.fromJson(json['works'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BrowseQueryToJson(BrowseQuery instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'areas': instance.areas,
      'artists': instance.artists,
      'collections': instance.collections,
      'events': instance.events,
      'labels': instance.labels,
      'places': instance.places,
      'recordings': instance.recordings,
      'releases': instance.releases,
      'releaseGroups': instance.releaseGroups,
      'works': instance.works
    };

SearchQuery _$SearchQueryFromJson(Map<String, dynamic> json) {
  return SearchQuery()
    ..typename = json['__typename'] as String
    ..areas = json['areas'] == null
        ? null
        : AreaConnection.fromJson(json['areas'] as Map<String, dynamic>)
    ..artists = json['artists'] == null
        ? null
        : ArtistConnection.fromJson(json['artists'] as Map<String, dynamic>)
    ..events = json['events'] == null
        ? null
        : EventConnection.fromJson(json['events'] as Map<String, dynamic>)
    ..instruments = json['instruments'] == null
        ? null
        : InstrumentConnection.fromJson(
            json['instruments'] as Map<String, dynamic>)
    ..labels = json['labels'] == null
        ? null
        : LabelConnection.fromJson(json['labels'] as Map<String, dynamic>)
    ..places = json['places'] == null
        ? null
        : PlaceConnection.fromJson(json['places'] as Map<String, dynamic>)
    ..recordings = json['recordings'] == null
        ? null
        : RecordingConnection.fromJson(
            json['recordings'] as Map<String, dynamic>)
    ..releases = json['releases'] == null
        ? null
        : ReleaseConnection.fromJson(json['releases'] as Map<String, dynamic>)
    ..releaseGroups = json['releaseGroups'] == null
        ? null
        : ReleaseGroupConnection.fromJson(
            json['releaseGroups'] as Map<String, dynamic>)
    ..series = json['series'] == null
        ? null
        : SeriesConnection.fromJson(json['series'] as Map<String, dynamic>)
    ..works = json['works'] == null
        ? null
        : WorkConnection.fromJson(json['works'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SearchQueryToJson(SearchQuery instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'areas': instance.areas,
      'artists': instance.artists,
      'events': instance.events,
      'instruments': instance.instruments,
      'labels': instance.labels,
      'places': instance.places,
      'recordings': instance.recordings,
      'releases': instance.releases,
      'releaseGroups': instance.releaseGroups,
      'series': instance.series,
      'works': instance.works
    };

LastFMQuery _$LastFMQueryFromJson(Map<String, dynamic> json) {
  return LastFMQuery()
    ..typename = json['__typename'] as String
    ..chart = json['chart'] == null
        ? null
        : LastFMChartQuery.fromJson(json['chart'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMQueryToJson(LastFMQuery instance) =>
    <String, dynamic>{'__typename': instance.typename, 'chart': instance.chart};

LastFMChartQuery _$LastFMChartQueryFromJson(Map<String, dynamic> json) {
  return LastFMChartQuery()
    ..typename = json['__typename'] as String
    ..topArtists = json['topArtists'] == null
        ? null
        : LastFMArtistConnection.fromJson(
            json['topArtists'] as Map<String, dynamic>)
    ..topTags = json['topTags'] == null
        ? null
        : LastFMTagConnection.fromJson(json['topTags'] as Map<String, dynamic>)
    ..topTracks = json['topTracks'] == null
        ? null
        : LastFMTrackConnection.fromJson(
            json['topTracks'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LastFMChartQueryToJson(LastFMChartQuery instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'topArtists': instance.topArtists,
      'topTags': instance.topTags,
      'topTracks': instance.topTracks
    };

SpotifyQuery _$SpotifyQueryFromJson(Map<String, dynamic> json) {
  return SpotifyQuery()
    ..typename = json['__typename'] as String
    ..recommendations = json['recommendations'] == null
        ? null
        : SpotifyRecommendations.fromJson(
            json['recommendations'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SpotifyQueryToJson(SpotifyQuery instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'recommendations': instance.recommendations
    };

SpotifyRecommendations _$SpotifyRecommendationsFromJson(
    Map<String, dynamic> json) {
  return SpotifyRecommendations()
    ..typename = json['__typename'] as String
    ..tracks = (json['tracks'] as List)
        ?.map((e) =>
            e == null ? null : SpotifyTrack.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SpotifyRecommendationsToJson(
        SpotifyRecommendations instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'tracks': instance.tracks
    };

DiscogsReleaseConnection _$DiscogsReleaseConnectionFromJson(
    Map<String, dynamic> json) {
  return DiscogsReleaseConnection()
    ..typename = json['__typename'] as String
    ..pageInfo = json['pageInfo'] == null
        ? null
        : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
    ..edges = (json['edges'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsReleaseEdge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..nodes = (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : DiscogsRelease.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$DiscogsReleaseConnectionToJson(
        DiscogsReleaseConnection instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'pageInfo': instance.pageInfo,
      'edges': instance.edges,
      'nodes': instance.nodes,
      'totalCount': instance.totalCount
    };

DiscogsReleaseEdge _$DiscogsReleaseEdgeFromJson(Map<String, dynamic> json) {
  return DiscogsReleaseEdge()
    ..typename = json['__typename'] as String
    ..node = json['node'] == null
        ? null
        : DiscogsRelease.fromJson(json['node'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DiscogsReleaseEdgeToJson(DiscogsReleaseEdge instance) =>
    <String, dynamic>{'__typename': instance.typename, 'node': instance.node};
