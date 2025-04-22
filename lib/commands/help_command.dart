import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/utils/utils.dart';

class HelpCommand {
  static Future<void> action() async {
    Console.writeLine(dcli.green('👾 Current commands 👾'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kCreateCommand} > - '
        'Can create a template, files or folders in a project.'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kConnectCommand} > - '
        'Connect to a remote repository (Github).'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kAddCommand} > - Adds the package to the project.'));
  }

  static Future<void> showCreateCommand() async {
    Console.writeLine(dcli.green('👾 Available Create commands:'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kTemplateArgument} > - '
        'Creates a Flutter template project.'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kKeyArgument} > - '
        'Generates a key and adds it to the project.'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kFeatureArgument} > - '
        'Adds folder structure for feature.'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kBlocArgument} > - '
        'Creates a bloc template (bloc, state, event).'));
    Console.writeLine(dcli.green('🔹 ${Constants.kCreateCommand} < ${Constants.kCubitArgument} > - '
        'Creates a cubit template. (cubit, state)'));
  }

  static Future<void> showConnectCommand() async {
    Console.writeLine(dcli.green('👾 Available Connect commands:'));
    Console.writeLine(dcli.green('🔹 ${Constants.kConnectCommand} < ${Constants.kGithubArgument} > - '
        'Connects the project to Github.'));
  }

  static Future<void> showAddCommand() async {
    Console.writeLine(dcli.green('👾 Available Add commands:'));
    Console.writeLine(dcli.green('🔹 ${Constants.kAddCommand} < package > - Adds package to pubspec.'));
    Console.writeLine(dcli.green('🔹 ${Constants.kAddCommand} < ${Constants.kNativeSplashArgument} > - '
        'Adds package flutter_native_splash to pubspec and creates a yaml template.'));
  }
}


