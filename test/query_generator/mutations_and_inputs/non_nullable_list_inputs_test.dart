import 'package:artemis/generator/data/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On query generation', () {
    test(
        'Non-nullability on inputs (considering lists)',
        () async => testGenerator(
            query: r'''
        query some_query($i: Int, $inn: Int!, $li: [Int], $linn: [Int!], $lnni: [Int]!, $lnninn: [Int!]!, $matrix: [[Int]], $matrixnn: [[Int!]!]!) {
          someQuery(i: $i, inn: $inn, li: $li, linn: $linn, lnni: $lnni, lnninn: $lnninn, matrix: $matrix, matrixnn: $matrixnn) {
            s
          }
        }
      ''',
            schema: r'''
        type Query {
          someQuery(i: Int, inn: Int!, li: [Int], linn: [Int!], lnni: [Int]!, lnninn: [Int!]!, matrix: [[Int]], matrixnn: [[Int!]!]!): SomeObject
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
                              type: DartTypeName(name: r'String'),
                              name: ClassPropertyName(name: r's'),
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
                              isResolveType: false)
                        ],
                        factoryPossibilities: {},
                        typeNameField: ClassPropertyName(name: r'__typename'),
                        isInput: false)
                  ],
                  inputs: [
                    QueryInput(
                        type: DartTypeName(name: r'int'),
                        name: QueryInputName(name: r'i')),
                    QueryInput(
                        type: DartTypeName(name: r'int', isNonNull: true),
                        name: QueryInputName(name: r'inn')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName: DartTypeName(name: r'int'),
                            isNonNull: false),
                        name: QueryInputName(name: r'li')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName:
                                DartTypeName(name: r'int', isNonNull: true),
                            isNonNull: false),
                        name: QueryInputName(name: r'linn')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName: DartTypeName(name: r'int'),
                            isNonNull: true),
                        name: QueryInputName(name: r'lnni')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName:
                                DartTypeName(name: r'int', isNonNull: true),
                            isNonNull: true),
                        name: QueryInputName(name: r'lnninn')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName: ListOfTypeName(
                                typeName: DartTypeName(name: r'int'),
                                isNonNull: false),
                            isNonNull: false),
                        name: QueryInputName(name: r'matrix')),
                    QueryInput(
                        type: ListOfTypeName(
                            typeName: ListOfTypeName(
                                typeName:
                                    DartTypeName(name: r'int', isNonNull: true),
                                isNonNull: true),
                            isNonNull: true),
                        name: QueryInputName(name: r'matrixnn'))
                  ],
                  generateHelpers: true,
                  suffix: r'Query')
            ]),
            generatedFile: r'''// GENERATED CODE - DO NOT MODIFY BY HAND

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

  @override
  List<Object?> get props => [s];
  @override
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
  @override
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({
    this.i,
    required this.inn,
    this.li,
    this.linn,
    required this.lnni,
    required this.lnninn,
    this.matrix,
    required this.matrixnn,
  });

  @override
  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final int? i;

  late int inn;

  final List<int?>? li;

  final List<int>? linn;

  late List<int?> lnni;

  late List<int> lnninn;

  final List<List<int?>?>? matrix;

  late List<List<int>> matrixnn;

  @override
  List<Object?> get props => [i, inn, li, linn, lnni, lnninn, matrix, matrixnn];
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
        variable: VariableNode(name: NameNode(value: 'i')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'inn')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'li')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'Int'),
            isNonNull: false,
          ),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'linn')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'Int'),
            isNonNull: true,
          ),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'lnni')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'Int'),
            isNonNull: false,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'lnninn')),
        type: ListTypeNode(
          type: NamedTypeNode(
            name: NameNode(value: 'Int'),
            isNonNull: true,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'matrix')),
        type: ListTypeNode(
          type: ListTypeNode(
            type: NamedTypeNode(
              name: NameNode(value: 'Int'),
              isNonNull: false,
            ),
            isNonNull: false,
          ),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'matrixnn')),
        type: ListTypeNode(
          type: ListTypeNode(
            type: NamedTypeNode(
              name: NameNode(value: 'Int'),
              isNonNull: true,
            ),
            isNonNull: true,
          ),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'someQuery'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'i'),
            value: VariableNode(name: NameNode(value: 'i')),
          ),
          ArgumentNode(
            name: NameNode(value: 'inn'),
            value: VariableNode(name: NameNode(value: 'inn')),
          ),
          ArgumentNode(
            name: NameNode(value: 'li'),
            value: VariableNode(name: NameNode(value: 'li')),
          ),
          ArgumentNode(
            name: NameNode(value: 'linn'),
            value: VariableNode(name: NameNode(value: 'linn')),
          ),
          ArgumentNode(
            name: NameNode(value: 'lnni'),
            value: VariableNode(name: NameNode(value: 'lnni')),
          ),
          ArgumentNode(
            name: NameNode(value: 'lnninn'),
            value: VariableNode(name: NameNode(value: 'lnninn')),
          ),
          ArgumentNode(
            name: NameNode(value: 'matrix'),
            value: VariableNode(name: NameNode(value: 'matrix')),
          ),
          ArgumentNode(
            name: NameNode(value: 'matrixnn'),
            value: VariableNode(name: NameNode(value: 'matrixnn')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 's'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          )
        ]),
      )
    ]),
  )
]);

class SomeQueryQuery extends GraphQLQuery<SomeQuery$Query, SomeQueryArguments> {
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
  SomeQuery$Query parse(Map<String, dynamic> json) =>
      SomeQuery$Query.fromJson(json);
}
''',
            generateHelpers: true));
  });
}
