import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;

import 'package:emily/constants/constants.dart';
import 'package:emily/services/script_service.dart';
import 'package:emily/utils/console.dart';

/// This class provides a set of static methods to validate different types of
/// input strings
class Validator {
  /// Regular expression for a string containing only alphabetical characters
  static final _onlyStringRegex = RegExp(r'^[a-zA-Z]+$');

  /// Regular expression for a string in snake_case format
  /// (lowercase letters separated by underscores)
  static final _snakeCaseRegex = RegExp(r'^[a-z]+(_[a-z]+)*$');
  static final _appNameRegex = RegExp(r'^[^\n\t\r\f\v]{1,255}$');
  static final _nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final _orgPackageRegex = RegExp(r'^[a-zA-Z0-9_]+(\.[a-zA-Z0-9_]+)*$');
  static final _repositoryGithubRegex = RegExp(r'^[a-zA-Z-_]+$');
  static final _passwordRegex = RegExp(r'^[a-zA-Z0-9]+$');

  static Future<bool> checkVersion() async {
    final isOldVersion = await ScriptService.isDartOldVersion('3.7.2');

    if (isOldVersion) {
      Console.writeLine(dcli.red(Constants.kUpdateDartVersion));
    }
    return isOldVersion;
  }

  /// Returns true if the given project name is valid
  ///
  /// A valid project name is either a only string or a snake_case string
  /// If the [name] parameter is null, the method returns false
  static bool isValidProjectName(String? name) {
    if (name == null) return false;

    return (_onlyStringRegex.hasMatch(name) || _snakeCaseRegex.hasMatch(name));
  }

  static bool isValidPassword(String? password) {
    if (password == null) return false;
    if (password.length < 6) return false;

    return _passwordRegex.hasMatch(password);
  }

  /// Returns true if the given path exists
  ///
  /// If the [path] parameter is null, the method returns false
  static bool isValidPath(String? path) {
    if (path == null) return false;

    final directory = Directory(path);
    return directory.existsSync();
  }

  static bool isValidName(String? input) {
    return _isValidInput(input, _nameRegex);
  }

  static bool isValidAppName(String? input) {
    return _isValidInput(input, _appNameRegex);
  }

  static bool isValidOrgBundle(String? input) {
    return _isValidInput(input, _orgPackageRegex);
  }

  static bool isValidString(String? input) {
    return _isValidInput(input, _onlyStringRegex);
  }

  static bool isValidRepositoryGithub(String? input) {
    return _isValidInput(input, _repositoryGithubRegex);
  }

  static bool _isValidInput(String? input, RegExp regex) {
    if (input == null) return false;

    return regex.hasMatch(input.trim());
  }
}
