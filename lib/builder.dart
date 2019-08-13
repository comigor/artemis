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
      printCustomQuery(buffer, definition);
      await buildStep.writeAsString(
          outputAssetId, _dartFormatter.format(buffer.toString()));
    }
  }
}
