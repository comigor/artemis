import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On aliases', () {
    test(
      'Leaves can be aliased',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: Response
          }

          type Response {
            s: String
            o: SomeObject
            ob: [SomeObject]
          }

          type SomeObject {
            e: MyEnum
          }
          
          enum MyEnum {
            a
            b
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
          thisIsAString: s
          o {
            thisIsAnEnum: e
          }
        }
        ''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$Response',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'a', r'b', r'artemisUnknown']),
        ClassDefinition(
            name: r'SomeQuery$Response$SomeObject',
            properties: [
              ClassProperty(
                  type: r'MyEnum',
                  name: r'thisIsAnEnum',
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'SomeQuery$Response',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r'thisIsAString',
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'SomeQuery$Response$SomeObject',
                  name: r'o',
                  isNonNull: false,
                  isResolveType: false)
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
class SomeQuery$Response$SomeObject with EquatableMixin {
  SomeQuery$Response$SomeObject();

  factory SomeQuery$Response$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Response$SomeObjectFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum thisIsAnEnum;

  @override
  List<Object> get props => [thisIsAnEnum];
  Map<String, dynamic> toJson() => _$SomeQuery$Response$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Response with EquatableMixin {
  SomeQuery$Response();

  factory SomeQuery$Response.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$ResponseFromJson(json);

  String thisIsAString;

  SomeQuery$Response$SomeObject o;

  @override
  List<Object> get props => [thisIsAString, o];
  Map<String, dynamic> toJson() => _$SomeQuery$ResponseToJson(this);
}

enum MyEnum {
  a,
  b,
  artemisUnknown,
}
''';
