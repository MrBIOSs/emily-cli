import 'dart:io';

/// This class provides functions to update file content, append to files,
/// and remove trailing commas.
class FileService {
  /// Removes the trailing comma from the given [input] string, if present.
  ///
  /// Returns the modified string or null if [input] is null.
  static String? removeTrailingComma(String? input) {
    if (input != null) {
      if (input.endsWith(',')) {
        return input.substring(0, input.length - 1);
      } else {
        return input;
      }
    }
    return null;
  }

  /// Updates the contents of the file at the given [filePath] by replacing
  /// all occurrences of [oldString] with [newString].
  ///
  /// Throws an exception if the file cannot be read or written to.
  static Future<void> updateFileContent({
    required String oldString,
    required String newString,
    required String filePath
  }) async {
    final file = File(filePath);
    String content = await file.readAsString();
    content = content.replaceAll(oldString, newString);
    await file.writeAsString(content);
  }
}
