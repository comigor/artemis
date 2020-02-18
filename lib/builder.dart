import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';

import './generator.dart';
import './generator/data.dart';
import './generator/print_helpers.dart';
import './schema/options.dart';

/// [GraphQLQueryBuilder] instance, to be used by `build_runner`.
GraphQLQueryBuilder graphQLQueryBuilder(BuilderOptions options) =>
    GraphQLQueryBuilder(options);

List<String> _builderOptionsToExpectedOutputs(BuilderOptions builderOptions) {
  final schemaMaps =
      GeneratorOptions.fromJson(builderOptions.config).schemaMapping;

  if (schemaMaps.any((s) => s.output == null)) {
    throw Exception('''One or more SchemaMap configurations miss an output!
Please check your build.yaml file.
''');
  }

  return schemaMaps
      .map((s) => s.output.replaceAll(RegExp(r'^lib/'), ''))
      .toList();
}

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
      final buffer = StringBuffer();
      final outputFileId = AssetId(buildStep.inputId.package, schemaMap.output);

      // Loop through all files in glob
      if (schemaMap.queriesGlob == null) {
        throw Exception('''No queries were considered on this generation!
Make sure that `queries_glob` your build.yaml file include GraphQL queries files.
''');
      }
      final assetStream = buildStep.findAssets(Glob(schemaMap.queriesGlob));
      final gqlDocs = await assetStream
          .asyncMap(
            (asset) async => parseString(
              await buildStep.readAsString(asset),
              url: asset.path,
            ),
          )
          .toList();

      final schemaAssetStream = buildStep.findAssets(Glob(schemaMap.schema));

      DocumentNode gqlSchema;

      try {
        gqlSchema = await schemaAssetStream
            .asyncMap(
              (asset) async => parseString(
                await buildStep.readAsString(asset),
                url: asset.path,
              ),
            )
            .first;
      } catch (e) {
        throw Exception('''Schema `${schemaMap.schema}` was not found!
Make sure the file exists and you've typed it conrrectly on build.yaml.
''');
      }

      final libDefinition = generateLibrary(schemaMap.output, gqlDocs, options,
          schemaMap, fragmentsCommon, gqlSchema);
      if (onBuild != null) {
        onBuild(libDefinition);
      }
      writeLibraryDefinitionToBuffer(buffer, libDefinition);

      await buildStep.writeAsString(outputFileId, buffer.toString());
    }
  }
}
