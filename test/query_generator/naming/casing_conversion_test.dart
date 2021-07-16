import 'package:artemis/generator/data/annotation.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On types/fields names', () {
    test(
      'Casing will be converted accordingly (and JsonKey names willb e populated accordingly)',
      () async => testGenerator(
        query: r'''
          query some_query($filter: Input!) {
            query(filter: $filter) {
              camelCaseField
              PascalCaseField
              snake_case_field
              SCREAMING_SNAKE_CASE_FIELD
              e
            }
            
          }''',
        schema: r'''
          type Query {
            query(input: Input): SomeObject
          }

          input Input {
            camelCaseField: camelCaseTypeInput
            PascalCaseField: PascalCaseTypeInput
            snake_case_field: snake_case_type_input
            SCREAMING_SNAKE_CASE_FIELD: SCREAMING_SNAKE_CASE_TYPE_INPUT
            e: MyEnum
          }

          type SomeObject {
            camelCaseField: camelCaseType
            PascalCaseField: PascalCaseType
            snake_case_field: snake_case_type
            SCREAMING_SNAKE_CASE_FIELD: SCREAMING_SNAKE_CASE_TYPE
            e: MyEnum
          }

          type camelCaseType {
            s: String
          }

          type PascalCaseType {
            s: String
          }

          type snake_case_type {
            s: String
          }

          type SCREAMING_SNAKE_CASE_TYPE {
            s: String
          }

          type camelCaseTypeInput {
            s: String
          }

          type PascalCaseTypeInput {
            s: String
          }

          type snake_case_type_input {
            s: String
          }

          type SCREAMING_SNAKE_CASE_TYPE_INPUT {
            s: String
          }

          enum MyEnum {
            camelCase
            PascalCase
            snake_case
            SCREAMING_SNAKE_CASE
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
        namingScheme: 'simple',
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_Query'),
      operationName: r'some_query',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'camelCase')),
          EnumValueDefinition(name: EnumValueName(name: r'PascalCase')),
          EnumValueDefinition(name: EnumValueName(name: r'snake_case')),
          EnumValueDefinition(
              name: EnumValueName(name: r'SCREAMING_SNAKE_CASE')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'CamelCaseType'),
                  name: ClassPropertyName(name: r'camelCaseField'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PascalCaseType'),
                  name: ClassPropertyName(name: r'PascalCaseField'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(name: r'PascalCaseField'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'SnakeCaseType'),
                  name: ClassPropertyName(name: r'snake_case_field'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(name: r'snake_case_field'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'ScreamingSnakeCaseType'),
                  name: ClassPropertyName(name: r'SCREAMING_SNAKE_CASE_FIELD'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey:
                            JsonKeyItem(name: r'SCREAMING_SNAKE_CASE_FIELD'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'MyEnum.artemisUnknown'))
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_Query'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeObject'),
                  name: ClassPropertyName(name: r'query'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'CamelCaseTypeInput'),
                  name: ClassPropertyName(name: r'camelCaseField'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'PascalCaseTypeInput'),
                  name: ClassPropertyName(name: r'PascalCaseField'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(name: r'PascalCaseField'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'SnakeCaseTypeInput'),
                  name: ClassPropertyName(name: r'snake_case_field'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(name: r'snake_case_field'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'ScreamingSnakeCaseTypeInput'),
                  name: ClassPropertyName(name: r'SCREAMING_SNAKE_CASE_FIELD'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey:
                            JsonKeyItem(name: r'SCREAMING_SNAKE_CASE_FIELD'))
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    JsonKeyAnnotation(
                        jsonKey: JsonKeyItem(
                            unknownEnumValue: r'MyEnum.artemisUnknown'))
                  ],
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'Input', isNonNull: true),
            name: QueryInputName(name: r'filter'))
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeObject extends JsonSerializable with EquatableMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  CamelCaseType? camelCaseField;

  @JsonKey(name: 'PascalCaseField')
  PascalCaseType? pascalCaseField;

  @JsonKey(name: 'snake_case_field')
  SnakeCaseType? snakeCaseField;

  @JsonKey(name: 'SCREAMING_SNAKE_CASE_FIELD')
  ScreamingSnakeCaseType? screamingSnakeCaseField;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum? e;

  @override
  List<Object?> get props => [
        camelCaseField,
        pascalCaseField,
        snakeCaseField,
        screamingSnakeCaseField,
        e
      ];
  @override
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query extends JsonSerializable with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  SomeObject? query;

  @override
  List<Object?> get props => [query];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input extends JsonSerializable with EquatableMixin {
  Input(
      {this.camelCaseField,
      this.pascalCaseField,
      this.snakeCaseField,
      this.screamingSnakeCaseField,
      this.e});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  final CamelCaseTypeInput? camelCaseField;

  @JsonKey(name: 'PascalCaseField')
  final PascalCaseTypeInput? pascalCaseField;

  @JsonKey(name: 'snake_case_field')
  final SnakeCaseTypeInput? snakeCaseField;

  @JsonKey(name: 'SCREAMING_SNAKE_CASE_FIELD')
  final ScreamingSnakeCaseTypeInput? screamingSnakeCaseField;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  final MyEnum? e;

  @override
  List<Object?> get props => [
        camelCaseField,
        pascalCaseField,
        snakeCaseField,
        screamingSnakeCaseField,
        e
      ];
  @override
  Map<String, dynamic> toJson() => _$InputToJson(this);
}

enum MyEnum {
  @JsonValue('camelCase')
  camelCase,
  @JsonValue('PascalCase')
  pascalCase,
  @JsonValue('snake_case')
  snakeCase,
  @JsonValue('SCREAMING_SNAKE_CASE')
  screamingSnakeCase,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({required this.filter});

  @override
  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final Input filter;

  @override
  List<Object?> get props => [filter];
  @override
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}

final SOME_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'some_query'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'filter')),
            type:
                NamedTypeNode(name: NameNode(value: 'Input'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'query'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'filter'),
                  value: VariableNode(name: NameNode(value: 'filter')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'camelCaseField'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'PascalCaseField'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'snake_case_field'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'SCREAMING_SNAKE_CASE_FIELD'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'e'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SomeQueryQuery extends GraphQLQuery<SomeQuery$Query, SomeQueryArguments> {
  SomeQueryQuery({required this.variables});

  @override
  final DocumentNode document = SOME_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = 'some_query';

  @override
  final SomeQueryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SomeQuery$Query parse(Map<String, dynamic> json) =>
      SomeQuery$Query.fromJson(json);
}
''';
