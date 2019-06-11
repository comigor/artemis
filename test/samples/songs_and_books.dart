// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'songs_and_books.g.dart';

@JsonSerializable()
class IDable {
  @JsonKey(name: '__resolveType')
  String resolveType;
  String id;

  IDable();

  factory IDable.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _$SongFromJson(json);
      case 'Book':
        return _$BookFromJson(json);
      default:
    }
    return _$IDableFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _$SongToJson(this as Song);
      case 'Book':
        return _$BookToJson(this as Book);
      default:
    }
    return _$IDableToJson(this);
  }
}

@JsonSerializable()
class Titleable {
  @JsonKey(name: '__resolveType')
  String resolveType;
  String title;

  Titleable();

  factory Titleable.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _$SongFromJson(json);
      case 'Book':
        return _$BookFromJson(json);
      default:
    }
    return _$TitleableFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _$SongToJson(this as Song);
      case 'Book':
        return _$BookToJson(this as Book);
      default:
    }
    return _$TitleableToJson(this);
  }
}

@JsonSerializable()
class Song extends Result implements IDable, Titleable {
  @override
  String id;
  @override
  String title;
  int duration;

  Song();

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}

@JsonSerializable()
class Book extends Result implements IDable, Titleable {
  @override
  String id;
  @override
  String title;
  int pages;

  Book();

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: '__resolveType')
  String resolveType;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _$SongFromJson(json);
      case 'Book':
        return _$BookFromJson(json);
      default:
    }
    return _$ResultFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _$SongToJson(this as Song);
      case 'Book':
        return _$BookToJson(this as Book);
      default:
    }
    return _$ResultToJson(this);
  }
}

@JsonSerializable()
class Query {
  List<Result> allResults;
  List<IDable> byIds;

  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
