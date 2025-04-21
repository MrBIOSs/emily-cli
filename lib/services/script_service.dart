import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:emily/utils/converter.dart';

/// This class provides a set of utility functions for working with scripts
/// in a Flutter project.
class ScriptService {
  static Future<bool> isDartOldVersion(String version) async {
    final processResult = await Process.run(
      'dart',
      <String>['--version'],
      runInShell: true
    );
    final versionOutput = processResult.stdout.toString().trim();
    final versionMatch = RegExp(r'version: ([\d\.]+)').firstMatch(versionOutput);

    if (versionMatch != null) {
      final sdkVersion = versionMatch.group(1);

      if (sdkVersion != null) {
        final numericSdkVersion = Converter.convertToThousands(int.tryParse(sdkVersion.replaceAll('.', '')));
        final numericCurrentVersion = Converter.convertToThousands(int.tryParse(version.replaceAll('.', '')));

        if (numericSdkVersion != null && numericCurrentVersion != null) {
          if (numericSdkVersion < numericCurrentVersion) {
            return true;
          }
        }
      }
    }
    return false;
  }

  // static Future<void> flutterBuild(String modulePath) async {
  //   final ProcessResult pubGetProcess = await Process.run(
  //     'dart',
  //     <String>[
  //       'pub',
  //       'run',
  //       'build_runner',
  //       'build',
  //       '--delete-conflicting-outputs'
  //     ],
  //     workingDirectory: modulePath,
  //     runInShell: true,
  //   );
  //   if (pubGetProcess.exitCode != 0) {
  //     stdout.writeln(red(
  //         '❌  Error running flutter pub get for $modulePath : ${pubGetProcess.stderr}'));
  //   } else {
  //     stdout.writeln(
  //         green('✅  Successfully ran flutter pub get for $modulePath'));
  //   }
  // }
}
