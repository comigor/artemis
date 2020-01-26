import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On multiple queries', () {
    testGenerator(
      description: 'Header and part should only be included once',
      query: r'query some_query { s, i }',
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      typedSchema: schema,
      sourceAssetsMap: {
        'a|another_query.graphql': 'query another_query { s }',
      },
    );
  });
}

final schema = GraphQLSchema(
    queryType: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
    types: [
      GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
      GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
        GraphQLField(
            name: 's',
            type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
        GraphQLField(
            name: 'i',
            type: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
      ]),
    ]);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
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
            resolveTypeField: r'__resolveType')
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
            resolveTypeField: r'__resolveType')
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
