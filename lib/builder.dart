import 'dart:async';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import './generator.dart';
import './generator/data.dart';
import './generator/graphql_helpers.dart';
import './generator/print_helpers.dart';
import './schema/options.dart';

/// [GraphQLQueryBuilder] instance, to be used by `build_runner`.
Builder graphQLQueryBuilder(BuilderOptions options) =>
    GraphQLQueryBuilder(options);

/// Main Artemis builder.
class GraphQLQueryBuilder implements Builder {
  /// Creates a builder from [BuilderOptions].
  GraphQLQueryBuilder(BuilderOptions builderOptions)
      : options = GeneratorOptions.fromJson(builderOptions.config);

  /// This generator options, gathered from `build.yaml` file.
  final GeneratorOptions options;

  /// Callback fired when the generator processes a [QueryDefinition].
  OnBuildQuery onBuild;

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.query.graphql': ['.query.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final schemaMap = options.schemaMapping.firstWhere(
        (sm) => Glob(sm.queriesGlob).matches(buildStep.inputId.path),
        orElse: () => null);
    if (schemaMap != null) {
      final assetStream = buildStep.findAssets(Glob(schemaMap.schema));
      final schemaFile = await assetStream.single;
      final schema =
          schemaFromJsonString(await buildStep.readAsString(schemaFile));

      final path =
          buildStep.inputId.path.replaceAll(RegExp(r'\.query\.graphql$'), '');

      final outputAssetId =
          AssetId(buildStep.inputId.package, path).addExtension('.query.dart');

      final src = await buildStep.readAsString(buildStep.inputId);
      final definition = generateQuery(schema, path, src, options, schemaMap);
      if (onBuild != null) {
        onBuild(definition);
      }

      final buffer = StringBuffer();
      writeDefinitionsToBuffer(buffer, definition);

      await buildStep.writeAsString(outputAssetId, buffer.toString());
    }
  }
}
