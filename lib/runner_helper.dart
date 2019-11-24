import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:io/io.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:logging/logging.dart';

final _logger = Logger('Artemis:Processor');

final GENERATED_FOLDER = '.dart_tool/build/generated';
final PROCESSOR_FILE = 'lib/processor.dart';

abstract class RunnerHelper {
  /// Snapshots the processor script if needed and runs it.
  ///
  /// Will retry once on [IsolateSpawnException]s to handle SDK updates.
  ///
  /// Returns the exit code from running the build script.
  ///
  /// If an exit code of 75 is returned, this function should be re-ran.
  ///
  /// Borrowed and modified from https://github.com/dart-lang/build/blob/master/build_runner/lib/src/build_script_generate/bootstrap.dart.
  static Future<int> run(String package) async {
    final scriptLocation =
        p.absolute(GENERATED_FOLDER, package, PROCESSOR_FILE);
    final scriptSnapshotLocation = p.setExtension(scriptLocation, '.snapshot');

    ReceivePort exitPort;
    ReceivePort errorPort;
    ReceivePort messagePort;
    StreamSubscription errorListener;
    int scriptExitCode;

    var tryCount = 0;
    var succeeded = false;
    while (tryCount < 2 && !succeeded) {
      tryCount++;
      exitPort?.close();
      errorPort?.close();
      messagePort?.close();
      await errorListener?.cancel();

      scriptExitCode =
          await _createSnapshotIfNeeded(scriptSnapshotLocation, scriptLocation);
      if (scriptExitCode != 0) return scriptExitCode;

      exitPort = ReceivePort();
      errorPort = ReceivePort();
      messagePort = ReceivePort();
      errorListener = errorPort.listen((e) {
        final error = e[0];
        final trace = e[1] as String;
        stderr
          ..writeln('\n\nYou have hit a bug in build_runner')
          ..writeln('Please file an issue with reproduction steps at '
              'https://github.com/dart-lang/build/issues\n\n')
          ..writeln(error)
          ..writeln(Trace.parse(trace).terse);
        if (scriptExitCode == 0) scriptExitCode = 1;
      });
      try {
        await Isolate.spawnUri(Uri.file(p.absolute(scriptSnapshotLocation)), [],
            messagePort.sendPort,
            errorsAreFatal: true,
            onExit: exitPort.sendPort,
            onError: errorPort.sendPort);
        succeeded = true;
      } on IsolateSpawnException catch (e) {
        if (tryCount > 1) {
          _logger.severe(
              'Failed to spawn build script after retry. '
              'This is likely due to a misconfigured builder definition. '
              'See the generated script at $scriptLocation to find errors.',
              e);
          messagePort.sendPort.send(ExitCode.config.code);
          exitPort.sendPort.send(null);
        } else {
          _logger.warning(
              'Error spawning build script isolate, this is likely due to a Dart '
              'SDK update. Deleting snapshot and retrying...');
        }
        await File(scriptSnapshotLocation).delete();
      }
    }

    StreamSubscription exitCodeListener;
    exitCodeListener = messagePort.listen((isolateExitCode) {
      if (isolateExitCode is int) {
        scriptExitCode = isolateExitCode;
      } else {
        throw StateError(
            'Bad response from isolate, expected an exit code but got '
            '$isolateExitCode');
      }
      exitCodeListener.cancel();
      exitCodeListener = null;
    });
    await exitPort.first;
    await errorListener.cancel();
    await exitCodeListener?.cancel();

    return scriptExitCode;
  }

  /// Creates a script snapshot for the preprocessor script.
  ///
  /// Returns zero for success or a number for failure which should be set to the
  /// exit code.
  ///
  /// Borrowed and modified from https://github.com/dart-lang/build/blob/master/build_runner/lib/src/build_script_generate/bootstrap.dart.
  static Future<int> _createSnapshotIfNeeded(
      String scriptSnapshotLocation, String scriptLocation) async {
    var snapshotFile = File(scriptSnapshotLocation);

    // Always delete snapshot, at least for now.
    if (await snapshotFile.exists()) {
      await snapshotFile.delete();
    }

    String stderr;
    if (!await snapshotFile.exists()) {
      var mode = stdin.hasTerminal
          ? ProcessStartMode.normal
          : ProcessStartMode.detachedWithStdio;
      var snapshot = await Process.start(Platform.executable,
          ['--snapshot=$scriptSnapshotLocation', scriptLocation],
          mode: mode);
      stderr = (await snapshot.stderr
              .transform(utf8.decoder)
              .transform(LineSplitter())
              .toList())
          .join('');
      if (!await snapshotFile.exists()) {
        _logger.severe(
            'Failed to snapshot Artemis preprocessor script at $scriptLocation.\n'
            'This is likely caused by a misconfigured definition.');
        if (stderr.isNotEmpty) {
          _logger.severe(stderr);
        }
        return ExitCode.config.code;
      }
    }
    return 0;
  }
}
