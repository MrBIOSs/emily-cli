import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/services/services.dart';
import 'package:emily/utils/utils.dart';

class ConnectCommand {
  static Future<void> github() async {
    if (await Validator.checkVersion()) return;

    final projectPath = DirectoryService.choosePath();

    final usernameGithub = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterUsernameGithub,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidString
    );

    final repositoryGithub = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterRepositoryGithub,
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
    return '❌  Failed to connect the project to Github: $error';
  }
}