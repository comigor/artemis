import 'package:artemis/generator/data/data.dart';
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
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_SomeObject'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query'),
  QueryDefinition(
      name: QueryName(name: r'AnotherQuery$_SomeObject'),
      operationName: r'another_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'AnotherQuery$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject extends JsonSerializable with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  String? s;

  int? i;

  @override
  List<Object?> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherQuery$SomeObject extends JsonSerializable with EquatableMixin {
  AnotherQuery$SomeObject();

  factory AnotherQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$AnotherQuery$SomeObjectFromJson(json);

  String? s;

  @override
  List<Object?> get props => [s];
  Map<String, dynamic> toJson() => _$AnotherQuery$SomeObjectToJson(this);
}
''';
