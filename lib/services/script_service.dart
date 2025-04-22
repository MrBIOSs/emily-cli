import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:emily/utils/utils.dart';

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

  /// Adds packages to a specific project.
  ///
  /// [packages] is a list of package names to add.
  /// [projectPath] is the path to the working directory.
  ///
  /// If the command is successful, a success message is printed to the console.
  /// If the command fails, an error message is printed to the console.
  static Future<void> addPackages({
    required List<String> packages,
    bool isDevDependency = false,
    required String projectPath
  }) async {
    final processResult = await Process.run(
        'flutter',
        isDevDependency ? <String>['pub', 'add', '-d', ...packages] : <String>['pub', 'add', ...packages],
        workingDirectory: projectPath,
        runInShell: true
    );

    if (processResult.exitCode != 0) {
      Console.writeLine(red('❌  Failed to add packages to pubspec: ${processResult.stderr}'));
      exit(1);
    } else {
      Console.writeLine(green('✅  Packages added to pubspec'));
    }
  }

  /// Runs `flutter pub get` for a specific project.
  ///
  /// [projectPath] is the path to the project to get packages for.
  ///
  /// If the command is successful, a success message is printed to the console.
  /// If the command fails, an error message is printed to the console.
  static Future<void> flutterPubGet(String projectPath) async {
    final pubGetProcess = await Process.run(
      'flutter',
      <String>['pub', 'get'],
      workingDirectory: projectPath,
      runInShell: true
    );

    if (pubGetProcess.exitCode != 0) {
      Console.writeLine(red('❌  Error running flutter pub get: ${pubGetProcess.stderr}'));
      exit(1);
    } else {
      Console.writeLine(green('✅  Successfully ran flutter pub get!'));
    }
  }
}
