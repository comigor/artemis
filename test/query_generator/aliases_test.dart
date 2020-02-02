import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On aliases', () {
    test(
        "When multiple fields use different versions of an object, aliasing them means we'll alias class name as well",
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
        final libraryDefinition =
            LibraryDefinition(basename: r'some_query', queries: [
          QueryDefinition(
              queryName: r'some_query',
              queryType: r'SomeQuery$Query',
              classes: [
                ClassDefinition(
                    name: r'SomeQuery$Query$SomeObject',
                    properties: [
                      ClassProperty(
                          type: r'String',
                          name: r'st',
                          isOverride: false,
                          isNonNull: false)
                    ],
                    factoryPossibilities: {},
                    typeNameField: r'__typename',
                    isInput: false),
                ClassDefinition(
                    name: r'SomeQuery$Query$AnotherObject',
                    properties: [
                      ClassProperty(
                          type: r'String',
                          name: r'str',
                          isOverride: false,
                          isNonNull: false)
                    ],
                    factoryPossibilities: {},
                    typeNameField: r'__typename',
                    isInput: false),
                ClassDefinition(
                    name: r'SomeQuery$Query',
                    properties: [
                      ClassProperty(
                          type: r'String',
                          name: r's',
                          isOverride: false,
                          isNonNull: false),
                      ClassProperty(
                          type: r'SomeQuery$Query$SomeObject',
                          name: r'o',
                          isOverride: false,
                          isNonNull: false),
                      ClassProperty(
                          type: r'List<SomeQuery$Query$AnotherObject>',
                          name: r'anotherObject',
                          isOverride: false,
                          isNonNull: false)
                    ],
                    factoryPossibilities: {},
                    typeNameField: r'__typename',
                    isInput: false)
              ],
              generateHelpers: false,
              suffix: r'Query')
        ]);
        expect(definition, libraryDefinition);
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
class SomeQuery$Query$SomeObject with EquatableMixin {
  SomeQuery$Query$SomeObject();

  factory SomeQuery$Query$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$SomeObjectFromJson(json);

  String st;

  @override
  List<Object> get props => [st];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query$AnotherObject with EquatableMixin {
  SomeQuery$Query$AnotherObject();

  factory SomeQuery$Query$AnotherObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$Query$AnotherObjectFromJson(json);

  String str;

  @override
  List<Object> get props => [str];
  Map<String, dynamic> toJson() => _$SomeQuery$Query$AnotherObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$Query with EquatableMixin {
  SomeQuery$Query();

  factory SomeQuery$Query.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryFromJson(json);

  String s;

  SomeQuery$Query$SomeObject o;

  List<SomeQuery$Query$AnotherObject> anotherObject;

  @override
  List<Object> get props => [s, o, anotherObject];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryToJson(this);
}
''',
        },
        onLog: debug,
      );
    });
  });
}
