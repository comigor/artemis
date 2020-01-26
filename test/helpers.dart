import 'dart:convert';

import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/schema/graphql.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

const IS_DEBUG = true;

String jsonFromSchema(GraphQLSchema schema) => json.encode({
      'data': {'__schema': schema.toJson()}
    });

void debug(LogRecord log) {
  if (IS_DEBUG) print(log);
}

void testGenerator({
  @required String description,
  @required String query,
  @required LibraryDefinition libraryDefinition,
  @required String generatedFile,
  GraphQLSchema typedSchema,
  String stringSchema,
  bool generateHelpers = false,
  Map<String, dynamic> builderOptionsMap = const {},
  Map<String, dynamic> sourceAssetsMap = const {},
}) {
  assert((typedSchema ?? stringSchema) != null);
  final schema = stringSchema ?? jsonFromSchema(typedSchema);

  test(description, () async {
    final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
      if (!generateHelpers) 'generate_helpers': false,
      'schema_mapping': [
        {
          'schema': 'api.schema.json',
          'queries_glob': '**.graphql',
          'output': 'lib/query.dart',
        }
      ],
      ...builderOptionsMap,
    }));

    anotherBuilder.onBuild = expectAsync1((definition) {
      if (IS_DEBUG) print(definition);
      expect(definition, libraryDefinition);
    }, count: 1);

    await testBuilder(
      anotherBuilder,
      {
        'a|api.schema.json': schema,
        'a|query.graphql': query,
        ...sourceAssetsMap,
      },
      outputs: {
        'a|lib/query.dart': generatedFile,
      },
      onLog: debug,
    );
  });
}
