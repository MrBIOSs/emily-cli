import 'package:dcli/dcli.dart';

import 'package:emily/constants/constants.dart';
import 'package:emily/services/services.dart';
import 'package:emily/utils/utils.dart';

class AddCommand {
  static Future<void> package() async {
    final projectPath = DirectoryService.getValidProjectPath('lib');

    final packageName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterPackageName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidSingleString
    ).snakeCase();

    await ScriptService.addPackages(packages: [packageName], projectPath: projectPath);
    await ScriptService.flutterPubGet(projectPath);

    Console.writeLine(green('✅  Done!'));
  }

  static Future<void> nativeSplash() async {
    final projectPath = DirectoryService.getValidProjectPath('lib');

    await ScriptService.addPackages(
        packages: ['flutter_native_splash'],
        isDevDependency: true,
        projectPath: projectPath
    );
    await ScriptService.flutterPubGet(projectPath);

    final content = '''
flutter_native_splash:
  fullscreen: true
  color: "#ffffff"
  image: assets/splash/splash.png
  color_dark: "#121212"
  # image_dark: assets/splash/splash_dark.png

  android_12:
    color: "#ffffff"
    image: assets/splash/splash.png
    color_dark: "#121212"
    # image_dark: assets/splash/splash_dark.png
  
  android: true
  ios: true
  web: false
    ''';

    FileService.createFile(filePath: '$projectPath/flutter_native_splash.yaml', content: content);

    Console.writeLine(green('✅  Done!'));
  }
}