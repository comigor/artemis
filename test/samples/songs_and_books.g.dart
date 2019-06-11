// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_and_books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IDable _$IDableFromJson(Map<String, dynamic> json) {
  return IDable()
    ..resolveType = json['__resolveType'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$IDableToJson(IDable instance) =>
    <String, dynamic>{'__resolveType': instance.resolveType, 'id': instance.id};

Titleable _$TitleableFromJson(Map<String, dynamic> json) {
  return Titleable()
    ..resolveType = json['__resolveType'] as String
    ..title = json['title'] as String;
}

Map<String, dynamic> _$TitleableToJson(Titleable instance) => <String, dynamic>{
      '__resolveType': instance.resolveType,
      'title': instance.title
    };

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song()
    ..resolveType = json['__resolveType'] as String
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..duration = json['duration'] as int;
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      '__resolveType': instance.resolveType,
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration
    };

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book()
    ..resolveType = json['__resolveType'] as String
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..pages = json['pages'] as int;
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      '__resolveType': instance.resolveType,
      'id': instance.id,
      'title': instance.title,
      'pages': instance.pages
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result()..resolveType = json['__resolveType'] as String;
}

Map<String, dynamic> _$ResultToJson(Result instance) =>
    <String, dynamic>{'__resolveType': instance.resolveType};

Query _$QueryFromJson(Map<String, dynamic> json) {
  return Query()
    ..allResults = (json['allResults'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..byIds = (json['byIds'] as List)
        ?.map((e) =>
            e == null ? null : IDable.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      'allResults': instance.allResults,
      'byIds': instance.byIds
    };
