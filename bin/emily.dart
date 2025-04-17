import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/commands/commands.dart';
import 'package:emily/constants/constants.dart';
import 'package:emily/utils/console.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    Console.writeLine(dcli.red('Enter the command: emily <command>'));
    return;
  }
  Console.write(dcli.yellow(Constants.kLogo));
  Console.writeLine();

  switch (arguments.first) {
    case Constants.kCreateCommand:
      await CreateCommand.action();
      break;

    case Constants.kConnectCommand:
      await ConnectCommand.action();
      break;

    case Constants.kHelpCommand:
      await HelpCommand.action();
      break;

    default:
      Console.writeLine(dcli.red('Unknown command!'));
  }
}