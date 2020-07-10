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
          EnumValueDefinition(
            name: EnumValueName(name: r'value1'),
          ),
          EnumValueDefinition(
            name: EnumValueName(name: r'value2'),
          ),
          EnumValueDefinition(
            name: EnumValueName(name: r'ARTEMIS_UNKNOWN'),
          ),
        ]),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryRoot$_SomeObject'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'SomeQuery$_QueryRoot'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'SomeQuery$_QueryRoot$_SomeObject'),
                  name: ClassPropertyName(name: r'o'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'ComplexInput'),
            properties: [
              ClassProperty(
                  type: TypeName(name: r'String'),
                  name: ClassPropertyName(name: r's'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'MyEnum'),
                  name: ClassPropertyName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'List<String>'),
                  name: ClassPropertyName(name: r'ls'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: TypeName(name: r'List<List<int>>'),
                  name: ClassPropertyName(name: r'i'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: TypeName(name: r'__typename'),
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: TypeName(name: r'ComplexInput'),
            name: QueryInputName(name: r'filter'),
            isNonNull: true)
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryRoot$SomeObject with EquatableMixin {
  SomeQuery$QueryRoot$SomeObject();

  factory SomeQuery$QueryRoot$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRoot$SomeObjectFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRoot$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryRoot with EquatableMixin {
  SomeQuery$QueryRoot();

  factory SomeQuery$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRootFromJson(json);

  SomeQuery$QueryRoot$SomeObject o;

  @override
  List<Object> get props => [o];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ComplexInput with EquatableMixin {
  ComplexInput({@required this.s, this.e, this.ls, this.i});

  factory ComplexInput.fromJson(Map<String, dynamic> json) =>
      _$ComplexInputFromJson(json);

  String s;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  List<String> ls;

  List<List<int>> i;

  @override
  List<Object> get props => [s, e, ls, i];
  Map<String, dynamic> toJson() => _$ComplexInputToJson(this);
}

enum MyEnum {
  @JsonValue("value1")
  value1,
  @JsonValue("value2")
  value2,
  @JsonValue("ARTEMIS_UNKNOWN")
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({@required this.filter});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final ComplexInput filter;

  @override
  List<Object> get props => [filter];
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}

class SomeQueryQuery
    extends GraphQLQuery<SomeQuery$QueryRoot, SomeQueryArguments> {
  SomeQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
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

  @override
  final String operationName = 'some_query';

  @override
  final SomeQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  SomeQuery$QueryRoot parse(Map<String, dynamic> json) =>
      SomeQuery$QueryRoot.fromJson(json);
}
''';
