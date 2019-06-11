import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On complex schemas: interfaces with unions', () {
    final builder = graphQLTypesBuilder(BuilderOptions({}));

    test(
        'An object can implement interfaces and be part of a union type at the same time',
        () async {
      final GraphQLSchema schema = GraphQLSchema(types: [
        GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
        GraphQLType(name: 'IDable', kind: GraphQLTypeKind.INTERFACE, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR))
        ], possibleTypes: [
          GraphQLType(name: 'Song', kind: GraphQLTypeKind.OBJECT),
          GraphQLType(name: 'Book', kind: GraphQLTypeKind.OBJECT),
        ]),
        GraphQLType(
            name: 'Titleable',
            kind: GraphQLTypeKind.INTERFACE,
            fields: [
              GraphQLField(
                  name: 'title',
                  type:
                      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR))
            ],
            possibleTypes: [
              GraphQLType(name: 'Song', kind: GraphQLTypeKind.OBJECT),
              GraphQLType(name: 'Book', kind: GraphQLTypeKind.OBJECT),
            ]),
        GraphQLType(name: 'Song', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'title',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'duration',
              type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR))
        ], interfaces: [
          GraphQLType(name: 'IDable', kind: GraphQLTypeKind.INTERFACE),
          GraphQLType(name: 'Titleable', kind: GraphQLTypeKind.INTERFACE),
        ]),
        GraphQLType(name: 'Book', kind: GraphQLTypeKind.OBJECT, fields: [
          GraphQLField(
              name: 'id',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'title',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLField(
              name: 'pages',
              type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR))
        ], interfaces: [
          GraphQLType(name: 'IDable', kind: GraphQLTypeKind.INTERFACE),
          GraphQLType(name: 'Titleable', kind: GraphQLTypeKind.INTERFACE),
        ]),
        GraphQLType(
            name: 'Result',
            kind: GraphQLTypeKind.UNION,
            possibleTypes: [
              GraphQLType(name: 'Song', kind: GraphQLTypeKind.OBJECT),
              GraphQLType(name: 'Book', kind: GraphQLTypeKind.OBJECT),
            ]),
      ]);

      await testBuilder(builder, {
        'a|api.schema.json': jsonFromSchema(schema),
      }, outputs: {
        'a|api.api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'api.api.g.dart';

@JsonSerializable()
class IDable {
  @JsonKey(name: \'__resolveType\')
  String resolveType;
  String id;

  IDable();

  factory IDable.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _\$SongFromJson(json);
      case 'Book':
        return _\$BookFromJson(json);
      default:
    }
    return _\$IDableFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _\$SongToJson(this as Song);
      case 'Book':
        return _\$BookToJson(this as Book);
      default:
    }
    return _\$IDableToJson(this);
  }
}

@JsonSerializable()
class Titleable {
  @JsonKey(name: \'__resolveType\')
  String resolveType;
  String title;

  Titleable();

  factory Titleable.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _\$SongFromJson(json);
      case 'Book':
        return _\$BookFromJson(json);
      default:
    }
    return _\$TitleableFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _\$SongToJson(this as Song);
      case 'Book':
        return _\$BookToJson(this as Book);
      default:
    }
    return _\$TitleableToJson(this);
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

  factory Song.fromJson(Map<String, dynamic> json) => _\$SongFromJson(json);
  Map<String, dynamic> toJson() => _\$SongToJson(this);
}

@JsonSerializable()
class Book extends Result implements IDable, Titleable {
  @override
  String id;
  @override
  String title;
  int pages;

  Book();

  factory Book.fromJson(Map<String, dynamic> json) => _\$BookFromJson(json);
  Map<String, dynamic> toJson() => _\$BookToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: \'__resolveType\')
  String resolveType;

  Result();

  factory Result.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType']) {
      case 'Song':
        return _\$SongFromJson(json);
      case 'Book':
        return _\$BookFromJson(json);
      default:
    }
    return _\$ResultFromJson(json);
  }
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'Song':
        return _\$SongToJson(this as Song);
      case 'Book':
        return _\$BookToJson(this as Book);
      default:
    }
    return _\$ResultToJson(this);
  }
}
''',
      });
    });
  });
}
