import 'dart:async';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import './generator.dart';
import './generator/data.dart';
import './generator/graphql_helpers.dart';
import './generator/print_helpers.dart';
import './schema/graphql.dart';
import './schema/options.dart';

/// [GraphQLQueryBuilder] instance, to be used by `build_runner`.
Builder graphQLQueryBuilder(BuilderOptions options) =>
    GraphQLQueryBuilder(options);

List<String> _builderOptionsToExpectedOutputs(BuilderOptions builderOptions) =>
    (builderOptions.config['schema_mapping'] as List)
        .map((i) => i['output'].toString().replaceAll(RegExp(r'^lib/'), ''))
        .toList();

/// Main Artemis builder.
class GraphQLQueryBuilder implements Builder {
  /// Creates a builder from [BuilderOptions].
  GraphQLQueryBuilder(BuilderOptions builderOptions)
      : options = GeneratorOptions.fromJson(builderOptions.config),
        expectedOutputs = _builderOptionsToExpectedOutputs(builderOptions);

  /// This generator options, gathered from `build.yaml` file.
  final GeneratorOptions options;

  /// The generated output file.
  final List<String> expectedOutputs;

  /// Callback fired when the generator processes a [QueryDefinition].
  OnBuildQuery onBuild;

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': expectedOutputs,
      };

  Future<GraphQLSchema> _readSchemaFromPath(
      BuildStep buildStep, SchemaMap schemaMap) async {
    final assetStream = buildStep.findAssets(Glob(schemaMap.schema));
    final schemaFile = await assetStream.single;
    return schemaFromJsonString(await buildStep.readAsString(schemaFile));
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    for (final schemaMap in options.schemaMapping) {
      final buffer = StringBuffer();
      final outputFileId = AssetId(buildStep.inputId.package, schemaMap.output);
      final schema = await _readSchemaFromPath(buildStep, schemaMap);

      // Loop through all files in glob
      final assetStream = buildStep.findAssets(Glob(schemaMap.queriesGlob));
      await for (final input in assetStream) {
        final src = await buildStep.readAsString(input);
        final definition =
            generateQuery(schema, schemaMap.output, src, options, schemaMap);
        if (onBuild != null) {
          onBuild(definition);
        }

        writeDefinitionsToBuffer(buffer, definition);
      }

      await buildStep.writeAsString(outputFileId, buffer.toString());
    }
  }
}
