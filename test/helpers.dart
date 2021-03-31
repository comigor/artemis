import 'package:artemis/builder.dart';
import 'package:artemis/generator/data/data.dart';
import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

final bool Function(Iterable, Iterable) listEquals =
    const DeepCollectionEquality.unordered().equals;

Future testGenerator({
  required String query,
  required LibraryDefinition libraryDefinition,
  required String generatedFile,
  required String schema,
  String namingScheme = 'pathedWithTypes',
  bool appendTypeName = false,
  bool generateHelpers = false,
  Map<String, Object> builderOptionsMap = const {},
  Map<String, Object> sourceAssetsMap = const {},
  Map<String, Object> outputsMap = const {},
}) async {
  Logger.root.level = Level.INFO;

  assert((schema) != null);

  final anotherBuilder = graphQLQueryBuilder(BuilderOptions({
    if (!generateHelpers) 'generate_helpers': false,
    'schema_mapping': [
      {
        'schema': 'api.schema.graphql',
        'queries_glob': 'queries/**.graphql',
        'output': 'lib/query.graphql.dart',
        'naming_scheme': namingScheme,
        'append_type_name': appendTypeName,
      }
    ],
    ...builderOptionsMap,
  }));

  anotherBuilder.onBuild = expectAsync1((definition) {
    log.fine(definition);
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
      'a|lib/query.graphql.dart': generatedFile,
      ...outputsMap,
    },
    onLog: print,
  );
}

Future testNaming({
  required String query,
  required String schema,
  required List<String> expectedNames,
  required String namingScheme,
  bool shouldFail = false,
}) {
  assert((schema) != null);
  Logger.root.level = Level.ALL;

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
      final names = definition.queries.first.classes
          .map((e) => e.name!.namePrintable)
          .toSet();
      log.fine(names);
      expect(names.toSet(), equals(expectedNames.toSet()));
    }, count: 1);
  }

  return testBuilder(
    anotherBuilder,
    {
      'a|api.schema.graphql': schema,
      'a|queries/query.graphql': query,
    },
    onLog: print,
  );
}
