import 'package:artemis/generator/data/data.dart';
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
            e: _InputInputEnum
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

          enum _InputInputEnum {
            _E
            _F
            _new
            new
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
      name: QueryName(name: r'custom$_QueryRoot'),
      operationName: r'custom',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValue(name: r'A'),
          EnumValue(name: r'B'),
          EnumValue(name: r'ARTEMIS_UNKNOWN')
        ]),
        EnumDefinition(name: EnumName(name: r'InputEnum'), values: [
          EnumValue(name: r'C'),
          EnumValue(name: r'D'),
          EnumValue(name: r'ARTEMIS_UNKNOWN')
        ]),
        EnumDefinition(name: EnumName(name: r'_InputInputEnum'), values: [
          EnumValue(name: r'_E'),
          EnumValue(name: r'_F'),
          EnumValue(name: r'_new'),
          EnumValue(name: r'new'),
          EnumValue(name: r'ARTEMIS_UNKNOWN')
        ]),
        ClassDefinition(
            name: ClassName(name: r'custom$_QueryRoot$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'custom$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$QueryRoot$QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'_InputInputEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: $InputInputEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: '__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'InputEnum'),
            name: QueryInputName(name: r'e'),
            isNonNull: true,
            annotations: [
              r'JsonKey(unknownEnumValue: InputEnum.artemisUnknown)'
            ]),
        QueryInput(
            type: TypeName(name: r'Input'),
            name: QueryInputName(name: r'i'),
            isNonNull: true)
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

  @JsonKey(unknownEnumValue: $InputInputEnum.artemisUnknown)
  $InputInputEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  @JsonValue("A")
  a,
  @JsonValue("B")
  b,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}
enum InputEnum {
  @JsonValue("C")
  c,
  @JsonValue("D")
  d,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}
enum $InputInputEnum {
  @JsonValue("_E")
  $e,
  @JsonValue("_F")
  $f,
  @JsonValue("_new")
  $new,
  @JsonValue("new")
  kw$new,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}
''';
