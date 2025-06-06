import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/commands/commands.dart';
import 'package:emily/constants/constants.dart';
import 'package:emily/utils/utils.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    Console.writeLine(dcli.red('Enter the command: emily <command>'));
    return;
  }
  Console.write(dcli.yellow(Constants.kLogo));
  Console.writeLine();
  if (await Validator.checkVersion()) return;

  switch (arguments.first) {
    case Constants.kCreateCommand:
      if (arguments.length == 1) {
        HelpCommand.showCreateCommand();
      } else {
        if (arguments[1] == Constants.kTemplateArgument) CreateCommand.flutterTemplate();
        if (arguments[1] == Constants.kKeyArgument) CreateCommand.keystore();
        if (arguments[1] == Constants.kFeatureArgument) CreateCommand.feature();
        if (arguments[1] == Constants.kBlocArgument) CreateCommand.bloc();
        if (arguments[1] == Constants.kCubitArgument) CreateCommand.cubit();
      }
      break;

    case Constants.kConnectCommand:
      if (arguments.length == 1) {
        HelpCommand.showConnectCommand();
      } else {
        if (arguments[1] == Constants.kGithubArgument) ConnectCommand.github();
      }
      break;

    case Constants.kAddCommand:
      if (arguments.length == 1) {
        HelpCommand.showAddCommand();
      } else {
        if (arguments[1].startsWith('-')) {
          if (arguments[1] == Constants.kNativeSplashArgument) AddCommand.nativeSplash();
        } else {
          AddCommand.package();
        }
      }
      break;

    case Constants.kHelpCommand:
      HelpCommand.action();
      break;

    default:
      Console.writeLine(dcli.red('Unknown command!'));
  }
}