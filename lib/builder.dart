import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';

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
        .where((s) => s.output != null)
        .map((s) => s.output.replaceAll(RegExp(r'^lib/'), ''))
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

  Future<List<DocumentNode>> _parseDocuments(
      BuildStep buildStep, SchemaMap schemaMap) async {
    // Loop through all files in glob
    final assetStream = buildStep.findAssets(Glob(schemaMap.queriesGlob));

    print(schemaMap.preprocess);
    if ((schemaMap.preprocess?.toLowerCase() ?? '').startsWith('concat')) {
      return [
        parseString(
          await assetStream
              .asyncMap(
                (asset) => buildStep.readAsString(asset),
              )
              .reduce((a, b) => b + '\n\n' + a),
          url: schemaMap.queriesGlob,
        )
      ];
    } else {
      return assetStream
          .asyncMap(
            (asset) async => parseString(
                  await buildStep.readAsString(asset),
                  url: asset.path,
                ),
          )
          .toList();
    }
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    try {
      for (final schemaMap in options.schemaMapping) {
        if (schemaMap.output == null) {
          throw Exception('Each schema mapping must specify an output path!');
        }

        final buffer = StringBuffer();
        final outputFileId =
            AssetId(buildStep.inputId.package, schemaMap.output);
        final schema = await _readSchemaFromPath(buildStep, schemaMap);
        final gqlDocs = await _parseDocuments(buildStep, schemaMap);

        final libDefinition = generateLibrary(
          schema,
          schemaMap.output,
          gqlDocs,
          options,
          schemaMap,
        );
        if (onBuild != null) {
          onBuild(libDefinition);
        }
        writeLibraryDefinitionToBuffer(buffer, libDefinition);

        await buildStep.writeAsString(outputFileId, buffer.toString());
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
