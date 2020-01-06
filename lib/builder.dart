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

  /// List FragmentDefinitionNode in fragments_glob.
  final List<FragmentDefinitionNode> fragmentsCommon = [];

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
    if (options.fragmentsGlob != null) {
      final fragmentStream = buildStep.findAssets(Glob(options.fragmentsGlob));
      final fDocs = await fragmentStream
          .asyncMap(
            (asset) async => parseString(
              await buildStep.readAsString(asset),
              url: asset.path,
            ),
          )
          .toList();
      fDocs.forEach((fDoc) => fragmentsCommon.addAll(
          fDoc.definitions.whereType<FragmentDefinitionNode>().toList()));
    }

    for (final schemaMap in options.schemaMapping) {
      if (schemaMap.output == null) {
        throw Exception('Each schema mapping must specify an output path!');
      }

      final buffer = StringBuffer();
      final outputFileId = AssetId(buildStep.inputId.package, schemaMap.output);
      final schema = await _readSchemaFromPath(buildStep, schemaMap);

      // Loop through all files in glob
      final assetStream = buildStep.findAssets(Glob(schemaMap.queriesGlob));
      final gqlDocs = await assetStream
          .asyncMap(
            (asset) async => parseString(
              await buildStep.readAsString(asset),
              url: asset.path,
            ),
          )
          .toList();

      final libDefinition = generateLibrary(schema, schemaMap.output, gqlDocs,
          options, schemaMap, fragmentsCommon);
      if (onBuild != null) {
        onBuild(libDefinition);
      }
      writeLibraryDefinitionToBuffer(buffer, libDefinition);

      await buildStep.writeAsString(outputFileId, buffer.toString());
    }
  }
}
