import 'package:artemis/builder.dart';
import 'package:artemis/generator/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

final bool Function(Iterable, Iterable) listEquals =
    const DeepCollectionEquality.unordered().equals;

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
  Map<String, dynamic> outputsMap = const {},
}) async {
  assert((schema) != null);

  final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
    if (!generateHelpers) 'generate_helpers': false,
    'schema_mapping': [
      {
        'schema': 'api.schema.graphql',
        'queries_glob': 'queries/**.graphql',
        'output': 'lib/query.graphql.dart',
      }
    ],
    ...builderOptionsMap,
  }));

//  anotherBuilder.onBuild = expectAsync1((definition) {
//    if (IS_DEBUG) print(definition);
//    expect(definition, equals(libraryDefinition));
//  }, count: 1);

  return await testBuilder(
    anotherBuilder,
    {
      'a|api.schema.graphql': schema,
      'a|queries/query.graphql': query,
      ...sourceAssetsMap,
    },
    outputs: {
      'a|lib/query.graphql.dart': generatedFile,
      ...outputsMap,
    },
    onLog: debug,
  );
}

Future testNaming({
  @required String query,
  @required String schema,
  @required List<String> expectedNames,
  @required String namingScheme,
  bool shouldFail = false,
}) {
  assert((schema) != null);

  final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
    'generate_helpers': false,
    'schema_mapping': [
      {
        'schema': 'api.schema.graphql',
        'queries_glob': 'queries/**.graphql',
        'output': 'lib/query.dart',
        'naming_scheme': namingScheme,
      }
    ],
  }));

  if (!shouldFail) {
    anotherBuilder.onBuild = expectAsync1((definition) {
      final names = definition.queries.first.classes.map((e) => e.name).toSet();
      if (IS_DEBUG) print(names);
      expect(names.toSet(), equals(expectedNames.toSet()));
    }, count: 1);
  }

  return testBuilder(
    anotherBuilder,
    {
      'a|api.schema.graphql': schema,
      'a|queries/query.graphql': query,
    },
    onLog: debug,
  );
}
