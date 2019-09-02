import 'dart:convert';

import 'package:artemis/generator/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/schema/graphql.dart';
import 'package:artemis/builder.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On query generation', () {
    test('A simple query yields simple classes', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.query.graphql',
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
          QueryDefinition(
            'SomeQuery',
            'query some_query { s, i }',
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('String', 's'),
                ClassProperty('int', 'i'),
              ])
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': 'query some_query { s, i }',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String s;

  int i;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}
''',
      });
    });

    test('The selection from query can nest', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.query.graphql',
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

      final queryString = '''
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
          QueryDefinition(
            'SomeQuery',
            queryString,
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('String', 's'),
                ClassProperty('SomeObject', 'o'),
              ]),
              ClassDefinition('SomeObject', [
                ClassProperty('String', 'st'),
                ClassProperty('List<AnotherObject>', 'ob'),
              ]),
              ClassDefinition('AnotherObject', [
                ClassProperty('String', 'str'),
              ]),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': queryString,
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String s;

  SomeObject o;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeObject {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);

  String st;

  List<AnotherObject> ob;

  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherObject {
  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);

  String str;

  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}
''',
      });
    });

    test('Query selections can be aliased', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.query.graphql',
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
          QueryDefinition(
            'SomeQuery',
            'query some_query { firstName: s, lastName: st }',
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('String', 'firstName'),
                ClassProperty('String', 'lastName'),
              ]),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql':
            'query some_query { firstName: s, lastName: st }',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String firstName;

  String lastName;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}
''',
      });
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
            'queries_glob': '**.query.graphql',
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

      final queryString = '''
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
          QueryDefinition(
            'SomeQuery',
            queryString,
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('String', 's'),
                ClassProperty('SomeObject', 'o'),
                ClassProperty('List<AnotherObject>', 'anotherObject'),
              ]),
              ClassDefinition('SomeObject', [
                ClassProperty('String', 'st'),
              ]),
              ClassDefinition('AnotherObject', [
                ClassProperty('String', 'str'),
              ]),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': queryString,
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String s;

  SomeObject o;

  List<AnotherObject> anotherObject;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeObject {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);

  String st;

  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherObject {
  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);

  String str;

  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}
''',
      });
    });

    test('On helpers generation', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.query.graphql',
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

      final queryString = '''
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
          QueryDefinition(
            'SomeQuery',
            queryString,
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('String', 's'),
                ClassProperty('SomeObject', 'o'),
                ClassProperty('List<AnotherObject>', 'anotherObject'),
              ]),
              ClassDefinition('SomeObject', [
                ClassProperty('String', 'st'),
              ]),
              ClassDefinition('AnotherObject', [
                ClassProperty('String', 'str'),
              ]),
            ],
            generateHelpers: true,
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': queryString,
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:artemis/artemis.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String s;

  SomeObject o;

  List<AnotherObject> anotherObject;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeObject {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);

  String st;

  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherObject {
  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);

  String str;

  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}

class SomeQueryQuery extends GraphQLQuery<SomeQuery, JsonSerializable> {
  SomeQueryQuery();

  @override
  final String query =
      'query some_query { s o { st } anotherObject: ob { str } }';

  @override
  final String operationName = 'some_query';

  @override
  SomeQuery parse(Map<String, dynamic> json) => SomeQuery.fromJson(json);
}
''',
      });
    });

    test('Imports from the scalar mapping are included', () async {
      final builderOptions = BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.query.graphql',
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
          QueryDefinition(
            'SomeQuery',
            'query some_query { bigDecimal, dateTime }',
            'some_query',
            classes: [
              ClassDefinition('SomeQuery', [
                ClassProperty('Decimal', 'bigDecimal'),
                ClassProperty('DateTime', 'dateTime'),
              ])
            ],
            customImports: [
              'package:decimal/decimal.dart',
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql':
            'query some_query { bigDecimal, dateTime }',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart';
part 'some_query.query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  Decimal bigDecimal;

  DateTime dateTime;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}
''',
      });
    });
  });
}
