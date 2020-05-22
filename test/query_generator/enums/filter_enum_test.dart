import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    test(
      'Enums that are not used on result or input will be filtered out',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryRoot
          }

          type QueryRoot {
            q(e: InputEnum!, i: Input!): QueryResponse
          }

          input Input {
            e: InputInputEnum
          }

          type QueryResponse {
            e: MyEnum
          }

          enum MyEnum {
            a
            b
          }

          enum InputEnum {
            c
            d
          }

          enum InputInputEnum {
            e
            f
          }

          type UnusedObject {
            e: UnusedEnum
          }

          input UnusedInput {
            u: UnusedEnum
          }

          enum UnusedEnum {
            g
            h
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
  query custom($e: InputEnum!, $i: Input!) {
    q(e: $e, i: $i) {
      e
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: ClassName(name: r'Custom$QueryRoot'),
      classes: [
        EnumDefinition(
            name: ClassName(name: r'MyEnum'),
            values: [r'a', r'b', r'artemisUnknown']),
        EnumDefinition(
            name: ClassName(name: r'InputEnum'),
            values: [r'c', r'd', r'artemisUnknown']),
        EnumDefinition(
            name: ClassName(name: r'InputInputEnum'),
            values: [r'e', r'f', r'artemisUnknown']),
        ClassDefinition(
            name: ClassName(name: r'Custom$QueryRoot$QueryResponse'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'MyEnum'),
                  name: VariableName(name: r'e'),
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
            name: ClassName(name: r'Custom$QueryRoot'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'Custom$QueryRoot$QueryResponse'),
                  name: VariableName(name: r'q'),
                  annotations: [],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: ClassName(name: r'InputInputEnum'),
                  name: VariableName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: InputInputEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: ClassName(name: r'InputEnum'),
            name: VariableName(name: r'e'),
            isNonNull: true,
            annotations: [
              r'JsonKey(unknownEnumValue: InputEnum.artemisUnknown)'
            ]),
        QueryInput(
            type: ClassName(name: r'Input'),
            name: VariableName(name: r'i'),
            isNonNull: true,
            annotations: [])
      ],
      generateHelpers: false,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input with EquatableMixin {
  Input({this.e});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(unknownEnumValue: InputInputEnum.artemisUnknown)
  InputInputEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  a,
  b,
  artemisUnknown,
}
enum InputEnum {
  c,
  d,
  artemisUnknown,
}
enum InputInputEnum {
  e,
  f,
  artemisUnknown,
}
''';
