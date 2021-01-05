// @dart = 2.8

import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  test(
    'On multiple reference of same fragment on simple naming',
    () async => testGenerator(
      query: r'''
          fragment myFragment on SomeObject {
            s, i
          }

          query some_query {
            someObject {
              ...myFragment
            }
            moreData {
              someObject {
                ...myFragment
              }
            }
          }
        ''',
      schema: r'''
         schema {
            query: QueryResponse
          }

          type QueryResponse {
            someObject: SomeObject
            moreData: MoreData
          }

          type MoreData {
            someObject: SomeObject
          }

          type SomeObject {
            s: String
            i: Int
          }
        ''',
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      namingScheme: 'simple',
    ),
  );
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_QueryResponse'),
      operationName: r'some_query',
      classes: [
        FragmentClassDefinition(
            name: FragmentName(name: r'MyFragmentMixin'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'int'),
                  name: ClassPropertyName(name: r'i'),
                  isNonNull: false,
                  isResolveType: false)
            ]),
        ClassDefinition(
            name: ClassName(name: r'SomeObject'),
            mixins: [FragmentName(name: r'MyFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeObject'),
            mixins: [FragmentName(name: r'MyFragmentMixin')],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'MoreData'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeObject'),
                  name: ClassPropertyName(name: r'someObject'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeObject'),
                  name: ClassPropertyName(name: r'someObject'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MoreData'),
                  name: ClassPropertyName(name: r'moreData'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
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

mixin MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin, MyFragmentMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MoreData with EquatableMixin {
  MoreData();

  factory MoreData.fromJson(Map<String, dynamic> json) =>
      _$MoreDataFromJson(json);

  SomeObject someObject;

  @override
  List<Object> get props => [someObject];
  Map<String, dynamic> toJson() => _$MoreDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryResponse with EquatableMixin {
  SomeQuery$QueryResponse();

  factory SomeQuery$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryResponseFromJson(json);

  SomeObject someObject;

  MoreData moreData;

  @override
  List<Object> get props => [someObject, moreData];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryResponseToJson(this);
}
''';
