import 'package:artemis/builder.dart';
import 'package:artemis/generator/errors.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  group('On errors', () {
    test('When there\'s no root type on schema', () async {
      final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
        'generate_helpers': false,
        'schema_mapping': [
          {
            'schema': 'lib/api.schema.graphql',
            'queries_glob': 'lib/**.query.graphql',
            'output': 'lib/some_query.graphql.dart',
          },
        ],
      }));

      anotherBuilder.onBuild = expectAsync1((_) {}, count: 0);

      expect(
        () => testBuilder(
          anotherBuilder,
          {
            'a|lib/api.schema.graphql': '',
            'a|lib/some.query.graphql': 'query { a }',
          },
          onLog: print,
        ),
        throwsA(predicate((e) => e is MissingRootTypeException)),
      );
    });
  });
}
