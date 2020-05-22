import 'package:artemis/generator/data.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On aliases', () {
    test(
      'Objects can be aliased',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryResponse
          }

          type QueryResponse {
            s: String
            o: SomeObject
            ob: [SomeObject]
          }

          type SomeObject {
            st: String
            str: String
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query some_query {
    s
    o {
      st
    }
    anotherObject: ob {
      str
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      document: parseString(query),
      queryName: r'some_query',
      queryType: ClassName(name: r'SomeQuery$QueryResponse'),
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$QueryResponse$SomeObject'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r'st'),
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$QueryResponse$AnotherObject'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r'str'),
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$QueryResponse'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'String'),
                  name: VariableName(name: r's'),
                  isNonNull: false),
              ClassProperty(
                  type: ClassName(name: r'SomeQuery$QueryResponse$SomeObject'),
                  name: VariableName(name: r'o'),
                  isNonNull: false),
              ClassProperty(
                  type: ClassName(
                      name: r'List<SomeQuery$QueryResponse$AnotherObject>'),
                  name: VariableName(name: r'anotherObject'),
                  isNonNull: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false)
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$SomeObject with EquatableMixin {
  SomeQuery$QueryResponse$SomeObject();

  factory SomeQuery$QueryResponse$SomeObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$SomeObjectFromJson(json);

  String st;

  @override
  List<Object> get props => [st];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$AnotherObject with EquatableMixin {
  SomeQuery$QueryResponse$AnotherObject();

  factory SomeQuery$QueryResponse$AnotherObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  String s;

  SomeQuery$QueryResponse$SomeObject o;

  List<SomeQuery$QueryResponse$AnotherObject> anotherObject;

  @override
  List<Object> get props => [s, o, anotherObject];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
