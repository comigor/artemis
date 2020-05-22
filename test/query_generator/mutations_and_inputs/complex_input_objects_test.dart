import 'package:artemis/generator/data.dart';
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
      queryName: r'some_query',
      queryType: r'SomeQuery$QueryRoot',
      classes: [
        EnumDefinition(
            name: EnumName(name: r'MyEnum'),
            values: [r'value1', r'value2', r'artemisUnknown']),
        ClassDefinition(
            name: TempName(name: r'SomeQuery$QueryRoot$SomeObject'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r's'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'SomeQuery$QueryRoot'),
            properties: [
              ClassProperty(
                  type: r'SomeQuery$QueryRoot$SomeObject',
                  name: VariableName(name: r'o'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: TempName(name: r'ComplexInput'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r's'),
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'MyEnum',
                  name: VariableName(name: r'e'),
                  annotations: [
                    r'JsonKey(unknownEnumValue: MyEnum.artemisUnknown)'
                  ],
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<String>',
                  name: VariableName(name: r'ls'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: r'ComplexInput',
            name: VariableName(name: r'filter'),
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
  ComplexInput({@required this.s, this.e, this.ls});

  factory ComplexInput.fromJson(Map<String, dynamic> json) =>
      _$ComplexInputFromJson(json);

  String s;

  @JsonKey(unknownEnumValue: MyEnum.artemisUnknown)
  MyEnum e;

  List<String> ls;

  @override
  List<Object> get props => [s, e, ls];
  Map<String, dynamic> toJson() => _$ComplexInputToJson(this);
}

enum MyEnum {
  value1,
  value2,
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
