import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/utils/utils.dart';

class HelpCommand {
  static Future<void> action() async {
    if (await Validator.checkVersion()) return;

    Console.writeLine(dcli.green('👾 Current commands 👾'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kCreateCommand} > - '
        'Can create a template, files or folders in a project.'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kConnectCommand} > - '
        'Connect to a remote repository (Github)'));
  }

  static Future<void> showCreateCommand() async {
    if (await Validator.checkVersion()) return;

    Console.writeLine(dcli.green('👾 Available Create commands:'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kTemplateArgument} > - '
        'Creates a Flutter template project.'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kKeyArgument} > - '
        'Generates a key and adds it to the project.'));
  }

  static Future<void> showConnectCommand() async {
    if (await Validator.checkVersion()) return;

    Console.writeLine(dcli.green('👾 Available Connect commands:'));
    Console.writeLine(dcli.green('🔹 ${Constants.kConnectCommand} < ${Constants.kGithubArgument} > - '
        'Connects the project to Github.'));
  }
}


