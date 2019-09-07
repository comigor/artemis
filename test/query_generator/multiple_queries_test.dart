import 'dart:convert';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  test('Header and part should only be included once', () async {
    final GraphQLQueryBuilder anotherBuilder =
        graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'api.schema.json',
          'queries_glob': '**.graphql',
          'output': 'lib/graphql_api.dart',
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
                    type:
                        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
              ]),
        ]);

    anotherBuilder.onBuild = expectAsync1((definition) {
      expect(
        definition,
        LibraryDefinition(
          'graphql_api',
          queries: [
            QueryDefinition(
              'SomeQuery',
              'query some_query { s, i }',
              classes: [
                ClassDefinition('SomeQuery', [
                  ClassProperty('String', 's'),
                  ClassProperty('int', 'i'),
                ]),
              ],
            ),
            QueryDefinition(
              'AnotherQuery',
              'query another_query { s }',
              classes: [
                ClassDefinition('AnotherQuery', [
                  ClassProperty('String', 's'),
                ]),
              ],
            ),
          ],
        ),
      );
    }, count: 1);

    await testBuilder(anotherBuilder, {
      'a|api.schema.json': jsonFromSchema(schema),
      'a|some_query.graphql': 'query some_query { s, i }',
      'a|another_query.graphql': 'query another_query { s }',
    }, outputs: {
      'a|lib/graphql_api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'graphql_api.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  String s;

  int i;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherQuery {
  AnotherQuery();

  factory AnotherQuery.fromJson(Map<String, dynamic> json) =>
      _\$AnotherQueryFromJson(json);

  String s;

  Map<String, dynamic> toJson() => _\$AnotherQueryToJson(this);
}
''',
    });
  });

  group('Generated objects shouldn\'t be generated twice', () {
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
                    type:
                        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
                GraphQLField(
                    name: 'obj',
                    type: GraphQLType(
                        name: 'AnotherObject', kind: GraphQLTypeKind.OBJECT)),
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

    test('By default, it will throw', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/graphql_api.dart',
          }
        ]
      }));

      expect(
          () => testBuilder(anotherBuilder, {
                'a|api.schema.json': jsonFromSchema(schema),
                'a|some_query.graphql': 'query some_query { i, obj { str } }',
                'a|another_query.graphql':
                    'query another_query { s, obj { str } }',
              }),
          throwsException);
    });

    test('If add_query_prefix is true, it will work', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/graphql_api.dart',
            'add_query_prefix': true,
          }
        ]
      }));

      anotherBuilder.onBuild = expectAsync1((definition) {
        expect(
          definition,
          LibraryDefinition(
            'graphql_api',
            queries: [
              QueryDefinition(
                'SomeQuery',
                'query some_query { i, obj { str } }',
                classes: [
                  ClassDefinition('SomeQuery', [
                    ClassProperty('int', 'i'),
                    ClassProperty('SomeQueryAnotherObject', 'obj'),
                  ]),
                  ClassDefinition('SomeQueryAnotherObject', [
                    ClassProperty('String', 'str'),
                  ]),
                ],
              ),
              QueryDefinition(
                'AnotherQuery',
                'query another_query { s, obj { str } }',
                classes: [
                  ClassDefinition('AnotherQuery', [
                    ClassProperty('String', 's'),
                    ClassProperty('AnotherQueryAnotherObject', 'obj'),
                  ]),
                  ClassDefinition('AnotherQueryAnotherObject', [
                    ClassProperty('String', 'str'),
                  ]),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.graphql': 'query some_query { i, obj { str } }',
        'a|another_query.graphql': 'query another_query { s, obj { str } }',
      }, outputs: {
        'a|lib/graphql_api.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
part 'graphql_api.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  int i;

  SomeQueryAnotherObject obj;

  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryAnotherObject {
  SomeQueryAnotherObject();

  factory SomeQueryAnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryAnotherObjectFromJson(json);

  String str;

  Map<String, dynamic> toJson() => _\$SomeQueryAnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherQuery {
  AnotherQuery();

  factory AnotherQuery.fromJson(Map<String, dynamic> json) =>
      _\$AnotherQueryFromJson(json);

  String s;

  AnotherQueryAnotherObject obj;

  Map<String, dynamic> toJson() => _\$AnotherQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AnotherQueryAnotherObject {
  AnotherQueryAnotherObject();

  factory AnotherQueryAnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherQueryAnotherObjectFromJson(json);

  String str;

  Map<String, dynamic> toJson() => _\$AnotherQueryAnotherObjectToJson(this);
}
''',
      });
    });
  });
}
