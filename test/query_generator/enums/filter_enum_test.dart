import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
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
            q(e: input_enum!, i: Input!): QueryResponse
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

          enum input_enum {
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
  query custom($e: input_enum!, $i: Input!) {
    q(e: $e, i: $i) {
      e
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'Custom$_QueryRoot'),
      operationName: r'custom',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'A')),
          EnumValueDefinition(name: EnumValueName(name: r'B')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        EnumDefinition(name: EnumName(name: r'input_enum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'C')),
          EnumValueDefinition(name: EnumValueName(name: r'D')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        EnumDefinition(name: EnumName(name: r'_InputInputEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'_E')),
          EnumValueDefinition(name: EnumValueName(name: r'_F')),
          EnumValueDefinition(name: EnumValueName(name: r'_new')),
          EnumValueDefinition(name: EnumValueName(name: r'new')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot$_QueryResponse'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Custom$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'Custom$_QueryRoot$_QueryResponse'),
                  name: ClassPropertyName(name: r'q'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
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
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'input_enum', isNonNull: true),
            name: QueryInputName(name: r'e'),
            annotations: [
              r'JsonKey(unknownEnumValue: InputEnum.artemisUnknown)'
            ]),
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'i'))
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
class Custom$QueryRoot$QueryResponse extends JsonSerializable
    with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum? e;

  @override
  List<Object?> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot extends JsonSerializable with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse? q;

  @override
  List<Object?> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input({this.e});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @JsonKey(unknownEnumValue: $InputInputEnum.artemisUnknown)
  $InputInputEnum? e;

  @override
  List<Object?> get props => [e];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  @JsonValue('A')
  a,
  @JsonValue('B')
  b,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum InputEnum {
  @JsonValue('C')
  c,
  @JsonValue('D')
  d,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
enum $InputInputEnum {
  @JsonValue('_E')
  $e,
  @JsonValue('_F')
  $f,
  @JsonValue('_new')
  $new,
  @JsonValue('new')
  kw$new,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}
''';
