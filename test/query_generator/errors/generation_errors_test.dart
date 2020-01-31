import 'package:artemis/builder.dart';
import 'package:artemis/generator/graphql_helpers.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On errors', () {
    test('When the schema file is not found', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'non_existent_api.schema.json',
            'queries_glob': '**.graphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) => null, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.json': '',
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: debug),
          throwsA(predicate((e) => e is Exception)));
    });

    test('When user hasn\'t configured an output', () async {
      expect(
        () {
          graphQLQueryBuilder(BuilderOptions({
            'generate_helpers': false,
            'schema_mapping': [
              {
                'schema': 'api.schema.json',
                'queries_glob': '**.graphql',
              },
            ],
          }));
        },
        throwsA(predicate((e) => e is Exception)),
      );
    });

    test('When queries_glob is not configured', () async {
      final GraphQLQueryBuilder anotherBuilder =
          graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.json',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) => null, count: 0);

      final GraphQLSchema schema = GraphQLSchema(
          queryType:
              GraphQLType(name: 'SomeObject', kind: GraphQLTypeKind.OBJECT),
          types: [
            GraphQLType(name: 'String', kind: GraphQLTypeKind.SCALAR),
            GraphQLType(
                name: 'SomeObject',
                kind: GraphQLTypeKind.OBJECT,
                fields: [
                  GraphQLField(
                      name: 's',
                      type: GraphQLType(
                          name: 'String', kind: GraphQLTypeKind.SCALAR)),
                ]),
          ]);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.json': jsonFromSchema(schema),
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: debug),
          throwsA(predicate((e) => e is Exception)));
    });
  });
}
