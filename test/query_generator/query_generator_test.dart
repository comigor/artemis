import 'dart:convert';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:artemis/schema/graphql.dart';
import 'package:artemis/generator.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On query generation', () {
    test('A simple query yields simple classes', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
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

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': 'query some_query { s, i }',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'some_query.query.g.dart';

@JsonSerializable()
class SomeQuery {
  String s;
  int i;

  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}
''',
      });
    });

    test('The selection from query can nest', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
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

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql': '''
        query some_query {
          s
          o {
            st
            ob {
              str
            }
          }
        }
        ''',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'some_query.query.g.dart';

@JsonSerializable()
class SomeQuery {
  String s;
  SomeObject o;

  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable()
class SomeObject {
  String st;
  List<AnotherObject> ob;

  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeObjectToJson(this);
}

@JsonSerializable()
class AnotherObject {
  String str;

  AnotherObject();

  factory AnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$AnotherObjectFromJson(json);
  Map<String, dynamic> toJson() => _\$AnotherObjectToJson(this);
}
''',
      });
    });

    test('Query selections can be aliased', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
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

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql':
            'query some_query { firstName: s, lastName: st }',
      }, outputs: {
        'a|some_query.query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'some_query.query.g.dart';

@JsonSerializable()
class SomeQuery {
  String firstName;
  String lastName;

  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);
  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}
''',
      });
    });
  });
}
