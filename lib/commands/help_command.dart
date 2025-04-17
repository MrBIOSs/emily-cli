import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/utils/utils.dart';

class HelpCommand {
  static Future<void> action() async {
    if (await Validator.checkVersion()) return;

    Console.writeLine(dcli.green('👾 Current commands 👾'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kCreateCommand} > - Create a Flutter project template'));
    Console.writeLine(dcli.green('🔸 < ${Constants.kConnectCommand} > - Connect to a remote Github repository'));
  }
}


