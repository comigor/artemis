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
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse$_SomeObject'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'st'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse$_anotherObject'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r'str'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$_QueryResponse$_SomeObject'),
                  name: ClassPropertyName(name: r'o'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: TypeName(
                          name: r'SomeQuery$_QueryResponse$_anotherObject'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'anotherObject'),
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
class SomeQuery$QueryResponse$SomeObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$SomeObject();

  factory SomeQuery$QueryResponse$SomeObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$SomeObjectFromJson(json);

  String? st;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [st, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse$AnotherObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryResponse$AnotherObject();

  factory SomeQuery$QueryResponse$AnotherObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponse$AnotherObjectFromJson(json);

  String? str;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [str, $$typename];
  @override
  Map<String, dynamic> toJson() =>
      _$SomeQuery$QueryResponse$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  String? s;

  SomeQuery$QueryResponse$SomeObject? o;

  List<SomeQuery$QueryResponse$AnotherObject?>? anotherObject;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [s, o, anotherObject, $$typename];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
