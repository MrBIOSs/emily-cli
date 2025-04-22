import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:emily/services/input_service.dart';

import 'package:mason_logger/mason_logger.dart';

import 'package:emily/utils/console.dart';
import 'package:emily/constants/constants.dart';
import 'package:emily/utils/validator.dart';

/// This class provides functions to create a folder structure.
class DirectoryService {
  static Future<void> buildStructure({
    required String projectPath,
    required List<String> directories
  }) async {
    if (directories.isEmpty) return;

    for (var dir in directories) {
      final directory = Directory('$projectPath/$dir');
      if (directory.existsSync() == false) {
        directory.createSync(recursive: true);
        Console.writeLine(dcli.cyan('Created: ${directory.path}'));
      } else {
        Console.writeLine('Already exists: ${directory.path}');
      }
    }
  }

  static String choosePath() {
    final logger = Logger();
    final currentPath = Directory.current.path;

    final result = logger.chooseOne(
        Constants.kNeedSpecifyPath,
        choices: <String?>[
          Constants.kYes,
          Constants.kNo
        ],
        defaultValue: Constants.kNo
    );

    if (result == Constants.kYes) {
      return InputService.getValidatedInput(
          consoleMessage: Constants.kEnterPath,
          errorMessage: Constants.kInvalidPath,
          functionValidator: Validator.isValidPath
      ) ?? currentPath;
    }

    return currentPath;
  }

  static String getValidProjectPath(String subdirectory) {
    String path = DirectoryService.choosePath();

    while (Validator.isValidPath('$path/$subdirectory') == false) {
      Console.writeLine(dcli.red(Constants.kFolderNotFound));
      path = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterPath,
        errorMessage: Constants.kInvalidPath,
        functionValidator: Validator.isValidPath
      ) ?? '';
    }
    return path;
  }
}
