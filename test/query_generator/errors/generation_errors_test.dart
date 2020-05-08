import 'package:artemis/builder.dart';
import 'package:artemis/generator/errors.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  Logger.root.level = Level.ALL;

  group('On errors', () {
    test('When the schema file is not found', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'non_existent_api.schema.graphql',
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
                'a|api.schema.grqphql': '',
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: print),
          throwsA(predicate((e) => e is Exception)));
    });

    test("When user hasn't configured an output", () async {
      expect(
        () {
          graphQLQueryBuilder(BuilderOptions({
            'generate_helpers': false,
            'schema_mapping': [
              {
                'schema': 'api.schema.grqphql',
                'queries_glob': 'queries/**.graphql',
              },
            ],
          }));
        },
        throwsA(predicate((e) => e is Exception)),
      );
    });

    test('When fragments_glob meets local fragments', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'output': 'lib/some_query.dart',
            'queries_glob': 'queries/**.graphql',
          },
        ],
        'fragments_glob': '**.frag',
      }));

      anotherBuilder.onBuild = expectAsync1((_) => null, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.graphql': '''
                schema {
                  query: Query
                }
      
                type Query {
                  pokemon: Pokemon
                }
      
                type Pokemon {
                  id: String!
                }
                ''',
                'a|queries/query.graphql': '''
                  {
                      pokemon {
                        ...Pokemon
                      }
                  }
                  
                  fragment Pokemon on Pokemon {
                    id
                  }
                ''',
                'a|fragment.frag': '''fragment Pokemon on Pokemon {
                  id
                }'''
              },
              onLog: print),
          throwsA(predicate((e) => e is FragmentIgnoreException)));
    });
  });
}
