import 'package:artemis/builder.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
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
              onLog: debug),
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

    test('When queries_glob is not configured', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'api.schema.graphql',
            'output': 'lib/some_query.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) => null, count: 0);

      expect(
          () => testBuilder(
              anotherBuilder,
              {
                'a|some_query.query.graphql': 'query some_query { s }',
              },
              onLog: debug),
          throwsA(predicate((e) => e is Exception)));
    });
  });
}
