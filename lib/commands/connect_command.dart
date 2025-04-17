import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/services/input_service.dart';
import 'package:emily/utils/console.dart';
import 'package:emily/utils/validator.dart';

class ConnectCommand {
  static Future<void> action() async {
    if (await Validator.checkVersion()) return;

    final projectPath = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterProjectPath,
        errorMessage: Constants.kInvalidPath,
        functionValidator: Validator.isValidPath
    );

    final usernameGithub = InputService.getValidatedInput(
        consoleMessage: Constants.kUsernameGithub,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidUsername
    );

    final repositoryGithub = InputService.getValidatedInput(
        consoleMessage: Constants.kRepositoryGithub,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidRepositoryGithub
    );

    _runGitCommand(projectPath, ['init']);
    _runGitCommand(projectPath, ['add', '--all']);
    _runGitCommand(projectPath, ['commit', '-m', 'first commit']);
    _runGitCommand(projectPath, ['branch', '-M', 'main']);
    _runGitCommand(
        projectPath,
        ['remote', 'add', 'origin', 'https://github.com/$usernameGithub/$repositoryGithub.git']
    );
    _runGitCommand(projectPath, ['push', '-u', 'origin', 'main']);

    Console.writeLine(dcli.green('✅  The project has connected to Github successfully!'));
  }

  static void _runGitCommand(String? projectPath, List<String> arguments) {
    final result = Process.runSync(
        'git',
        arguments,
        workingDirectory: projectPath,
        runInShell: true
    );

    if (result.exitCode != 0) {
      Console.writeLine(dcli.red(_failConnectProject(result.stderr)));
      exit(1);
    }
  }

  static String _failConnectProject(String? error) {
    return 'Failed to connect the project to Github: $error';
  }
}