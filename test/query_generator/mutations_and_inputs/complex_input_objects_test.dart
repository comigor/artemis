import 'package:artemis/generator/data/data.dart';
import 'package:artemis/generator/data/enum_value_definition.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On complex input objects', () {
    test(
      'On complex input objects',
      () async => testGenerator(
        query: r'''
          query some_query($filter: ComplexInput!) {
            o(filter: $filter) {
              s
            }
          }''',
        schema: r'''
          schema {
            query: QueryRoot
          }

          type QueryRoot {
            o(filter: ComplexInput!): SomeObject
          }

          input ComplexInput {
            s: String!
            e: MyEnum
            ls: [String]
            i: [[Int]]
          }

          type SomeObject {
            s: String
          }

          enum MyEnum {
            value1
            value2
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      name: QueryName(name: r'SomeQuery$_QueryRoot'),
      operationName: r'some_query',
      classes: [
        EnumDefinition(name: EnumName(name: r'MyEnum'), values: [
          EnumValueDefinition(name: EnumValueName(name: r'value1')),
          EnumValueDefinition(name: EnumValueName(name: r'value2')),
          EnumValueDefinition(name: EnumValueName(name: r'ARTEMIS_UNKNOWN'))
        ]),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryRoot$_SomeObject'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$_QueryRoot$_SomeObject'),
                  name: ClassPropertyName(name: r'o'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ComplexInput'),
            properties: [
              ClassProperty(
                  type: DartTypeName(name: r'String', isNonNull: true),
                  name: ClassPropertyName(name: r's'),
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: DartTypeName(name: r'String'),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'ls'),
                  isResolveType: false),
              ClassProperty(
                  type: ListOfTypeName(
                      typeName: ListOfTypeName(
                          typeName: DartTypeName(name: r'int'),
                          isNonNull: false),
                      isNonNull: false),
                  name: ClassPropertyName(name: r'i'),
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: ClassPropertyName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'ComplexInput', isNonNull: true),
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
class SomeQuery$QueryRoot$SomeObject extends JsonSerializable
    with EquatableMixin {
  SomeQuery$QueryRoot$SomeObject();

  factory SomeQuery$QueryRoot$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRoot$SomeObjectFromJson(json);

  String? s;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [s, $$typename];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRoot$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryRoot extends JsonSerializable with EquatableMixin {
  SomeQuery$QueryRoot();

  factory SomeQuery$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRootFromJson(json);

  SomeQuery$QueryRoot$SomeObject? o;

  @JsonKey(name: '__typename')
  String? $$typename;

  @override
  List<Object?> get props => [o, $$typename];
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ComplexInput extends JsonSerializable with EquatableMixin {
  ComplexInput({required this.s, this.e, this.ls, this.i});

  factory ComplexInput.fromJson(Map<String, dynamic> json) =>
      _$ComplexInputFromJson(json);

  late String s;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum? e;

  List<String?>? ls;

  List<List<int?>?>? i;

  @override
  List<Object?> get props => [s, e, ls, i];
  @override
  Map<String, dynamic> toJson() => _$ComplexInputToJson(this);
}

enum MyEnum {
  @JsonValue('value1')
  value1,
  @JsonValue('value2')
  value2,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({required this.filter});

  @override
  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  late ComplexInput filter;

  @override
  List<Object?> get props => [filter];
  @override
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}

final SOME_QUERY_QUERY_DOCUMENT_OPERATION_NAME = 'some_query';
final SOME_QUERY_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'some_query'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'filter')),
            type: NamedTypeNode(
                name: NameNode(value: 'ComplexInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'o'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'filter'),
                  value: VariableNode(name: NameNode(value: 'filter')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 's'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SomeQueryQuery
    extends GraphQLQuery<SomeQuery$QueryRoot, SomeQueryArguments> {
  SomeQueryQuery({required this.variables});

  @override
  final DocumentNode document = SOME_QUERY_QUERY_DOCUMENT;

  @override
  final String operationName = SOME_QUERY_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final SomeQueryArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SomeQuery$QueryRoot parse(Map<String, dynamic> json) =>
      SomeQuery$QueryRoot.fromJson(json);
}
''';
