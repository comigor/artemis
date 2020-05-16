import 'package:artemis/generator/data/data.dart';
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
      name: QueryName(name: r'some_query$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'some_query$_QueryResponse$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'st'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'some_query$_QueryResponse$_anotherObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r'str'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'some_query$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$QueryResponse$SomeObject'),
                  name: ClassPropertyName(name: r'o'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(
                      name: r'List<SomeQuery$QueryResponse$AnotherObject>'),
                  name: ClassPropertyName(name: r'anotherObject'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
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
