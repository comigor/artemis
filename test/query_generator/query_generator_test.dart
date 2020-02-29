import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On query generation', () {
    test('When not configured, nothing will be generated', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({}));

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': '',
          'a|some_query.query.graphql': 'query some_query { s, i }',
        },
        onLog: debug,
      );
    });

    test('A simple query yields simple classes', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/some_query.graphql.dart',
          }
        ]
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query.graphql', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$SomeObject',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$SomeObject',
                    properties: [
                      ClassProperty(
                          type: r'String', name: r's', isOverride: false),
                      ClassProperty(type: r'int', name: r'i', isOverride: false)
                    ],
                    typeNameField: r'__typename')
              ],
              generateHelpers: false)
        ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': r'''
          schema {
            query: SomeObject
          }
          
          type SomeObject {
            s: String
            i: Int
          }
        ''',
          'a|queries/some_query.graphql': 'query some_query { s, i }',
        },
        outputs: {
          'a|lib/some_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  String s;

  int i;

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('A simple query with list input', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/some_query.graphql.dart',
          }
        ]
      }));

      var query = r'''
        query some_query($intsNonNullable: [Int]!, $stringNullable: String) {
          someQuery(intsNonNullable: $intsNonNullable, stringNullable: $stringNullable) {
            s
            i
            list(intsNonNullable: $intsNonNullable)
          }
        }
      ''';

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query.graphql', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$Query',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$Query$SomeObject',
                    properties: [
                      ClassProperty(
                          type: r'String',
                          name: r's',
                          isOverride: false,
                          isNonNull: false,
                          isResolveType: false),
                      ClassProperty(
                          type: r'int',
                          name: r'i',
                          isOverride: false,
                          isNonNull: false,
                          isResolveType: false),
                      ClassProperty(
                          type: r'List<int>',
                          name: r'list',
                          isOverride: false,
                          isNonNull: true,
                          isResolveType: false)
                    ],
                    factoryPossibilities: {},
                    typeNameField: r'__typename',
                    isInput: false),
                ClassDefinition(
                    name: r'SomeQuery$Query',
                    properties: [
                      ClassProperty(
                          type: r'SomeQuery$Query$SomeObject',
                          name: r'someQuery',
                          isOverride: false,
                          isNonNull: false,
                          isResolveType: false)
                    ],
                    factoryPossibilities: {},
                    typeNameField: r'__typename',
                    isInput: false)
              ],
              inputs: [
                QueryInput(
                    type: r'List<int>',
                    name: r'intsNonNullable',
                    isNonNull: true),
                QueryInput(
                    type: r'String', name: r'stringNullable', isNonNull: false)
              ],
              generateHelpers: true,
              suffix: r'Query')
        ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.grqphql': r'''
            schema {
              query: Query
            }
  
            type Query {
              someQuery(intsNonNullable: [Int]!, stringNullable: String): SomeObject
            }
  
            type SomeObject {
              s: String
              i: Int
              list(intsNonNullable: [Int]!): [Int]!
            }
          ''',
          'a|queries/some_query.graphql': query
        },
        outputs: {
          'a|lib/some_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$SomeObject with EquatableMixin {
  SomeQuery$Query$SomeObject();

  factory SomeQuery$Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$SomeObjectFromJson(json);

  String s;

  int i;

  List<int> list;

  @override
  List<Object> get props => [s, i, list];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  SomeQuery$Query$SomeObject someQuery;

  @override
  List<Object> get props => [someQuery];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({@required this.intsNonNullable, this.stringNullable});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final List<int> intsNonNullable;

  final String stringNullable;

  @override
  List<Object> get props => [intsNonNullable, stringNullable];
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
  List<Object> get props => [document, operationName, variables];
  @override
  SomeQuery$Query parse(Map<String, dynamic> json) =>
      SomeQuery$Query.fromJson(json);
}
''',
        },
        onLog: debug,
      );
    });

    test('The selection from query can nest', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/some_query.graphql.dart',
          }
        ]
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query.graphql', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$Result',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$Result$SomeObject$AnotherObject',
                    properties: [
                      ClassProperty(
                          type: r'String', name: r'str', isOverride: false)
                    ],
                    typeNameField: r'__typename'),
                ClassDefinition(
                    name: r'SomeQuery$Result$SomeObject',
                    properties: [
                      ClassProperty(
                          type: r'String', name: r'st', isOverride: false),
                      ClassProperty(
                          type:
                              r'List<SomeQuery$Result$SomeObject$AnotherObject>',
                          name: r'ob',
                          isOverride: false)
                    ],
                    typeNameField: r'__typename'),
                ClassDefinition(
                    name: r'SomeQuery$Result',
                    properties: [
                      ClassProperty(
                          type: r'String', name: r's', isOverride: false),
                      ClassProperty(
                          type: r'SomeQuery$Result$SomeObject',
                          name: r'o',
                          isOverride: false)
                    ],
                    typeNameField: r'__typename')
              ],
              generateHelpers: false)
        ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      final document = '''
        query some_query {
          s
          o {
            st
            ob {
              str
            }
          }
        }
        ''';

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.grqphql': r'''
            schema {
              query: Result
            }
  
            type Result {
              s: String
              o: SomeObject
            }
  
            type SomeObject {
              st: String
              ob: [AnotherObject]
            }
            
            type AnotherObject {
              str: String
            }
          ''',
          'a|queries/some_query.graphql': document,
        },
        outputs: {
          'a|lib/some_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result$SomeObject$AnotherObject with EquatableMixin {
  SomeQuery$Result$SomeObject$AnotherObject();

  factory SomeQuery$Result$SomeObject$AnotherObject.fromJson(
          Map<String, dynamic> json) =>
      _$SomeQuery$Result$SomeObject$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() =>
      _$SomeQuery$Result$SomeObject$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result$SomeObject with EquatableMixin {
  SomeQuery$Result$SomeObject();

  factory SomeQuery$Result$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Result$SomeObjectFromJson(json);

  String st;

  List<SomeQuery$Result$SomeObject$AnotherObject> ob;

  @override
  List<Object> get props => [st, ob];
  Map<String, dynamic> toJson() => _$SomeQuery$Result$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result with EquatableMixin {
  SomeQuery$Result();

  factory SomeQuery$Result.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$ResultFromJson(json);

  String s;

  SomeQuery$Result$SomeObject o;

  @override
  List<Object> get props => [s, o];
  Map<String, dynamic> toJson() => _$SomeQuery$ResultToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('Query selections can be aliased', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/some_query.graphql.dart',
          }
        ]
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query.graphql', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$Result',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$Result',
                    properties: [
                      ClassProperty(
                          type: r'String',
                          name: r'firstName',
                          isOverride: false),
                      ClassProperty(
                          type: r'String', name: r'lastName', isOverride: false)
                    ],
                    typeNameField: r'__typename')
              ],
              generateHelpers: false)
        ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': r'''
            schema {
              query: Result
            }
  
            type Result {
              s: String
              st: String
            }
          ''',
          'a|queries/some_query.graphql': r'''
            query some_query { 
              firstName: s, 
              lastName: st 
              }
          ''',
          'a|queries/some_query.graphql':
              'query some_query { firstName: s, lastName: st }',
        },
        outputs: {
          'a|lib/some_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$Result with EquatableMixin {
  SomeQuery$Result();

  factory SomeQuery$Result.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$ResultFromJson(json);

  String firstName;

  String lastName;

  @override
  List<Object> get props => [firstName, lastName];
  Map<String, dynamic> toJson() => _$SomeQuery$ResultToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('Imports from the scalar mapping are included', () async {
      final builderOptions = BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/some_query.graphql.dart',
          },
        ],
        'scalar_mapping': [
          {
            'graphql_type': 'BigDecimal',
            'dart_type': {
              'name': 'Decimal',
              'imports': ['package:decimal/decimal.dart'],
            },
          },
          {
            'graphql_type': 'DateTime',
            'dart_type': 'DateTime',
          },
        ],
      });

      final anotherBuilder = graphQLQueryBuilder(builderOptions);

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query.graphql', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$SomeObject',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$SomeObject',
                    properties: [
                      ClassProperty(
                          type: r'Decimal',
                          name: r'bigDecimal',
                          isOverride: false),
                      ClassProperty(
                          type: r'DateTime',
                          name: r'dateTime',
                          isOverride: false)
                    ],
                    typeNameField: r'__typename')
              ],
              generateHelpers: false)
        ], customImports: [
          r'package:decimal/decimal.dart'
        ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': r'''
            scalar BigDecimal
            scalar DateTime
            
            schema {
              query: SomeObject
            }

            type SomeObject {
              bigDecimal: BigDecimal
              dateTime: DateTime
            }
          ''',
          'a|queries/some_query.graphql':
              'query some_query { bigDecimal, dateTime }',
        },
        outputs: {
          'a|lib/some_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:decimal/decimal.dart';
part 'some_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery$SomeObject with EquatableMixin {
  SomeQuery$SomeObject();

  factory SomeQuery$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$SomeObjectFromJson(json);

  Decimal bigDecimal;

  DateTime dateTime;

  @override
  List<Object> get props => [bigDecimal, dateTime];
  Map<String, dynamic> toJson() => _$SomeQuery$SomeObjectToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('Query name (pascal casing)', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'queries_glob': 'queries/**.graphql',
            'output': 'lib/pascal_casing_query.graphql.dart',
          }
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition = LibraryDefinition(
            basename: r'pascal_casing_query.graphql',
            queries: [
              QueryDefinition(
                  queryName: r'PascalCasingQuery',
                  queryType: r'PascalCasingQuery$PascalCasingQuery',
                  classes: [
                    ClassDefinition(
                        name: r'PascalCasingQuery$PascalCasingQuery',
                        properties: [
                          ClassProperty(
                              type: r'String', name: r's', isOverride: false)
                        ],
                        typeNameField: r'__typename')
                  ],
                  generateHelpers: false)
            ]);
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.graphql': r'''
            schema {
              query: PascalCasingQuery
            }

            type PascalCasingQuery {
              s: String
            }
          ''',
          'a|queries/pascal_casing_query.graphql':
              'query PascalCasingQuery { s }',
        },
        outputs: {
          'a|lib/pascal_casing_query.graphql.dart':
              r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'pascal_casing_query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class PascalCasingQuery$PascalCasingQuery with EquatableMixin {
  PascalCasingQuery$PascalCasingQuery();

  factory PascalCasingQuery$PascalCasingQuery.fromJson(
          Map<String, dynamic> json) =>
      _$PascalCasingQuery$PascalCasingQueryFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() =>
      _$PascalCasingQuery$PascalCasingQueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });
  });
}
