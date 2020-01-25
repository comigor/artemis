import 'dart:convert';

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void main() {
  group('On union types', () {
    test('On union types', () async {
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
            GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
              name: 'SomeObject',
              kind: GraphQLTypeKind.OBJECT,
              fields: [
                GraphQLField(
                    name: 'o',
                    type: GraphQLType(
                        name: 'SomeUnion', kind: GraphQLTypeKind.UNION)),
              ],
            ),
            GraphQLType(
              name: 'TypeA',
              kind: GraphQLTypeKind.OBJECT,
              fields: [
                GraphQLField(
                    name: 'a',
                    type:
                        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
              ],
            ),
            GraphQLType(
              name: 'TypeB',
              kind: GraphQLTypeKind.OBJECT,
              fields: [
                GraphQLField(
                    name: 'b',
                    type:
                        GraphQLType(name: 'Int', kind: GraphQLTypeKind.SCALAR)),
              ],
            ),
            GraphQLType(
              name: 'SomeUnion',
              kind: GraphQLTypeKind.UNION,
              possibleTypes: [
                GraphQLType(name: 'TypeA', kind: GraphQLTypeKind.OBJECT),
                GraphQLType(name: 'TypeB', kind: GraphQLTypeKind.OBJECT),
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
                parseString(
                    'query some_query { o { __typename, ... on TypeA { a }, ... on TypeB { b } } }'),
                classes: [
                  ClassDefinition('SomeQuery', [
                    ClassProperty('SomeUnion', 'o'),
                  ]),
                  ClassDefinition('SomeUnion', [
                    ClassProperty('String', 'resolveType',
                        isOverride: true,
                        annotation: 'JsonKey(name: \'__resolveType\')'),
                  ], factoryPossibilities: [
                    'TypeA',
                    'TypeB'
                  ]),
                  ClassDefinition('TypeA', [ClassProperty('int', 'a')],
                      extension: 'SomeUnion'),
                  ClassDefinition('TypeB', [ClassProperty('int', 'b')],
                      extension: 'SomeUnion'),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.query.graphql':
            'query some_query { o { __typename, ... on TypeA { a }, ... on TypeB { b } } }',
      }, outputs: {
        'a|lib/some_query.dart': '''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

@JsonSerializable(explicitToJson: true)
class SomeQuery with EquatableMixin {
  SomeQuery();

  factory SomeQuery.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryFromJson(json);

  SomeUnion o;

  @override
  List<Object> get props => [o];
  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeUnion with EquatableMixin {
  SomeUnion();

  factory SomeUnion.fromJson(Map<String, dynamic> json) {
    switch (json['__resolveType'].toString()) {
      case 'TypeA':
        return TypeA.fromJson(json);
      case 'TypeB':
        return TypeB.fromJson(json);
      default:
    }
    return _\$SomeUnionFromJson(json);
  }

  @override
  @JsonKey(name: '__resolveType')
  String resolveType;

  @override
  List<Object> get props => [resolveType];
  Map<String, dynamic> toJson() {
    switch (resolveType) {
      case 'TypeA':
        return (this as TypeA).toJson();
      case 'TypeB':
        return (this as TypeB).toJson();
      default:
    }
    return _\$SomeUnionToJson(this);
  }
}

@JsonSerializable(explicitToJson: true)
class TypeA extends SomeUnion with EquatableMixin {
  TypeA();

  factory TypeA.fromJson(Map<String, dynamic> json) => _\$TypeAFromJson(json);

  int a;

  @override
  List<Object> get props => [a];
  Map<String, dynamic> toJson() => _\$TypeAToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TypeB extends SomeUnion with EquatableMixin {
  TypeB();

  factory TypeB.fromJson(Map<String, dynamic> json) => _\$TypeBFromJson(json);

  int b;

  @override
  List<Object> get props => [b];
  Map<String, dynamic> toJson() => _\$TypeBToJson(this);
}
''',
      });
    });
  });
}
