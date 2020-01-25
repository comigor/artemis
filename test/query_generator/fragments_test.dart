import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:gql/language.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On fragments', () {
    test('Fragments will have their own classes', () async {
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
                parseString(
                    'fragment myFragment on SomeObject { s, i }\nquery some_query { ...myFragment }'),
                classes: [
                  FragmentClassDefinition('MyFragmentMixin', [
                    ClassProperty('String', 's'),
                    ClassProperty('int', 'i'),
                  ]),
                  ClassDefinition('SomeObject', [],
                      mixins: ['MyFragmentMixin']),
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
          'a|some_query.query.graphql':
              'fragment myFragment on SomeObject { s, i }\nquery some_query { ...myFragment }',
        },
        outputs: {
          'a|lib/some_query.dart': r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'some_query.g.dart';

mixin MyFragmentMixin {
  String s;
  int i;
}

@JsonSerializable(explicitToJson: true)
class SomeObject with EquatableMixin, MyFragmentMixin {
  SomeObject();

  factory SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeObjectFromJson(json);

  @override
  List<Object> get props => [s, i];
  Map<String, dynamic> toJson() => _$SomeObjectToJson(this);
}
''',
        },
        onLog: debug,
      );
    });
  });
}
