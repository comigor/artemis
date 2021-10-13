import 'package:artemis/builder.dart';
import 'package:artemis/generator/errors.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('On errors', () {
    test('When the schema glob matches queries glob', () async {
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

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.json': '',
                'a|api.schema.grqphql': '',
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: print),
          throwsA(predicate((e) => e is QueryGlobsSchemaException)));
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
        throwsA(predicate((e) {
          return e is MissingBuildConfigurationException &&
              e.name == 'schema_mapping => output';
        })),
      );
    });

    test("When user hasn't configured an queries_glob", () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      try {
        await testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': ''' ''',
              'a|queries/query.graphql': ''' ''',
              'a|fragment.frag': ''' '''
            },
            onLog: print);
      } on MissingBuildConfigurationException catch (e) {
        expect(e.name, 'schema_map => queries_glob');
        return;
      }

      throw Exception('Expected MissingBuildConfigurationException');
    });

    test('When user fragments_glob return empty file', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'fragments_glob': '**.frag',
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      try {
        await testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': ''' ''',
              'a|queries/query.graphql': ''' ''',
            },
            onLog: print);
      } on MissingFilesException catch (e) {
        expect(e.globPattern, '**.frag');
        return;
      }
      throw Exception('Expected MissingFilesException');
    });

    test('When user fragments_glob at schema level return empty file',
        () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'fragments_glob': '**.schema',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      try {
        await testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': ''' ''',
              'a|queries/query.graphql': ''' ''',
            },
            onLog: print);
      } on MissingFilesException catch (e) {
        expect(e.globPattern, '**.schema');
        return;
      }
      throw Exception('Expected MissingFilesException');
    });

    test('When schema_mapping is empty', () async {
      try {
        final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
          'generate_helpers': false,
          'schema_mapping': [],
        }));

        await testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': ''' ''',
              'a|queries/query.graphql': ''' ''',
            },
            onLog: print);
      } on MissingBuildConfigurationException catch (e) {
        expect(e.name, 'schema_mapping');
        return;
      }

      throw Exception('Expected MissingBuildConfigurationException');
    });

    test('When schema_mapping => schema is not defined', () async {
      try {
        final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
          'generate_helpers': false,
          'schema_mapping': [
            {
              'queries_glob': '**.graphql',
              'output': 'lib/some_query.dart',
            }
          ],
        }));

        await testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': ''' ''',
              'a|queries/query.graphql': ''' ''',
            },
            onLog: print);
      } on MissingBuildConfigurationException catch (e) {
        expect(e.name, 'schema_map => schema');
        return;
      }

      throw Exception('Expected MissingBuildConfigurationException');
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

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

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

    test('When the schema file is not found', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'non_existent_api.schema.graphql',
            'queries_glob': 'lib/**.graphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.json': '',
                'a|api.schema.grqphql': '',
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: print),
          throwsA(predicate(
            (e) =>
                e is MissingFilesException &&
                e.globPattern == 'non_existent_api.schema.graphql',
          )));
    });

    test('When the queries_glob files are not found', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.grqphql',
            'queries_glob': 'lib/**.graphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|api.schema.grqphql': '',
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: print),
          throwsA(predicate(
            (e) =>
                e is MissingFilesException && e.globPattern == 'lib/**.graphql',
          )));
    });
  });

  test('Fragments with same name but with different selection set', () async {
    final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'api.schema.graphql',
          'output': 'lib/some_query.dart',
          'queries_glob': 'queries/**.graphql',
          'naming_scheme': 'pathedWithFields',
        },
      ],
    }));

    anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

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
                  name: String!
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
              'a|queries/anotherQuery.graphql': '''
                  {
                      pokemon {
                        ...Pokemon
                      }
                  }
                  
                  fragment Pokemon on Pokemon {
                    id
                    name
                  }
                ''',
            },
            onLog: print),
        throwsA(predicate((e) => e is DuplicatedClassesException)));
  });

  test('When the query globs schema location', () async {
    final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'lib/schema.graphql',
          'queries_glob': 'lib/*.graphql',
          'output': 'lib/output/some_query.dart',
        },
      ],
    }));

    anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

    expect(
        () => testBuilder(
            anotherBuilder,
            {
              'a|api.schema.json': '',
              'a|api.schema.grqphql': '',
              'a|some_query.query.graphql': 'query some_query { s }',
            },
            onLog: print),
        throwsA(predicate((e) => e is QueryGlobsSchemaException)));
  });

  test('When the query globs output location', () async {
    final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'schema.graphql',
          'queries_glob': 'lib/*',
          'output': 'lib/output.dart',
        },
      ],
    }));

    anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

    expect(
        () => testBuilder(
            anotherBuilder,
            {
              'a|api.schema.json': '',
              'a|api.schema.grqphql': '',
              'a|some_query.query.graphql': 'query some_query { s }',
            },
            onLog: print),
        throwsA(predicate((e) => e is QueryGlobsOutputException)));
  });

  test('When scalar_mapping does not define a custom scalar', () async {
    final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
      'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'api.schema.graphql',
          'output': 'lib/output/some_query.dart',
          'queries_glob': 'lib/queries/some_query.graphql',
        },
      ],
    }));

    anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

    expect(
        () => testBuilder(
            anotherBuilder,
            {
              'a|api.schema.graphql': r'''
scalar DateTime

type Query {
  s: DateTime
}
''',
              'a|lib/queries/some_query.graphql': 'query some_query { s }',
            },
            onLog: print),
        throwsA(predicate((e) =>
            e is MissingScalarConfigurationException &&
            e.scalarName == 'DateTime')));
  });
}
