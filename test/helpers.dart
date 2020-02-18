import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

const IS_DEBUG = true;

void debug(LogRecord log) {
  if (IS_DEBUG) print(log);
}

Future testGenerator({
  @required String query,
  @required LibraryDefinition libraryDefinition,
  @required String generatedFile,
  @required String schema,
  bool generateHelpers = false,
  Map<String, dynamic> builderOptionsMap = const {},
  Map<String, dynamic> sourceAssetsMap = const {},
}) async {
  assert((schema) != null);

  final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
    if (!generateHelpers) 'generate_helpers': false,
    'schema_mapping': [
      {
        'schema': 'api.schema.graphql',
        'queries_glob': 'queries/**.graphql',
        'output': 'lib/query.dart',
      }
    ],
    ...builderOptionsMap,
  }));

  anotherBuilder.onBuild = expectAsync1((definition) {
    if (IS_DEBUG) print(definition);
    expect(definition, libraryDefinition);
  }, count: 1);

  return await testBuilder(
    anotherBuilder,
    {
      'a|api.schema.graphql': schema,
      'a|queries/query.graphql': query,
      ...sourceAssetsMap,
    },
    outputs: {
      'a|lib/query.dart': generatedFile,
    },
    onLog: debug,
  );
}
