// @dart = 2.8

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On query generation', () {
    test(
        'Non-nullability on inputs (considering lists)',
        () async => testGenerator(
            query: r'''
        query some_query($i: Int, $inn: Int!, $li: [Int], $linn: [Int!], $lnni: [Int]!, $lnninn: [Int!]!) {
          someQuery(i: $i, inn: $inn, li: $li, linn: $linn, lnni: $lnni, lnninn: $lnninn) {
            s
          }
        }
      ''',
            schema: r'''
        type Query {
          someQuery(i: Int, inn: Int!, li: [Int], linn: [Int!], lnni: [Int]!, lnninn: [Int!]!): SomeObject
        }

        type SomeObject {
          s: String
        }
      ''',
            libraryDefinition:
                LibraryDefinition(basename: r'query.graphql', queries: [
              QueryDefinition(
                  name: QueryName(name: r'SomeQuery$_Query'),
                  operationName: r'some_query',
                  classes: [
                    ClassDefinition(
                        name: ClassName(name: r'SomeQuery$_Query$_SomeObject'),
                        properties: [
                          ClassProperty(
                              type: TypeName(name: r'String'),
                              name: ClassPropertyName(name: r's'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false),
                    ClassDefinition(
                        name: ClassName(name: r'SomeQuery$_Query'),
                        properties: [
                          ClassProperty(
                              type: TypeName(
                                  name: r'SomeQuery$_Query$_SomeObject'),
                              name: ClassPropertyName(name: r'someQuery'),
                              isNonNull: false,
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  inputs: [
                    QueryInput(
                        type: TypeName(name: r'int'),
                        name: QueryInputName(name: r'i'),
                        isNonNull: false),
                    QueryInput(
                        type: TypeName(name: r'int'),
                        name: QueryInputName(name: r'inn'),
                        isNonNull: true),
                    QueryInput(
                        type: TypeName(name: r'List<int>'),
                        name: QueryInputName(name: r'li'),
                        isNonNull: false),
                    QueryInput(
                        type: TypeName(name: r'List<int>'),
                        name: QueryInputName(name: r'linn'),
                        isNonNull: false),
                    QueryInput(
                        type: TypeName(name: r'List<int>'),
                        name: QueryInputName(name: r'lnni'),
                        isNonNull: true),
                    QueryInput(
                        type: TypeName(name: r'List<int>'),
                        name: QueryInputName(name: r'lnninn'),
                        isNonNull: true)
                  ],
                  generateHelpers: true,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$SomeObject extends JsonSerializable with EquatableMixin {
  SomeQuery$Query$SomeObject();

  factory SomeQuery$Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$SomeObjectFromJson(json);

  String? s;

  int? i;

  List<int>? list;

  @override
  List<Object?> get props => [s, i, list];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query extends JsonSerializable with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  SomeQuery$Query$SomeObject? someQuery;

  @override
  List<Object?> get props => [someQuery];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({required this.intsNonNullable, this.stringNullable});

  @override
  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final List<int?> intsNonNullable;

  final String? stringNullable;

  @override
  List<Object?> get props => [intsNonNullable, stringNullable];
  @override
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}

class SomeQueryQuery extends GraphQLQuery<SomeQuery$Query, SomeQueryArguments> {
  SomeQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'some_query'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'intsNonNullable')),
              type: ListTypeNode(
                  type: NamedTypeNode(
                      name: NameNode(value: 'Int'), isNonNull: false),
                  isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'stringNullable')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: false),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'someQuery'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'intsNonNullable'),
                    value:
                        VariableNode(name: NameNode(value: 'intsNonNullable'))),
                ArgumentNode(
                    name: NameNode(value: 'stringNullable'),
                    value:
                        VariableNode(name: NameNode(value: 'stringNullable')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 's'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'i'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'list'),
                    alias: null,
                    arguments: [
                      ArgumentNode(
                          name: NameNode(value: 'intsNonNullable'),
                          value: VariableNode(
                              name: NameNode(value: 'intsNonNullable')))
                    ],
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
  List<Object?> get props => [document, operationName, variables];
  @override
  SomeQuery$Query parse(Map<String, dynamic> json) =>
      SomeQuery$Query.fromJson(json);
}
''',
            generateHelpers: true));
  });
}
