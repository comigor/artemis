// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:graphbrainz_example/coercers.dart';

part 'graphbrainz.api.g.dart';

@JsonSerializable()
class Query {
  LookupQuery lookup;
  BrowseQuery browse;
  SearchQuery search;
  Node node;
  LastFMQuery lastFM;
  SpotifyQuery spotify;

  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}

@JsonSerializable()
class LookupQuery {
  Area area;
  Artist artist;
  Collection collection;
  Disc disc;
  Event event;
  Instrument instrument;
  Label label;
  Place place;
  Recording recording;
  Release release;
  ReleaseGroup releaseGroup;
  Series series;
  URL url;
  Work work;

  LookupQuery();

  factory LookupQuery.fromJson(Map<String, dynamic> json) =>
      _$LookupQueryFromJson(json);
  Map<String, dynamic> toJson() => _$LookupQueryToJson(this);
}

@JsonSerializable()
class Area implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String sortName;
  String disambiguation;
  List<Alias> aliases;
  List<String> isoCodes;
  String type;
  String typeID;
  ArtistConnection artists;
  EventConnection events;
  LabelConnection labels;
  PlaceConnection places;
  ReleaseConnection releases;
  Relationships relationships;
  CollectionConnection collections;
  TagConnection tags;
  LastFMCountry lastFM;

  Area();

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  Map<String, dynamic> toJson() => _$AreaToJson(this);
}

@JsonSerializable()
class Node {
  @JsonKey(name: '__resolveType')
  String resolveType;
  String id;

  Node();

  factory Node.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Area':
        return _$AreaFromJson(json);
      case 'Artist':
        return _$ArtistFromJson(json);
      case 'Recording':
        return _$RecordingFromJson(json);
      case 'Release':
        return _$ReleaseFromJson(json);
      case 'Disc':
        return _$DiscFromJson(json);
      case 'Label':
        return _$LabelFromJson(json);
      case 'Collection':
        return _$CollectionFromJson(json);
      case 'Event':
        return _$EventFromJson(json);
      case 'Instrument':
        return _$InstrumentFromJson(json);
      case 'Place':
        return _$PlaceFromJson(json);
      case 'ReleaseGroup':
        return _$ReleaseGroupFromJson(json);
      case 'Series':
        return _$SeriesFromJson(json);
      case 'Work':
        return _$WorkFromJson(json);
      case 'URL':
        return _$URLFromJson(json);
      default:
    }
    return _$NodeFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Area':
        return _$AreaToJson(this as Area);
      case 'Artist':
        return _$ArtistToJson(this as Artist);
      case 'Recording':
        return _$RecordingToJson(this as Recording);
      case 'Release':
        return _$ReleaseToJson(this as Release);
      case 'Disc':
        return _$DiscToJson(this as Disc);
      case 'Label':
        return _$LabelToJson(this as Label);
      case 'Collection':
        return _$CollectionToJson(this as Collection);
      case 'Event':
        return _$EventToJson(this as Event);
      case 'Instrument':
        return _$InstrumentToJson(this as Instrument);
      case 'Place':
        return _$PlaceToJson(this as Place);
      case 'ReleaseGroup':
        return _$ReleaseGroupToJson(this as ReleaseGroup);
      case 'Series':
        return _$SeriesToJson(this as Series);
      case 'Work':
        return _$WorkToJson(this as Work);
      case 'URL':
        return _$URLToJson(this as URL);
      default:
    }
    return _$NodeToJson(this);
  }
}

@JsonSerializable()
class Entity {
  @JsonKey(name: '__resolveType')
  String resolveType;
  String mbid;

  Entity();

  factory Entity.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Area':
        return _$AreaFromJson(json);
      case 'Artist':
        return _$ArtistFromJson(json);
      case 'Recording':
        return _$RecordingFromJson(json);
      case 'Release':
        return _$ReleaseFromJson(json);
      case 'Track':
        return _$TrackFromJson(json);
      case 'Label':
        return _$LabelFromJson(json);
      case 'Collection':
        return _$CollectionFromJson(json);
      case 'Event':
        return _$EventFromJson(json);
      case 'Instrument':
        return _$InstrumentFromJson(json);
      case 'Place':
        return _$PlaceFromJson(json);
      case 'ReleaseGroup':
        return _$ReleaseGroupFromJson(json);
      case 'Series':
        return _$SeriesFromJson(json);
      case 'Work':
        return _$WorkFromJson(json);
      case 'URL':
        return _$URLFromJson(json);
      default:
    }
    return _$EntityFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Area':
        return _$AreaToJson(this as Area);
      case 'Artist':
        return _$ArtistToJson(this as Artist);
      case 'Recording':
        return _$RecordingToJson(this as Recording);
      case 'Release':
        return _$ReleaseToJson(this as Release);
      case 'Track':
        return _$TrackToJson(this as Track);
      case 'Label':
        return _$LabelToJson(this as Label);
      case 'Collection':
        return _$CollectionToJson(this as Collection);
      case 'Event':
        return _$EventToJson(this as Event);
      case 'Instrument':
        return _$InstrumentToJson(this as Instrument);
      case 'Place':
        return _$PlaceToJson(this as Place);
      case 'ReleaseGroup':
        return _$ReleaseGroupToJson(this as ReleaseGroup);
      case 'Series':
        return _$SeriesToJson(this as Series);
      case 'Work':
        return _$WorkToJson(this as Work);
      case 'URL':
        return _$URLToJson(this as URL);
      default:
    }
    return _$EntityToJson(this);
  }
}

@JsonSerializable()
class Alias {
  String name;
  String sortName;
  String locale;
  bool primary;
  String type;
  String typeID;

  Alias();

  factory Alias.fromJson(Map<String, dynamic> json) => _$AliasFromJson(json);
  Map<String, dynamic> toJson() => _$AliasToJson(this);
}

@JsonSerializable()
class ArtistConnection {
  PageInfo pageInfo;
  List<ArtistEdge> edges;
  List<Artist> nodes;
  int totalCount;

  ArtistConnection();

  factory ArtistConnection.fromJson(Map<String, dynamic> json) =>
      _$ArtistConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistConnectionToJson(this);
}

@JsonSerializable()
class PageInfo {
  bool hasNextPage;
  bool hasPreviousPage;
  String startCursor;
  String endCursor;

  PageInfo();

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}

@JsonSerializable()
class ArtistEdge {
  Artist node;
  String cursor;
  int score;

  ArtistEdge();

  factory ArtistEdge.fromJson(Map<String, dynamic> json) =>
      _$ArtistEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistEdgeToJson(this);
}

@JsonSerializable()
class Artist implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String sortName;
  String disambiguation;
  List<Alias> aliases;
  String country;
  Area area;
  Area beginArea;
  Area endArea;
  LifeSpan lifeSpan;
  String gender;
  String genderID;
  String type;
  String typeID;
  List<String> ipis;
  List<String> isnis;
  RecordingConnection recordings;
  ReleaseConnection releases;
  ReleaseGroupConnection releaseGroups;
  WorkConnection works;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;
  FanArtArtist fanArt;
  List<MediaWikiImage> mediaWikiImages;
  TheAudioDBArtist theAudioDB;
  DiscogsArtist discogs;
  LastFMArtist lastFM;
  SpotifyArtist spotify;

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
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime end;
  bool ended;

  LifeSpan();

  factory LifeSpan.fromJson(Map<String, dynamic> json) =>
      _$LifeSpanFromJson(json);
  Map<String, dynamic> toJson() => _$LifeSpanToJson(this);
}

@JsonSerializable()
class RecordingConnection {
  PageInfo pageInfo;
  List<RecordingEdge> edges;
  List<Recording> nodes;
  int totalCount;

  RecordingConnection();

  factory RecordingConnection.fromJson(Map<String, dynamic> json) =>
      _$RecordingConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$RecordingConnectionToJson(this);
}

@JsonSerializable()
class RecordingEdge {
  Recording node;
  String cursor;
  int score;

  RecordingEdge();

  factory RecordingEdge.fromJson(Map<String, dynamic> json) =>
      _$RecordingEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$RecordingEdgeToJson(this);
}

@JsonSerializable()
class Recording implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String title;
  String disambiguation;
  List<Alias> aliases;
  List<ArtistCredit> artistCredit;
  List<ArtistCredit> artistCredits;
  List<String> isrcs;
  Duration length;
  bool video;
  ArtistConnection artists;
  ReleaseConnection releases;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;
  TheAudioDBTrack theAudioDB;
  LastFMTrack lastFM;
  SpotifyTrack spotify;

  Recording();

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
  Map<String, dynamic> toJson() => _$RecordingToJson(this);
}

@JsonSerializable()
class ArtistCredit {
  Artist artist;
  String name;
  String joinPhrase;

  ArtistCredit();

  factory ArtistCredit.fromJson(Map<String, dynamic> json) =>
      _$ArtistCreditFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistCreditToJson(this);
}

enum ReleaseGroupType {
  ALBUM,
  SINGLE,
  EP,
  OTHER,
  BROADCAST,
  COMPILATION,
  SOUNDTRACK,
  SPOKENWORD,
  INTERVIEW,
  AUDIOBOOK,
  LIVE,
  REMIX,
  DJMIX,
  MIXTAPE,
  DEMO,
  NAT,
}

enum ReleaseStatus {
  OFFICIAL,
  PROMOTION,
  BOOTLEG,
  PSEUDORELEASE,
}

@JsonSerializable()
class ReleaseConnection {
  PageInfo pageInfo;
  List<ReleaseEdge> edges;
  List<Release> nodes;
  int totalCount;

  ReleaseConnection();

  factory ReleaseConnection.fromJson(Map<String, dynamic> json) =>
      _$ReleaseConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseConnectionToJson(this);
}

@JsonSerializable()
class ReleaseEdge {
  Release node;
  String cursor;
  int score;

  ReleaseEdge();

  factory ReleaseEdge.fromJson(Map<String, dynamic> json) =>
      _$ReleaseEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseEdgeToJson(this);
}

@JsonSerializable()
class Release implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String title;
  String disambiguation;
  List<Alias> aliases;
  List<ArtistCredit> artistCredit;
  List<ArtistCredit> artistCredits;
  List<ReleaseEvent> releaseEvents;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime date;
  String country;
  String asin;
  String barcode;
  ReleaseStatus status;
  String statusID;
  String packaging;
  String packagingID;
  String quality;
  List<Medium> media;
  ArtistConnection artists;
  LabelConnection labels;
  RecordingConnection recordings;
  ReleaseGroupConnection releaseGroups;
  Relationships relationships;
  CollectionConnection collections;
  TagConnection tags;
  CoverArtArchiveRelease coverArtArchive;
  DiscogsRelease discogs;
  LastFMAlbum lastFM;
  SpotifyAlbum spotify;

  Release();

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}

@JsonSerializable()
class ReleaseEvent {
  Area area;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime date;

  ReleaseEvent();

  factory ReleaseEvent.fromJson(Map<String, dynamic> json) =>
      _$ReleaseEventFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseEventToJson(this);
}

@JsonSerializable()
class Medium {
  String title;
  String format;
  String formatID;
  int position;
  int trackCount;
  List<Disc> discs;
  List<Track> tracks;

  Medium();

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);
  Map<String, dynamic> toJson() => _$MediumToJson(this);
}

@JsonSerializable()
class Disc implements Node {
  @override
  String id;
  String discID;
  int offsetCount;
  List<int> offsets;
  int sectors;
  ReleaseConnection releases;

  Disc();

  factory Disc.fromJson(Map<String, dynamic> json) => _$DiscFromJson(json);
  Map<String, dynamic> toJson() => _$DiscToJson(this);
}

@JsonSerializable()
class Track implements Entity {
  @override
  String mbid;
  String title;
  int position;
  String number;
  Duration length;
  Recording recording;

  Track();

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class LabelConnection {
  PageInfo pageInfo;
  List<LabelEdge> edges;
  List<Label> nodes;
  int totalCount;

  LabelConnection();

  factory LabelConnection.fromJson(Map<String, dynamic> json) =>
      _$LabelConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LabelConnectionToJson(this);
}

@JsonSerializable()
class LabelEdge {
  Label node;
  String cursor;
  int score;

  LabelEdge();

  factory LabelEdge.fromJson(Map<String, dynamic> json) =>
      _$LabelEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$LabelEdgeToJson(this);
}

@JsonSerializable()
class Label implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String sortName;
  String disambiguation;
  List<Alias> aliases;
  String country;
  Area area;
  LifeSpan lifeSpan;
  int labelCode;
  List<String> ipis;
  String type;
  String typeID;
  ReleaseConnection releases;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;
  FanArtLabel fanArt;
  List<MediaWikiImage> mediaWikiImages;
  DiscogsLabel discogs;

  Label();

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
  Map<String, dynamic> toJson() => _$LabelToJson(this);
}

@JsonSerializable()
class Relationships {
  RelationshipConnection areas;
  RelationshipConnection artists;
  RelationshipConnection events;
  RelationshipConnection instruments;
  RelationshipConnection labels;
  RelationshipConnection places;
  RelationshipConnection recordings;
  RelationshipConnection releases;
  RelationshipConnection releaseGroups;
  RelationshipConnection series;
  RelationshipConnection urls;
  RelationshipConnection works;

  Relationships();

  factory Relationships.fromJson(Map<String, dynamic> json) =>
      _$RelationshipsFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipsToJson(this);
}

@JsonSerializable()
class RelationshipConnection {
  PageInfo pageInfo;
  List<RelationshipEdge> edges;
  List<Relationship> nodes;
  int totalCount;

  RelationshipConnection();

  factory RelationshipConnection.fromJson(Map<String, dynamic> json) =>
      _$RelationshipConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipConnectionToJson(this);
}

@JsonSerializable()
class RelationshipEdge {
  Relationship node;
  String cursor;
  int score;

  RelationshipEdge();

  factory RelationshipEdge.fromJson(Map<String, dynamic> json) =>
      _$RelationshipEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipEdgeToJson(this);
}

@JsonSerializable()
class Relationship {
  Entity target;
  String direction;
  String targetType;
  String sourceCredit;
  String targetCredit;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime begin;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime end;
  bool ended;
  List<String> attributes;
  String type;
  String typeID;

  Relationship();

  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}

@JsonSerializable()
class CollectionConnection {
  PageInfo pageInfo;
  List<CollectionEdge> edges;
  List<Collection> nodes;
  int totalCount;

  CollectionConnection();

  factory CollectionConnection.fromJson(Map<String, dynamic> json) =>
      _$CollectionConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionConnectionToJson(this);
}

@JsonSerializable()
class CollectionEdge {
  Collection node;
  String cursor;
  int score;

  CollectionEdge();

  factory CollectionEdge.fromJson(Map<String, dynamic> json) =>
      _$CollectionEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionEdgeToJson(this);
}

@JsonSerializable()
class Collection implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String editor;
  String entityType;
  String type;
  String typeID;
  AreaConnection areas;
  ArtistConnection artists;
  EventConnection events;
  InstrumentConnection instruments;
  LabelConnection labels;
  PlaceConnection places;
  RecordingConnection recordings;
  ReleaseConnection releases;
  ReleaseGroupConnection releaseGroups;
  SeriesConnection series;
  WorkConnection works;

  Collection();

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

@JsonSerializable()
class AreaConnection {
  PageInfo pageInfo;
  List<AreaEdge> edges;
  List<Area> nodes;
  int totalCount;

  AreaConnection();

  factory AreaConnection.fromJson(Map<String, dynamic> json) =>
      _$AreaConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$AreaConnectionToJson(this);
}

@JsonSerializable()
class AreaEdge {
  Area node;
  String cursor;
  int score;

  AreaEdge();

  factory AreaEdge.fromJson(Map<String, dynamic> json) =>
      _$AreaEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$AreaEdgeToJson(this);
}

@JsonSerializable()
class EventConnection {
  PageInfo pageInfo;
  List<EventEdge> edges;
  List<Event> nodes;
  int totalCount;

  EventConnection();

  factory EventConnection.fromJson(Map<String, dynamic> json) =>
      _$EventConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$EventConnectionToJson(this);
}

@JsonSerializable()
class EventEdge {
  Event node;
  String cursor;
  int score;

  EventEdge();

  factory EventEdge.fromJson(Map<String, dynamic> json) =>
      _$EventEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$EventEdgeToJson(this);
}

@JsonSerializable()
class Event implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String disambiguation;
  List<Alias> aliases;
  LifeSpan lifeSpan;
  @JsonKey(
      fromJson: fromGraphQLTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTime)
  DateTime time;
  bool cancelled;
  String setlist;
  String type;
  String typeID;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;

  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Rating {
  int voteCount;
  double value;

  Rating();

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable()
class TagConnection {
  PageInfo pageInfo;
  List<TagEdge> edges;
  List<Tag> nodes;
  int totalCount;

  TagConnection();

  factory TagConnection.fromJson(Map<String, dynamic> json) =>
      _$TagConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$TagConnectionToJson(this);
}

@JsonSerializable()
class TagEdge {
  Tag node;
  String cursor;
  int score;

  TagEdge();

  factory TagEdge.fromJson(Map<String, dynamic> json) =>
      _$TagEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$TagEdgeToJson(this);
}

@JsonSerializable()
class Tag {
  String name;
  int count;

  Tag();

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class InstrumentConnection {
  PageInfo pageInfo;
  List<InstrumentEdge> edges;
  List<Instrument> nodes;
  int totalCount;

  InstrumentConnection();

  factory InstrumentConnection.fromJson(Map<String, dynamic> json) =>
      _$InstrumentConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$InstrumentConnectionToJson(this);
}

@JsonSerializable()
class InstrumentEdge {
  Instrument node;
  String cursor;
  int score;

  InstrumentEdge();

  factory InstrumentEdge.fromJson(Map<String, dynamic> json) =>
      _$InstrumentEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$InstrumentEdgeToJson(this);
}

@JsonSerializable()
class Instrument implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String disambiguation;
  List<Alias> aliases;
  String description;
  String type;
  String typeID;
  Relationships relationships;
  CollectionConnection collections;
  TagConnection tags;
  List<MediaWikiImage> mediaWikiImages;

  Instrument();

  factory Instrument.fromJson(Map<String, dynamic> json) =>
      _$InstrumentFromJson(json);
  Map<String, dynamic> toJson() => _$InstrumentToJson(this);
}

@JsonSerializable()
class MediaWikiImage {
  String url;
  String descriptionURL;
  String user;
  int size;
  int width;
  int height;
  String canonicalTitle;
  String objectName;
  String descriptionHTML;
  String originalDateTimeHTML;
  List<String> categories;
  String artistHTML;
  String creditHTML;
  String licenseShortName;
  String licenseURL;
  List<MediaWikiImageMetadata> metadata;

  MediaWikiImage();

  factory MediaWikiImage.fromJson(Map<String, dynamic> json) =>
      _$MediaWikiImageFromJson(json);
  Map<String, dynamic> toJson() => _$MediaWikiImageToJson(this);
}

@JsonSerializable()
class MediaWikiImageMetadata {
  String name;
  String value;
  String source;

  MediaWikiImageMetadata();

  factory MediaWikiImageMetadata.fromJson(Map<String, dynamic> json) =>
      _$MediaWikiImageMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MediaWikiImageMetadataToJson(this);
}

@JsonSerializable()
class PlaceConnection {
  PageInfo pageInfo;
  List<PlaceEdge> edges;
  List<Place> nodes;
  int totalCount;

  PlaceConnection();

  factory PlaceConnection.fromJson(Map<String, dynamic> json) =>
      _$PlaceConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceConnectionToJson(this);
}

@JsonSerializable()
class PlaceEdge {
  Place node;
  String cursor;
  int score;

  PlaceEdge();

  factory PlaceEdge.fromJson(Map<String, dynamic> json) =>
      _$PlaceEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceEdgeToJson(this);
}

@JsonSerializable()
class Place implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String disambiguation;
  List<Alias> aliases;
  String address;
  Area area;
  Coordinates coordinates;
  LifeSpan lifeSpan;
  String type;
  String typeID;
  EventConnection events;
  Relationships relationships;
  CollectionConnection collections;
  TagConnection tags;
  List<MediaWikiImage> mediaWikiImages;

  Place();

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

@JsonSerializable()
class Coordinates {
  double latitude;
  double longitude;

  Coordinates();

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}

@JsonSerializable()
class ReleaseGroupConnection {
  PageInfo pageInfo;
  List<ReleaseGroupEdge> edges;
  List<ReleaseGroup> nodes;
  int totalCount;

  ReleaseGroupConnection();

  factory ReleaseGroupConnection.fromJson(Map<String, dynamic> json) =>
      _$ReleaseGroupConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseGroupConnectionToJson(this);
}

@JsonSerializable()
class ReleaseGroupEdge {
  ReleaseGroup node;
  String cursor;
  int score;

  ReleaseGroupEdge();

  factory ReleaseGroupEdge.fromJson(Map<String, dynamic> json) =>
      _$ReleaseGroupEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseGroupEdgeToJson(this);
}

@JsonSerializable()
class ReleaseGroup implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String title;
  String disambiguation;
  List<Alias> aliases;
  List<ArtistCredit> artistCredit;
  List<ArtistCredit> artistCredits;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime firstReleaseDate;
  ReleaseGroupType primaryType;
  String primaryTypeID;
  List<ReleaseGroupType> secondaryTypes;
  List<String> secondaryTypeIDs;
  ArtistConnection artists;
  ReleaseConnection releases;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;
  CoverArtArchiveRelease coverArtArchive;
  FanArtAlbum fanArt;
  TheAudioDBAlbum theAudioDB;
  DiscogsMaster discogs;

  ReleaseGroup();

  factory ReleaseGroup.fromJson(Map<String, dynamic> json) =>
      _$ReleaseGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseGroupToJson(this);
}

@JsonSerializable()
class CoverArtArchiveRelease {
  String front;
  String back;
  List<CoverArtArchiveImage> images;
  bool artwork;
  int count;
  Release release;

  CoverArtArchiveRelease();

  factory CoverArtArchiveRelease.fromJson(Map<String, dynamic> json) =>
      _$CoverArtArchiveReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$CoverArtArchiveReleaseToJson(this);
}

enum CoverArtArchiveImageSize {
  SMALL,
  LARGE,
  FULL,
}

@JsonSerializable()
class CoverArtArchiveImage {
  String fileID;
  String image;
  CoverArtArchiveImageThumbnails thumbnails;
  bool front;
  bool back;
  List<String> types;
  int edit;
  bool approved;
  String comment;

  CoverArtArchiveImage();

  factory CoverArtArchiveImage.fromJson(Map<String, dynamic> json) =>
      _$CoverArtArchiveImageFromJson(json);
  Map<String, dynamic> toJson() => _$CoverArtArchiveImageToJson(this);
}

@JsonSerializable()
class CoverArtArchiveImageThumbnails {
  String small;
  String large;

  CoverArtArchiveImageThumbnails();

  factory CoverArtArchiveImageThumbnails.fromJson(Map<String, dynamic> json) =>
      _$CoverArtArchiveImageThumbnailsFromJson(json);
  Map<String, dynamic> toJson() => _$CoverArtArchiveImageThumbnailsToJson(this);
}

@JsonSerializable()
class FanArtAlbum {
  List<FanArtImage> albumCovers;
  List<FanArtDiscImage> discImages;

  FanArtAlbum();

  factory FanArtAlbum.fromJson(Map<String, dynamic> json) =>
      _$FanArtAlbumFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtAlbumToJson(this);
}

@JsonSerializable()
class FanArtImage {
  String imageID;
  String url;
  int likeCount;

  FanArtImage();

  factory FanArtImage.fromJson(Map<String, dynamic> json) =>
      _$FanArtImageFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtImageToJson(this);
}

enum FanArtImageSize {
  FULL,
  PREVIEW,
}

@JsonSerializable()
class FanArtDiscImage {
  String imageID;
  String url;
  int likeCount;
  int discNumber;
  int size;

  FanArtDiscImage();

  factory FanArtDiscImage.fromJson(Map<String, dynamic> json) =>
      _$FanArtDiscImageFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtDiscImageToJson(this);
}

@JsonSerializable()
class TheAudioDBAlbum {
  String albumID;
  String artistID;
  String description;
  String review;
  double salesCount;
  double score;
  double scoreVotes;
  String discImage;
  String spineImage;
  String frontImage;
  String backImage;
  String genre;
  String mood;
  String style;
  String speed;
  String theme;

  TheAudioDBAlbum();

  factory TheAudioDBAlbum.fromJson(Map<String, dynamic> json) =>
      _$TheAudioDBAlbumFromJson(json);
  Map<String, dynamic> toJson() => _$TheAudioDBAlbumToJson(this);
}

enum TheAudioDBImageSize {
  FULL,
  PREVIEW,
}

@JsonSerializable()
class DiscogsMaster {
  String masterID;
  String title;
  String url;
  List<DiscogsArtistCredit> artistCredits;
  List<String> genres;
  List<String> styles;
  int forSaleCount;
  double lowestPrice;
  int year;
  DiscogsRelease mainRelease;
  List<DiscogsImage> images;
  List<DiscogsVideo> videos;
  String dataQuality;

  DiscogsMaster();

  factory DiscogsMaster.fromJson(Map<String, dynamic> json) =>
      _$DiscogsMasterFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsMasterToJson(this);
}

@JsonSerializable()
class DiscogsArtistCredit {
  String name;
  String nameVariation;
  String joinPhrase;
  List<String> roles;
  List<String> tracks;
  DiscogsArtist artist;

  DiscogsArtistCredit();

  factory DiscogsArtistCredit.fromJson(Map<String, dynamic> json) =>
      _$DiscogsArtistCreditFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsArtistCreditToJson(this);
}

@JsonSerializable()
class DiscogsArtist {
  String artistID;
  String name;
  List<String> nameVariations;
  String realName;
  List<DiscogsArtist> aliases;
  String url;
  List<String> urls;
  String profile;
  List<DiscogsImage> images;
  List<DiscogsArtistMember> members;
  String dataQuality;

  DiscogsArtist();

  factory DiscogsArtist.fromJson(Map<String, dynamic> json) =>
      _$DiscogsArtistFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsArtistToJson(this);
}

@JsonSerializable()
class DiscogsImage {
  String url;
  DiscogsImageType type;
  int width;
  int height;
  String thumbnail;

  DiscogsImage();

  factory DiscogsImage.fromJson(Map<String, dynamic> json) =>
      _$DiscogsImageFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsImageToJson(this);
}

enum DiscogsImageType {
  PRIMARY,
  SECONDARY,
}

@JsonSerializable()
class DiscogsArtistMember {
  bool active;
  String name;
  DiscogsArtist artist;

  DiscogsArtistMember();

  factory DiscogsArtistMember.fromJson(Map<String, dynamic> json) =>
      _$DiscogsArtistMemberFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsArtistMemberToJson(this);
}

@JsonSerializable()
class DiscogsRelease {
  String releaseID;
  String title;
  String url;
  List<DiscogsArtistCredit> artistCredits;
  List<DiscogsArtistCredit> extraArtistCredits;
  List<String> genres;
  List<String> styles;
  int forSaleCount;
  double lowestPrice;
  int year;
  String notes;
  String country;
  DiscogsMaster master;
  String thumbnail;
  List<DiscogsImage> images;
  List<DiscogsVideo> videos;
  DiscogsCommunity community;
  String dataQuality;

  DiscogsRelease();

  factory DiscogsRelease.fromJson(Map<String, dynamic> json) =>
      _$DiscogsReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsReleaseToJson(this);
}

@JsonSerializable()
class DiscogsVideo {
  String url;
  String title;
  String description;
  Duration duration;
  bool embed;

  DiscogsVideo();

  factory DiscogsVideo.fromJson(Map<String, dynamic> json) =>
      _$DiscogsVideoFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsVideoToJson(this);
}

@JsonSerializable()
class DiscogsCommunity {
  String status;
  DiscogsRating rating;
  int haveCount;
  int wantCount;
  List<DiscogsUser> contributors;
  DiscogsUser submitter;

  DiscogsCommunity();

  factory DiscogsCommunity.fromJson(Map<String, dynamic> json) =>
      _$DiscogsCommunityFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsCommunityToJson(this);
}

@JsonSerializable()
class DiscogsRating {
  int voteCount;
  double value;

  DiscogsRating();

  factory DiscogsRating.fromJson(Map<String, dynamic> json) =>
      _$DiscogsRatingFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsRatingToJson(this);
}

@JsonSerializable()
class DiscogsUser {
  String username;

  DiscogsUser();

  factory DiscogsUser.fromJson(Map<String, dynamic> json) =>
      _$DiscogsUserFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsUserToJson(this);
}

@JsonSerializable()
class SeriesConnection {
  PageInfo pageInfo;
  List<SeriesEdge> edges;
  List<Series> nodes;
  int totalCount;

  SeriesConnection();

  factory SeriesConnection.fromJson(Map<String, dynamic> json) =>
      _$SeriesConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesConnectionToJson(this);
}

@JsonSerializable()
class SeriesEdge {
  Series node;
  String cursor;
  int score;

  SeriesEdge();

  factory SeriesEdge.fromJson(Map<String, dynamic> json) =>
      _$SeriesEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesEdgeToJson(this);
}

@JsonSerializable()
class Series implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String name;
  String disambiguation;
  String type;
  String typeID;
  Relationships relationships;
  CollectionConnection collections;
  TagConnection tags;

  Series();

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesToJson(this);
}

@JsonSerializable()
class WorkConnection {
  PageInfo pageInfo;
  List<WorkEdge> edges;
  List<Work> nodes;
  int totalCount;

  WorkConnection();

  factory WorkConnection.fromJson(Map<String, dynamic> json) =>
      _$WorkConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$WorkConnectionToJson(this);
}

@JsonSerializable()
class WorkEdge {
  Work node;
  String cursor;
  int score;

  WorkEdge();

  factory WorkEdge.fromJson(Map<String, dynamic> json) =>
      _$WorkEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$WorkEdgeToJson(this);
}

@JsonSerializable()
class Work implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String title;
  String disambiguation;
  List<Alias> aliases;
  List<String> iswcs;
  String language;
  String type;
  String typeID;
  ArtistConnection artists;
  Relationships relationships;
  CollectionConnection collections;
  Rating rating;
  TagConnection tags;

  Work();

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
  Map<String, dynamic> toJson() => _$WorkToJson(this);
}

@JsonSerializable()
class FanArtLabel {
  List<FanArtLabelImage> logos;

  FanArtLabel();

  factory FanArtLabel.fromJson(Map<String, dynamic> json) =>
      _$FanArtLabelFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtLabelToJson(this);
}

@JsonSerializable()
class FanArtLabelImage {
  String imageID;
  String url;
  int likeCount;
  String color;

  FanArtLabelImage();

  factory FanArtLabelImage.fromJson(Map<String, dynamic> json) =>
      _$FanArtLabelImageFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtLabelImageToJson(this);
}

@JsonSerializable()
class DiscogsLabel {
  String labelID;
  String name;
  String url;
  String profile;
  String contactInfo;
  DiscogsLabel parentLabel;
  List<DiscogsLabel> subLabels;
  List<DiscogsImage> images;
  String dataQuality;

  DiscogsLabel();

  factory DiscogsLabel.fromJson(Map<String, dynamic> json) =>
      _$DiscogsLabelFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsLabelToJson(this);
}

@JsonSerializable()
class LastFMAlbum {
  String mbid;
  String title;
  String url;
  String image;
  double listenerCount;
  double playCount;
  LastFMWikiContent description;
  LastFMArtist artist;
  LastFMTagConnection topTags;

  LastFMAlbum();

  factory LastFMAlbum.fromJson(Map<String, dynamic> json) =>
      _$LastFMAlbumFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMAlbumToJson(this);
}

enum LastFMImageSize {
  SMALL,
  MEDIUM,
  LARGE,
  EXTRALARGE,
  MEGA,
}

@JsonSerializable()
class LastFMWikiContent {
  String summaryHTML;
  String contentHTML;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime publishDate;
  @JsonKey(
      fromJson: fromGraphQLTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTime)
  DateTime publishTime;
  String url;

  LastFMWikiContent();

  factory LastFMWikiContent.fromJson(Map<String, dynamic> json) =>
      _$LastFMWikiContentFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMWikiContentToJson(this);
}

@JsonSerializable()
class LastFMArtist {
  String mbid;
  String name;
  String url;
  String image;
  double listenerCount;
  double playCount;
  LastFMArtistConnection similarArtists;
  LastFMAlbumConnection topAlbums;
  LastFMTagConnection topTags;
  LastFMTrackConnection topTracks;
  LastFMWikiContent biography;

  LastFMArtist();

  factory LastFMArtist.fromJson(Map<String, dynamic> json) =>
      _$LastFMArtistFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMArtistToJson(this);
}

@JsonSerializable()
class LastFMArtistConnection {
  PageInfo pageInfo;
  List<LastFMArtistEdge> edges;
  List<LastFMArtist> nodes;
  int totalCount;

  LastFMArtistConnection();

  factory LastFMArtistConnection.fromJson(Map<String, dynamic> json) =>
      _$LastFMArtistConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMArtistConnectionToJson(this);
}

@JsonSerializable()
class LastFMArtistEdge {
  LastFMArtist node;
  String cursor;
  double matchScore;

  LastFMArtistEdge();

  factory LastFMArtistEdge.fromJson(Map<String, dynamic> json) =>
      _$LastFMArtistEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMArtistEdgeToJson(this);
}

@JsonSerializable()
class LastFMAlbumConnection {
  PageInfo pageInfo;
  List<LastFMAlbumEdge> edges;
  List<LastFMAlbum> nodes;
  int totalCount;

  LastFMAlbumConnection();

  factory LastFMAlbumConnection.fromJson(Map<String, dynamic> json) =>
      _$LastFMAlbumConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMAlbumConnectionToJson(this);
}

@JsonSerializable()
class LastFMAlbumEdge {
  LastFMAlbum node;
  String cursor;

  LastFMAlbumEdge();

  factory LastFMAlbumEdge.fromJson(Map<String, dynamic> json) =>
      _$LastFMAlbumEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMAlbumEdgeToJson(this);
}

@JsonSerializable()
class LastFMTagConnection {
  PageInfo pageInfo;
  List<LastFMTagEdge> edges;
  List<LastFMTag> nodes;
  int totalCount;

  LastFMTagConnection();

  factory LastFMTagConnection.fromJson(Map<String, dynamic> json) =>
      _$LastFMTagConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTagConnectionToJson(this);
}

@JsonSerializable()
class LastFMTagEdge {
  LastFMTag node;
  String cursor;
  int tagCount;

  LastFMTagEdge();

  factory LastFMTagEdge.fromJson(Map<String, dynamic> json) =>
      _$LastFMTagEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTagEdgeToJson(this);
}

@JsonSerializable()
class LastFMTag {
  String name;
  String url;

  LastFMTag();

  factory LastFMTag.fromJson(Map<String, dynamic> json) =>
      _$LastFMTagFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTagToJson(this);
}

@JsonSerializable()
class LastFMTrackConnection {
  PageInfo pageInfo;
  List<LastFMTrackEdge> edges;
  List<LastFMTrack> nodes;
  int totalCount;

  LastFMTrackConnection();

  factory LastFMTrackConnection.fromJson(Map<String, dynamic> json) =>
      _$LastFMTrackConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTrackConnectionToJson(this);
}

@JsonSerializable()
class LastFMTrackEdge {
  LastFMTrack node;
  String cursor;
  double matchScore;

  LastFMTrackEdge();

  factory LastFMTrackEdge.fromJson(Map<String, dynamic> json) =>
      _$LastFMTrackEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTrackEdgeToJson(this);
}

@JsonSerializable()
class LastFMTrack {
  String mbid;
  String title;
  String url;
  Duration duration;
  double listenerCount;
  double playCount;
  LastFMWikiContent description;
  LastFMArtist artist;
  LastFMAlbum album;
  LastFMTrackConnection similarTracks;
  LastFMTagConnection topTags;

  LastFMTrack();

  factory LastFMTrack.fromJson(Map<String, dynamic> json) =>
      _$LastFMTrackFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMTrackToJson(this);
}

enum SpotifyMatchStrategy {
  URL,
  EXTERNALID,
}

@JsonSerializable()
class SpotifyAlbum {
  String albumID;
  String uri;
  String href;
  String title;
  ReleaseGroupType albumType;
  List<SpotifyArtist> artists;
  List<String> availableMarkets;
  List<SpotifyCopyright> copyrights;
  List<SpotifyExternalID> externalIDs;
  List<SpotifyExternalURL> externalURLs;
  List<String> genres;
  List<SpotifyImage> images;
  String label;
  int popularity;
  @JsonKey(
      fromJson: fromGraphQLDateToDartDateTime,
      toJson: fromDartDateTimeToGraphQLDate)
  DateTime releaseDate;

  SpotifyAlbum();

  factory SpotifyAlbum.fromJson(Map<String, dynamic> json) =>
      _$SpotifyAlbumFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyAlbumToJson(this);
}

@JsonSerializable()
class SpotifyArtist {
  String artistID;
  String uri;
  String href;
  String name;
  List<SpotifyExternalURL> externalURLs;
  List<String> genres;
  int popularity;
  List<SpotifyImage> images;
  List<SpotifyTrack> topTracks;
  List<SpotifyArtist> relatedArtists;

  SpotifyArtist();

  factory SpotifyArtist.fromJson(Map<String, dynamic> json) =>
      _$SpotifyArtistFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyArtistToJson(this);
}

@JsonSerializable()
class SpotifyExternalURL {
  String type;
  String url;

  SpotifyExternalURL();

  factory SpotifyExternalURL.fromJson(Map<String, dynamic> json) =>
      _$SpotifyExternalURLFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyExternalURLToJson(this);
}

@JsonSerializable()
class SpotifyImage {
  String url;
  int width;
  int height;

  SpotifyImage();

  factory SpotifyImage.fromJson(Map<String, dynamic> json) =>
      _$SpotifyImageFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyImageToJson(this);
}

@JsonSerializable()
class SpotifyTrack {
  String trackID;
  String uri;
  String href;
  String title;
  SpotifyAudioFeatures audioFeatures;
  SpotifyAlbum album;
  List<SpotifyArtist> artists;
  List<String> availableMarkets;
  int discNumber;
  Duration duration;
  bool explicit;
  List<SpotifyExternalID> externalIDs;
  List<SpotifyExternalURL> externalURLs;
  int popularity;
  String previewURL;
  int trackNumber;
  Recording musicBrainz;

  SpotifyTrack();

  factory SpotifyTrack.fromJson(Map<String, dynamic> json) =>
      _$SpotifyTrackFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyTrackToJson(this);
}

@JsonSerializable()
class SpotifyAudioFeatures {
  double acousticness;
  double danceability;
  Duration duration;
  double energy;
  double instrumentalness;
  int key;
  String keyName;
  double liveness;
  double loudness;
  SpotifyTrackMode mode;
  double speechiness;
  double tempo;
  double timeSignature;
  double valence;

  SpotifyAudioFeatures();

  factory SpotifyAudioFeatures.fromJson(Map<String, dynamic> json) =>
      _$SpotifyAudioFeaturesFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyAudioFeaturesToJson(this);
}

enum SpotifyTrackMode {
  MAJOR,
  MINOR,
}

@JsonSerializable()
class SpotifyExternalID {
  String type;
  String id;

  SpotifyExternalID();

  factory SpotifyExternalID.fromJson(Map<String, dynamic> json) =>
      _$SpotifyExternalIDFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyExternalIDToJson(this);
}

@JsonSerializable()
class SpotifyCopyright {
  String text;
  SpotifyCopyrightType type;

  SpotifyCopyright();

  factory SpotifyCopyright.fromJson(Map<String, dynamic> json) =>
      _$SpotifyCopyrightFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyCopyrightToJson(this);
}

enum SpotifyCopyrightType {
  COPYRIGHT,
  PERFORMANCE,
}

@JsonSerializable()
class TheAudioDBTrack {
  String trackID;
  String albumID;
  String artistID;
  String description;
  String thumbnail;
  double score;
  double scoreVotes;
  int trackNumber;
  TheAudioDBMusicVideo musicVideo;
  String genre;
  String mood;
  String style;
  String theme;

  TheAudioDBTrack();

  factory TheAudioDBTrack.fromJson(Map<String, dynamic> json) =>
      _$TheAudioDBTrackFromJson(json);
  Map<String, dynamic> toJson() => _$TheAudioDBTrackToJson(this);
}

@JsonSerializable()
class TheAudioDBMusicVideo {
  String url;
  String companyName;
  String directorName;
  List<String> screenshots;
  double viewCount;
  double likeCount;
  double dislikeCount;
  double commentCount;

  TheAudioDBMusicVideo();

  factory TheAudioDBMusicVideo.fromJson(Map<String, dynamic> json) =>
      _$TheAudioDBMusicVideoFromJson(json);
  Map<String, dynamic> toJson() => _$TheAudioDBMusicVideoToJson(this);
}

@JsonSerializable()
class FanArtArtist {
  List<FanArtImage> backgrounds;
  List<FanArtImage> banners;
  List<FanArtImage> logos;
  List<FanArtImage> logosHD;
  List<FanArtImage> thumbnails;

  FanArtArtist();

  factory FanArtArtist.fromJson(Map<String, dynamic> json) =>
      _$FanArtArtistFromJson(json);
  Map<String, dynamic> toJson() => _$FanArtArtistToJson(this);
}

@JsonSerializable()
class TheAudioDBArtist {
  String artistID;
  String biography;
  int memberCount;
  String banner;
  List<String> fanArt;
  String logo;
  String thumbnail;
  String genre;
  String mood;
  String style;

  TheAudioDBArtist();

  factory TheAudioDBArtist.fromJson(Map<String, dynamic> json) =>
      _$TheAudioDBArtistFromJson(json);
  Map<String, dynamic> toJson() => _$TheAudioDBArtistToJson(this);
}

@JsonSerializable()
class LastFMCountry {
  LastFMArtistConnection topArtists;
  LastFMTrackConnection topTracks;

  LastFMCountry();

  factory LastFMCountry.fromJson(Map<String, dynamic> json) =>
      _$LastFMCountryFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMCountryToJson(this);
}

@JsonSerializable()
class URL implements Node, Entity {
  @override
  String id;
  @override
  String mbid;
  String resource;
  Relationships relationships;

  URL();

  factory URL.fromJson(Map<String, dynamic> json) => _$URLFromJson(json);
  Map<String, dynamic> toJson() => _$URLToJson(this);
}

@JsonSerializable()
class BrowseQuery {
  AreaConnection areas;
  ArtistConnection artists;
  CollectionConnection collections;
  EventConnection events;
  LabelConnection labels;
  PlaceConnection places;
  RecordingConnection recordings;
  ReleaseConnection releases;
  ReleaseGroupConnection releaseGroups;
  WorkConnection works;

  BrowseQuery();

  factory BrowseQuery.fromJson(Map<String, dynamic> json) =>
      _$BrowseQueryFromJson(json);
  Map<String, dynamic> toJson() => _$BrowseQueryToJson(this);
}

@JsonSerializable()
class SearchQuery {
  AreaConnection areas;
  ArtistConnection artists;
  EventConnection events;
  InstrumentConnection instruments;
  LabelConnection labels;
  PlaceConnection places;
  RecordingConnection recordings;
  ReleaseConnection releases;
  ReleaseGroupConnection releaseGroups;
  SeriesConnection series;
  WorkConnection works;

  SearchQuery();

  factory SearchQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchQueryToJson(this);
}

@JsonSerializable()
class LastFMQuery {
  LastFMChartQuery chart;

  LastFMQuery();

  factory LastFMQuery.fromJson(Map<String, dynamic> json) =>
      _$LastFMQueryFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMQueryToJson(this);
}

@JsonSerializable()
class LastFMChartQuery {
  LastFMArtistConnection topArtists;
  LastFMTagConnection topTags;
  LastFMTrackConnection topTracks;

  LastFMChartQuery();

  factory LastFMChartQuery.fromJson(Map<String, dynamic> json) =>
      _$LastFMChartQueryFromJson(json);
  Map<String, dynamic> toJson() => _$LastFMChartQueryToJson(this);
}

@JsonSerializable()
class SpotifyQuery {
  SpotifyRecommendations recommendations;

  SpotifyQuery();

  factory SpotifyQuery.fromJson(Map<String, dynamic> json) =>
      _$SpotifyQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyQueryToJson(this);
}

@JsonSerializable()
class SpotifyRecommendations {
  List<SpotifyTrack> tracks;

  SpotifyRecommendations();

  factory SpotifyRecommendations.fromJson(Map<String, dynamic> json) =>
      _$SpotifyRecommendationsFromJson(json);
  Map<String, dynamic> toJson() => _$SpotifyRecommendationsToJson(this);
}

@JsonSerializable()
class DiscogsReleaseConnection {
  PageInfo pageInfo;
  List<DiscogsReleaseEdge> edges;
  List<DiscogsRelease> nodes;
  int totalCount;

  DiscogsReleaseConnection();

  factory DiscogsReleaseConnection.fromJson(Map<String, dynamic> json) =>
      _$DiscogsReleaseConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsReleaseConnectionToJson(this);
}

@JsonSerializable()
class DiscogsReleaseEdge {
  DiscogsRelease node;

  DiscogsReleaseEdge();

  factory DiscogsReleaseEdge.fromJson(Map<String, dynamic> json) =>
      _$DiscogsReleaseEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$DiscogsReleaseEdgeToJson(this);
}
