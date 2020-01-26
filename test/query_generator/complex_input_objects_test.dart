import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On complex input objects', () {
    testGenerator(
      description: 'On complex input objects',
      query:
          r'query some_query($filter: ComplexType!) { o(filter: $filter) { s } }',
      libraryDefinition: libraryDefinition,
      generatedFile: generatedFile,
      typedSchema: schema,
    );
  });
}

final schema = GraphQLSchema(
  queryType: GraphQLType(name: 'QueryRoot', kind: GraphQLTypeKind.OBJECT),
  types: [
    GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
    GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM, enumValues: [
      GraphQLEnumValue(name: 'value1'),
      GraphQLEnumValue(name: 'value2'),
    ]),
    GraphQLType(
        name: 'ComplexType',
        kind: GraphQLTypeKind.INPUT_OBJECT,
        inputFields: [
          GraphQLInputValue(
              name: 's',
              type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
          GraphQLInputValue(
              name: 'e',
              type: GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM)),
          GraphQLInputValue(
              name: 'ls',
              type: GraphQLType(
                  kind: GraphQLTypeKind.LIST,
                  ofType: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR))),
        ]),
    GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT, fields: [
      GraphQLField(
          name: 's',
          type: GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR)),
    ]),
    GraphQLType(name: 'QueryRoot', kind: GraphQLTypeKind.OBJECT, fields: [
      GraphQLField(
          name: 'o',
          type: GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
    ]),
  ],
);

final libraryDefinition = LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$QueryRoot',
      classes: [
        ClassDefinition(
            name: r'SomeQuery$QueryRoot$SomeObject',
            properties: [
              ClassProperty(type: r'String', name: r's', isOverride: false)
            ],
            typeNameField: r'__typename'),
        ClassDefinition(
            name: r'SomeQuery$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'SomeQuery$QueryRoot$SomeObject',
                  name: r'o',
                  isOverride: false)
            ],
            typeNameField: r'__typename'),
        EnumDefinition(name: r'MyEnum', values: [r'value1', r'value2']),
        ClassDefinition(
            name: r'ComplexType',
            properties: [
              ClassProperty(type: r'String', name: r's', isOverride: false),
              ClassProperty(type: r'MyEnum', name: r'e', isOverride: false),
              ClassProperty(
                  type: r'List<String>', name: r'ls', isOverride: false)
            ],
            typeNameField: r'__typename')
      ],
      inputs: [QueryInput(type: r'ComplexType', name: r'filter')],
      generateHelpers: false)
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

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
class ComplexType with EquatableMixin {
  ComplexType();

  factory ComplexType.fromJson(Map<String, dynamic> json) =>
      _$ComplexTypeFromJson(json);

  String s;

  MyEnum e;

  List<String> ls;

  @override
  List<Object> get props => [s, e, ls];
  Map<String, dynamic> toJson() => _$ComplexTypeToJson(this);
}

enum MyEnum {
  value1,
  value2,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({this.filter});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final ComplexType filter;

  @override
  List<Object> get props => [filter];
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}
''';
