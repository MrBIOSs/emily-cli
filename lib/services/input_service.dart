import 'package:dcli/dcli.dart';

import 'package:emily/services/file_service.dart';
import 'package:emily/utils/console.dart';

/// This class provides a function
/// to get validated user input from the command line.
class InputService {
  /// Gets validated user input from the command line.
  ///
  /// [consoleMessage] is the message to display to the user before getting input.
  /// [errorMessage] is the message to display to the user if the input is invalid.
  /// [functionValidator] is an optional function that takes a string
  /// and returns a bool indicating whether the input is valid.
  /// If not provided, all input is considered valid.
  ///
  /// Trailing commas are automatically removed from the input.
  ///
  /// Returns the validated input from the user.
  static String? getValidatedInput({
    String? consoleMessage,
    String? errorMessage,
    bool? Function(String? message)? functionValidator
  }) {
    Console.writeLine(consoleMessage);

    String? message = FileService.removeTrailingComma(Console.readLineSync()?.trim());

    while ((functionValidator?.call(message) ?? true) == false) {
      if (errorMessage != null) {
        Console.writeLine(red('❌  $errorMessage'));
      }
      Console.writeLine(consoleMessage);
      message = Console.readLineSync()?.trim();
    }
    return message;
  }
}
