import 'dart:async';

import 'package:build/build.dart';

import './runner_helper.dart';
import './schema/options.dart';

ProcessorBuilder processorBuilder(BuilderOptions options) =>
    ProcessorBuilder(options);

class ProcessorBuilder implements Builder {
  /// Creates a builder from [BuilderOptions].
  ProcessorBuilder(BuilderOptions builderOptions)
      : options = GeneratorOptions.fromJson(builderOptions.config);

  /// This generator options, gathered from `build.yaml` file.
  final GeneratorOptions options;

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': ['processor.dart'],
      };

  Future<String> _generateProcessor() async {
    return '''
void main() async {
  print('HELLO WORLD!');
}
''';
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final processorId = AssetId(buildStep.inputId.package, PROCESSOR_FILE);

    await buildStep.writeAsString(processorId, _generateProcessor());
  }
}
