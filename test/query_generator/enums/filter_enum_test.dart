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
            A
            B
          }

          enum InputEnum {
            C
            D
          }

          enum InputInputEnum {
            E
            F
          }

          type UnusedObject {
            e: UnusedEnum
          }

          input UnusedInput {
            u: UnusedEnum
          }

          enum UnusedEnum {
            G
            H
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
      queryType: r'Custom$QueryRoot',
      classes: [
        EnumDefinition(
            name: r'MyEnum', values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        EnumDefinition(
            name: r'InputEnum', values: [r'C', r'D', r'ARTEMIS_UNKNOWN']),
        EnumDefinition(
            name: r'InputInputEnum', values: [r'E', r'F', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom$QueryRoot$QueryResponse',
            properties: [
              ClassProperty(
                  type: r'MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'Custom$QueryRoot$QueryResponse',
                  name: r'q',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Input',
            properties: [
              ClassProperty(
                  type: r'InputInputEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: InputInputEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: r'InputEnum',
            name: r'e',
            isNonNull: true,
            annotation:
                r'JsonKey(unknownEnumValue: InputEnum.ARTEMIS_UNKNOWN)'),
        QueryInput(type: r'Input', name: r'i', isNonNull: true)
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

  @JsonKey(unknownEnumValue: MyEnum.ARTEMIS_UNKNOWN)
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

  @JsonKey(unknownEnumValue: InputInputEnum.ARTEMIS_UNKNOWN)
  InputInputEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
enum InputEnum {
  C,
  D,
  ARTEMIS_UNKNOWN,
}
enum InputInputEnum {
  E,
  F,
  ARTEMIS_UNKNOWN,
}
''';
