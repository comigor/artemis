import 'dart:async';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:artemis/schema/options.dart';
import 'package:artemis/generator.dart';
import 'package:artemis/generator/data.dart';
import 'package:artemis/generator/print_helpers.dart';
import 'package:artemis/generator/graphql_helpers.dart';

final DartFormatter _dartFormatter = DartFormatter();

/// Supports `package:build_runner` creation and configuration of
/// `artemis`.
///
/// Not meant to be invoked by hand-authored code.
Builder graphQLTypesBuilder(BuilderOptions options) =>
    GraphQLTypesBuilder(options);

class GraphQLTypesBuilder implements Builder {
  GraphQLTypesBuilder(BuilderOptions builderOptions)
      : options = GeneratorOptions.fromJson(builderOptions.config);

  final GeneratorOptions options;

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.schema.json': ['.api.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final src = await buildStep.readAsString(buildStep.inputId);
    final schema = schemaFromJsonString(src);
    final path =
        buildStep.inputId.path.replaceAll(RegExp(r'\.schema\.json$'), '');

    final outputAssetId =
        AssetId(buildStep.inputId.package, path).addExtension('.api.dart');

    await buildStep.writeAsString(outputAssetId,
        _dartFormatter.format(await generate(schema, path, options)));
  }
}

Builder graphQLQueryBuilder(BuilderOptions options) =>
    GraphQLQueryBuilder(options);

class GraphQLQueryBuilder implements Builder {
  GraphQLQueryBuilder(BuilderOptions builderOptions)
      : options = GeneratorOptions.fromJson(builderOptions.config);

  final GeneratorOptions options;
  OnBuildQuery onBuild;

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.query.graphql': ['.query.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final src = await buildStep.readAsString(buildStep.inputId);

    final schemaMap = options.schemaMapping.firstWhere(
        (sm) => Glob(sm.queriesGlob).matches(buildStep.inputId.path),
        orElse: () => null);
    if (schemaMap != null) {
      final assetStream = buildStep.findAssets(Glob(schemaMap.schema));
      final schemaFile = await assetStream.first;
      final schema =
          schemaFromJsonString(await buildStep.readAsString(schemaFile));

      final path =
          buildStep.inputId.path.replaceAll(RegExp(r'\.query\.graphql$'), '');

      final outputAssetId =
          AssetId(buildStep.inputId.package, path).addExtension('.query.dart');

      final definition = generateQuery(schema, path, src, options, schemaMap);
      if (onBuild != null) {
        onBuild(definition);
      }

      final buffer = StringBuffer();
      printCustomQuery(buffer, definition);
      await buildStep.writeAsString(
          outputAssetId, _dartFormatter.format(buffer.toString()));
    }
  }
}
