import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:mason_logger/mason_logger.dart';

import 'package:emily/constants/constants.dart';
import 'package:emily/services/services.dart';
import 'package:emily/utils/utils.dart';

class CreateCommand {
  static Future<void> action() async {
    if (await Validator.checkVersion()) return;

    final logger = Logger();
    String? path = Constants.kCurrentPath;

    final projectName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterProjectName,
        errorMessage: Constants.kEnterValidProjectName,
        functionValidator: Validator.isValidProjectName
    );

    final specifyPath = logger.chooseOne(
      Constants.kNeedSpecifyPath,
      choices: <String?>[
        Constants.kYes,
        Constants.kNo
      ],
      defaultValue: Constants.kNo
    );

    if (specifyPath == Constants.kYes) {
      path = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterPath,
        errorMessage: Constants.kInvalidPath,
        functionValidator: Validator.isValidPath
      );
    }

    final projectPath = '$path/$projectName';

    final appName = InputService.getValidatedInput(
        consoleMessage: Constants.kAppName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidAppName
    );

    final appOrgBundle = InputService.getValidatedInput(
        consoleMessage: Constants.kAppOrgBundle,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidOrgBundle
    );

    final projectDescription = InputService.getValidatedInput(
      consoleMessage: Constants.kProjectDescription,
      errorMessage: Constants.kInvalidValue
    );

    final listPlatforms = logger.chooseAny(
        Constants.kChoosePlatform,
        choices: <String>['ios', 'android', 'windows', 'linux', 'macos', 'web'],
        defaultValues: <String>['ios', 'android', 'windows', 'linux', 'macos', 'web']
    );
    final platforms = listPlatforms.join(',');
    
    final result = Process.runSync(
      'flutter',
      <String>[
        'create',
        '--empty',
        '--project-name=$projectName',
        '--description=$projectDescription',
        '--org=$appOrgBundle',
        '--platforms=$platforms',
        projectPath
      ],
      runInShell: true
    );

    if (result.exitCode != 0) {
      Console.writeLine(dcli.red(_failCreateProject(result.stderr)));
    }

    await Renamer.changeAppName(
      projectName: projectName ?? 'example_app',
      appName: appName ?? 'Example App',
      path: projectPath
    );

    DirectoryService.buildStructure(projectPath);

    Console.writeLine(dcli.green('✅  The project was created successfully!'));
  }

  static String _failCreateProject(String? error) {
    return 'Failed to create Flutter project: $error';
  }
}
