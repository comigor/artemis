import 'dart:convert';

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:gql/language.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void debug(LogRecord log) {
  const IS_DEBUG = false;
  if (IS_DEBUG) print(log);
}

void main() {
  group('On query generation', () {
    test('When not configured, nothing will be generated', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({}));
      final GraphQLSchema schema = GraphQLSchema(
          queryType:
              GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 's',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'i',
                      type: GraphQLType(
                          name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.query.graphql': 'query some_query { s, i }',
        },
        onLog: debug,
      );
    });

    test('A simple query yields simple classes', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType:
              GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 's',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'i',
                      type: GraphQLType(
                          name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'SomeObject',
                parseString('query some_query { s, i }'),
                classes: [
                  ClassDefinition('SomeObject', [
                    ClassProperty('String', 's'),
                    ClassProperty('int', 'i'),
                  ])
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.query.graphql': 'query some_query { s, i }',
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  String s;

  int i;

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('A simple query with list input', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType:
              GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'List',
                kind: GraphQLTypeKind.LIST,
                ofType: GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 's',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'i',
                      type: GraphQLType(
                          name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'list',
                      type: GraphQLType(
                          name: 'List',
                          kind: GraphQLTypeKind.LIST,
                          ofType: GraphQLType(
                              name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                      args: [
                        GraphQLInputValue(
                          name: 'ints',
                          defaultValue: null,
                          type: GraphQLType(
                              name: 'List',
                              kind: GraphQLTypeKind.LIST,
                              ofType: GraphQLType(
                                  name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                        )
                      ]),
                ]),
          ]);

      anotherBuilder.onBuild = expectAsync1((definition) {
        final libraryDefinition = LibraryDefinition(
          'some_query',
          queries: [
            QueryDefinition(
              'some_query',
              'SomeObject',
              parseString(
                  r'query some_query($ints: [Int]!) { s, i, list(ints: $ints) }'),
              inputs: [QueryInput('List<int>', 'ints')],
              classes: [
                ClassDefinition('SomeObject', [
                  ClassProperty('String', 's'),
                  ClassProperty('int', 'i'),
                  ClassProperty('List<int>', 'list')
                ])
              ],
            ),
          ],
        );
        expect(definition, libraryDefinition);
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.query.graphql':
              'query some_query(\$ints: [Int]!) { s, i, list(ints: \$ints) }',
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  String s;

  int i;

  List<int> list;

  @override
  List<Object> get props => [s, i, list];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({this.ints});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final List<int> ints;

  @override
  List<Object> get props => [ints];
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('The selection from query can nest', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
              GraphQLField(
                  name: 's',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
              GraphQLField(
                  name: 'o',
                  type: GraphQLType(
                      name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
            ]),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 'st',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'ob',
                      type: GraphQLType(
                          kind: GraphQLTypeKind.LIST,
                          ofType: GraphQLType(
                              name: 'AnotherObject',
                              kind: GraphQLTypeKind.OBJECT))),
                ]),
            GraphQLType(
                name: 'AnotherObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 'str',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

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

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'Query',
                parseString(document),
                classes: [
                  ClassDefinition('Query\$SomeObject\$AnotherObject', [
                    ClassProperty('String', 'str'),
                  ]),
                  ClassDefinition('Query\$SomeObject', [
                    ClassProperty('String', 'st'),
                    ClassProperty(
                        'List<Query\$SomeObject\$AnotherObject>', 'ob'),
                  ]),
                  ClassDefinition('Query', [
                    ClassProperty('String', 's'),
                    ClassProperty('Query\$SomeObject', 'o'),
                  ]),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.graphql': document,
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject$AnotherObject with EquatableMixin {
  Query$SomeObject$AnotherObject();

  factory Query$SomeObject$AnotherObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObject$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _$Query$SomeObject$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  String st;

  List<Query$SomeObject$AnotherObject> ob;

  @override
  List<Object> get props => [st, ob];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query with EquatableMixin {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  String s;

  Query$SomeObject o;

  @override
  List<Object> get props => [s, o];
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('Query selections can be aliased', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
              GraphQLField(
                  name: 's',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
              GraphQLField(
                  name: 'st',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
            ]),
          ]);

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'Query',
                parseString('query some_query { firstName: s, lastName: st }'),
                classes: [
                  ClassDefinition('Query', [
                    ClassProperty('String', 'firstName'),
                    ClassProperty('String', 'lastName'),
                  ]),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.graphql':
              'query some_query { firstName: s, lastName: st }',
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query with EquatableMixin {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  String firstName;

  String lastName;

  @override
  List<Object> get props => [firstName, lastName];
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test(
        'When multiple fields use different versions of an object, aliasing them means we\'ll alias class name as well',
        () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
              GraphQLField(
                  name: 's',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
              GraphQLField(
                  name: 'o',
                  type: GraphQLType(
                      name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
              GraphQLField(
                  name: 'ob',
                  type: GraphQLType(
                      kind: GraphQLTypeKind.LIST,
                      ofType: GraphQLType(
                          name: 'SomeObject', kind: GraphQLTypeKind.OBJECT))),
            ]),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 'st',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'str',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      final document = '''
        query some_query {
          s
          o {
            st
          }
          anotherObject: ob {
            str
          }
        }
        ''';

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'Query',
                parseString(document),
                classes: [
                  ClassDefinition('Query\$SomeObject', [
                    ClassProperty('String', 'st'),
                  ]),
                  ClassDefinition('Query\$AnotherObject', [
                    ClassProperty('String', 'str'),
                  ]),
                  ClassDefinition('Query', [
                    ClassProperty('String', 's'),
                    ClassProperty('Query\$SomeObject', 'o'),
                    ClassProperty(
                        'List<Query\$AnotherObject>', 'anotherObject'),
                  ]),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.graphql': document,
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  String st;

  @override
  List<Object> get props => [st];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$AnotherObject with EquatableMixin {
  Query$AnotherObject();

  factory Query$AnotherObject.fromJson(Map<String, dynamic> json) =>
      _$Query$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _$Query$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query with EquatableMixin {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  String s;

  Query$SomeObject o;

  List<Query$AnotherObject> anotherObject;

  @override
  List<Object> get props => [s, o, anotherObject];
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('On helpers generation', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT, fields: [
              GraphQLField(
                  name: 's',
                  type: GraphQLType(
                      name: 'String', kind: GraphQLTypeKind.SCALAR)),
              GraphQLField(
                  name: 'o',
                  type: GraphQLType(
                      name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)),
              GraphQLField(
                  name: 'ob',
                  type: GraphQLType(
                      kind: GraphQLTypeKind.LIST,
                      ofType: GraphQLType(
                          name: 'SomeObject', kind: GraphQLTypeKind.OBJECT))),
            ]),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 'st',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                  GraphQLField(
                      name: 'str',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      final document = '''
        query some_query {
          s
          o {
            st
          }
          anotherObject: ob {
            str
          }
        }
        ''';

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'Query',
                parseString(document),
                classes: [
                  ClassDefinition('Query\$SomeObject', [
                    ClassProperty('String', 'st'),
                  ]),
                  ClassDefinition('Query\$AnotherObject', [
                    ClassProperty('String', 'str'),
                  ]),
                  ClassDefinition('Query', [
                    ClassProperty('String', 's'),
                    ClassProperty('Query\$SomeObject', 'o'),
                    ClassProperty(
                        'List<Query\$AnotherObject>', 'anotherObject'),
                  ]),
                ],
                generateHelpers: true,
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.graphql': document,
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class Query$SomeObject with EquatableMixin {
  Query$SomeObject();

  factory Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$Query$SomeObjectFromJson(json);

  String st;

  @override
  List<Object> get props => [st];
  Map<String, dynamic> toJson() => _$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query$AnotherObject with EquatableMixin {
  Query$AnotherObject();

  factory Query$AnotherObject.fromJson(Map<String, dynamic> json) =>
      _$Query$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _$Query$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Query with EquatableMixin {
  Query();

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  String s;

  Query$SomeObject o;

  List<Query$AnotherObject> anotherObject;

  @override
  List<Object> get props => [s, o, anotherObject];
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}

class SomeQueryQuery extends GraphQLQuery<Query, JsonSerializable> {
  SomeQueryQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'some_query'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 's'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null),
          FieldNode(
              name: NameNode(value: 'o'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'st'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ])),
          FieldNode(
              name: NameNode(value: 'ob'),
              alias: NameNode(value: 'anotherObject'),
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'str'),
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
  List<Object> get props => [document, operationName];
  @override
  SomeQuery parse(Map<String, dynamic> json) => SomeQuery.fromJson(json);
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
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
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

      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(builderOptions);

      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(
            name: 'SomeObject',
            kind: GraphQLTypeKind.OBJECT,
          ),
          types: [
            GraphQLType(
              name: 'BigDecimal',
              kind: GraphQLTypeKind.SCALAR,
            ),
            GraphQLType(
              name: 'DateTime',
              kind: GraphQLTypeKind.SCALAR,
            ),
            GraphQLType(
              name: 'SomeObject',
              kind: GraphQLTypeKind.OBJECT,
              fields: [
                GraphQLField(
                  name: 'bigDecimal',
                  type: GraphQLType(
                    name: 'BigDecimal',
                    kind: GraphQLTypeKind.SCALAR,
                  ),
                ),
                GraphQLField(
                  name: 'dateTime',
                  type: GraphQLType(
                    name: 'DateTime',
                    kind: GraphQLTypeKind.SCALAR,
                  ),
                ),
              ],
            ),
          ]);

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'some_query',
            queries: [
              QueryDefinition(
                'some_query',
                'SomeObject',
                parseString('query some_query { bigDecimal, dateTime }'),
                classes: [
                  ClassDefinition('SomeObject', [
                    ClassProperty('Decimal', 'bigDecimal'),
                    ClassProperty('DateTime', 'dateTime'),
                  ])
                ],
              ),
            ],
            customImports: [
              'package:decimal/decimal.dart',
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|some_query.graphql': 'query some_query { bigDecimal, dateTime }',
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:decimal/decimal.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  Decimal bigDecimal;

  DateTime dateTime;

  @override
  List<Object> get props => [bigDecimal, dateTime];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}
''',
        },
        onLog: debug,
      );
    });

    test('Query name (pascal casing)', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/pascal_casing_query.dart',
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(
              name: 'PascalCasingQuery', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'PascalCasingQuery',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 's',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'pascal_casing_query',
            queries: [
              QueryDefinition(
                'PascalCasingQuery',
                'PascalCasingQuery',
                parseString('query PascalCasingQuery { s }'),
                classes: [
                  ClassDefinition('PascalCasingQuery', [
                    ClassProperty('String', 's'),
                  ])
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(
        anotherBuilder,
        {
          'a|api.schema.json': jsonFromSchema(schema),
          'a|pascal_casing_query.query.graphql':
              'query PascalCasingQuery { s }',
        },
        outputs: {
          'a|lib/pascal_casing_query.dart':
              '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'pascal_casing_query.g.dart';

@JsonSerializable(explicitToJson: true)
class PascalCasingQuery with EquatableMixin {
  PascalCasingQuery();

  factory PascalCasingQuery.fromJson(Map<String, dynamic> json) =>
      _\$PascalCasingQueryFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _\$PascalCasingQueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });
  });
}
