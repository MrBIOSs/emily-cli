import 'package:emily/services/file_service.dart';

class Renamer {
  static const _pubspecPath = 'pubspec.yaml';
  static const _fileGradlePath = '/android/app/build.gradle';
  static const _fileAndroidManifestPath = '/android/app/src/main/AndroidManifest.xml';

  static Future<void> changeAppName({
    required String projectName,
    required String appName,
    required String path
  }) async {

    await FileService.updateFileContent(
      oldString: projectName,
      newString: appName,
      filePath: path + _fileAndroidManifestPath
    );
  }
}