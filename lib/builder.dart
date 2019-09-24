import 'dart:async';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';
import './generator.dart';
import './generator/data.dart';
import './generator/graphql_helpers.dart';
import './generator/print_helpers.dart';
import './schema/graphql.dart';
import './schema/options.dart';

/// [GraphQLQueryBuilder] instance, to be used by `build_runner`.
GraphQLQueryBuilder graphQLQueryBuilder(BuilderOptions options) =>
    GraphQLQueryBuilder(options);

List<String> _builderOptionsToExpectedOutputs(BuilderOptions builderOptions) =>
    GeneratorOptions.fromJson(builderOptions.config)
        .schemaMapping
        .fold<Iterable<String>>([], (memo, schemaMap) {
          if (schemaMap.output != null) {
            return memo.followedBy([schemaMap.output]);
          }
          return memo.followedBy(schemaMap.mapping.values);
        })
        .map((s) => s.replaceAll(RegExp(r'^lib/'), ''))
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

  Future<void> _generateToSingleOutput(BuildStep buildStep, String queriesGlob,
      String output, SchemaMap schemaMap) async {
    final buffer = StringBuffer();
    final outputFileId = AssetId(buildStep.inputId.package, output);
    final schema = await _readSchemaFromPath(buildStep, schemaMap);

    // Loop through all files in glob
    final assetStream = buildStep.findAssets(Glob(queriesGlob));
    final sources = await assetStream.asyncMap(buildStep.readAsString).toList();

    final libDefinition =
        generateLibrary(schema, output, sources, options, schemaMap);
    if (onBuild != null) {
      onBuild(libDefinition);
    }
    writeLibraryDefinitionToBuffer(buffer, libDefinition);

    await buildStep.writeAsString(outputFileId, buffer.toString());
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    for (final schemaMap in options.schemaMapping) {
      if (schemaMap.output != null) {
        await _generateToSingleOutput(
            buildStep, schemaMap.queriesGlob, schemaMap.output, schemaMap);
      } else {
        for (final mapping in schemaMap.mapping.entries) {
          await _generateToSingleOutput(
              buildStep, mapping.key, mapping.value, schemaMap);
        }
      }
    }
  }
}
