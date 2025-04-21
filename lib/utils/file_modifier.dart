import 'dart:io';

import 'package:emily/services/file_service.dart';

class FileModifier {
  static const _pubspecPath = 'pubspec.yaml';
  static const _fileGradlePath = '/android/app/build.gradle';
  static const _fileGradleKtsPath = '/android/app/build.gradle.kts';
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

  static Future<void> addContentToBuildGradle(String projectPath) async {
    String? filePath;
    if (File(projectPath + _fileGradlePath).existsSync()) {
      filePath = projectPath + _fileGradlePath;
    } else {
      filePath = projectPath + _fileGradleKtsPath;
    }

    final file = File(filePath);
    String content = await file.readAsString();

    final keystorePropertiesBlock = '''
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
    ''';

    content = content.replaceFirst('android {', '$keystorePropertiesBlock \nandroid {');

    content = content.replaceFirst(
      'signingConfig = signingConfigs.getByName("debug")',
      'signingConfig = signingConfigs.release'
    );

    final signingConfigsBlock = '''
signingConfigs {
        release {
            keyAlias = keystoreProperties['keyAlias']
            keyPassword = keystoreProperties['keyPassword']
            storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword = keystoreProperties['storePassword']
        }
    }
    ''';

    content = content.replaceFirst('buildTypes {', '$signingConfigsBlock \n    buildTypes {');

    await file.writeAsString(content);
  }
}