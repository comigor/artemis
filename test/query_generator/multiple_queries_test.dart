import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On multiple queries', () {
    test(
      'Header and part should only be included once',
      () async => testGenerator(
        query: r'query some_query { s, i }',
        schema: r'''
            schema {
              query: SomeObject
            }
            
            type SomeObject {
              s: String
              i: Int
            }
          ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        sourceAssetsMap: {
          'a|queries/another_query.graphql': 'query another_query { s }',
        },
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$SomeObject',
      classes: [
        ClassDefinition(
            name: r'SomeQuery$SomeObject',
            properties: [
              ClassProperty(type: r'String', name: r's', isOverride: false),
              ClassProperty(type: r'int', name: r'i', isOverride: false)
            ],
            typeNameField: r'__typename')
      ],
      generateHelpers: false),
  QueryDefinition(
      queryName: r'another_query',
      queryType: r'AnotherQuery$SomeObject',
      classes: [
        ClassDefinition(
            name: r'AnotherQuery$SomeObject',
            properties: [
              ClassProperty(type: r'String', name: r's', isOverride: false)
            ],
            typeNameField: r'__typename')
      ],
      generateHelpers: false)
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  String s;

  int i;

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherQuery$SomeObject with EquatableMixin {
  AnotherQuery$SomeObject();

  factory AnotherQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$AnotherQuery$SomeObjectFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$AnotherQuery$SomeObjectToJson(this);
}
''';
