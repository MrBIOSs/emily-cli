import 'dart:io';

class Console {
  static void write(Object? object) {
    stdout.write(object);
  }

  static void writeLine([Object? object = ""]) {
    stdout.writeln(object);
  }

  static String? readLineSync() => stdin.readLineSync();
}
