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
  group('On prefixes', () {
    test(
        'If addQueryPrefix is true, all generated classes will have queryName as prefix',
        () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
            'add_query_prefix': true,
          }
        ]
      }));
      final GraphQLSchema schema = GraphQLSchema(
          queryType: GraphQLType(name: 'Query', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'MyEnum',
                kind: GraphQLTypeKind.ENUM,
                enumValues: [
                  GraphQLEnumValue(name: 'value1'),
                  GraphQLEnumValue(name: 'value2'),
                ]),
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
                  name: 'e',
                  type:
                      GraphQLType(name: 'MyEnum', kind: GraphQLTypeKind.ENUM)),
            ]),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                interfaces: [
                  GraphQLType(
                      name: 'AInterface', kind: GraphQLTypeKind.INTERFACE),
                ],
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
                name: 'AInterface',
                kind: GraphQLTypeKind.INTERFACE,
                fields: [
                  GraphQLField(
                      name: 'st',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ],
                possibleTypes: [
                  GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT)
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
          e
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
                parseString(document),
                classes: [
                  ClassDefinition(
                      'SomeQuerySomeObject',
                      [
                        ClassProperty('String', 'st', isOverride: true),
                        ClassProperty('List<SomeQueryAnotherObject>', 'ob'),
                        ClassProperty('String', 'resolveType',
                            annotation: 'JsonKey(name: \'__resolveType\')',
                            isOverride: true)
                      ],
                      implementations: ['SomeQueryAInterface'],
                      prefix: 'SomeQuery'),
                  ClassDefinition('SomeQueryAnotherObject',
                      [ClassProperty('String', 'str')],
                      prefix: 'SomeQuery'),
                  ClassDefinition(
                      'SomeQueryAInterface',
                      [
                        ClassProperty('String', 'st'),
                        ClassProperty('String', 'resolveType',
                            annotation: 'JsonKey(name: \'__resolveType\')')
                      ],
                      prefix: 'SomeQuery'),
                  EnumDefinition('SomeQueryMyEnum', ['value1', 'value2']),
                  ClassDefinition(
                      'SomeQuery',
                      [
                        ClassProperty('String', 's'),
                        ClassProperty('SomeQuerySomeObject', 'o'),
                        ClassProperty('SomeQueryMyEnum', 'e')
                      ],
                      prefix: 'SomeQuery'),
                ],
              ),
            ],
          ),
        );
      }, count: 1);

      await testBuilder(anotherBuilder, {
        'a|api.schema.json': jsonFromSchema(schema),
        'a|some_query.graphql': document,
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

  String s;

  SomeQuerySomeObject o;

  SomeQueryMyEnum e;

  @override
  List<Object> get props => [s, o, e];
  Map<String, dynamic> toJson() => _\$SomeQueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuerySomeObject with EquatableMixin implements SomeQueryAInterface {
  SomeQuerySomeObject();

  factory SomeQuerySomeObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeQuerySomeObjectFromJson(json);

  @override
  String st;

  List<SomeQueryAnotherObject> ob;

  @override
  @JsonKey(name: '__resolveType')
  String resolveType;

  @override
  List<Object> get props => [st, ob, resolveType];
  Map<String, dynamic> toJson() => _\$SomeQuerySomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryAnotherObject with EquatableMixin {
  SomeQueryAnotherObject();

  factory SomeQueryAnotherObject.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryAnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _\$SomeQueryAnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQueryAInterface with EquatableMixin {
  SomeQueryAInterface();

  factory SomeQueryAInterface.fromJson(Map<String, dynamic> json) =>
      _\$SomeQueryAInterfaceFromJson(json);

  String st;

  @JsonKey(name: '__resolveType')
  String resolveType;

  @override
  List<Object> get props => [st, resolveType];
  Map<String, dynamic> toJson() => _\$SomeQueryAInterfaceToJson(this);
}

enum SomeQueryMyEnum {
  value1,
  value2,
}
''',
      });
    });
  });
}
