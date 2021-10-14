import 'package:artemis/builder.dart';
import 'package:artemis/generator/errors.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('On errors', () {
    test('When there\'s a missing fragment being used', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'queries_glob': 'lib/queries/some_query.graphql',
            'output': 'lib/output/some_query.graphql.dart',
          },
        ],
      }));

      expect(
        () => testBuilder(
          anotherBuilder,
          {
            'a|api.schema.graphql': '''
                type Query {
                  a: String!
                }
                ''',
            'a|lib/queries/some_query.graphql':
                'query { ...nonExistentFragment }',
          },
          onLog: print,
        ),
        throwsA(predicate((e) =>
            e is MissingFragmentException &&
            e.fragmentName == 'NonExistentFragmentMixin' &&
            e.className == r'SomeQuery$Query')),
      );
    });
  });
}
