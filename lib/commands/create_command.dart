import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:mason_logger/mason_logger.dart';

import 'package:emily/constants/constants.dart';
import 'package:emily/services/services.dart';
import 'package:emily/utils/utils.dart';

class CreateCommand {
  static Future<void> flutterTemplate() async {
    if (await Validator.checkVersion()) return;

    final logger = Logger();

    final projectName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterProjectName,
        errorMessage: Constants.kEnterValidProjectName,
        functionValidator: Validator.isValidProjectName
    );

    final path = DirectoryService.choosePath();
    final projectPath = '$path/$projectName';

    final appName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterAppName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidAppName
    );

    final appOrgBundle = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterAppOrgBundle,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidOrgBundle
    );

    final projectDescription = InputService.getValidatedInput(
      consoleMessage: Constants.kEnterProjectDescription,
      errorMessage: Constants.kInvalidValue
    );

    final listPlatforms = logger.chooseAny(
        Constants.kChoosePlatform,
        choices: <String>['ios', 'android', 'windows', 'linux', 'macos', 'web'],
        defaultValues: <String>['ios', 'android', 'windows', 'linux', 'macos', 'web']
    );
    final platforms = listPlatforms.join(',');
    
    final process = Process.runSync(
      'flutter',
      <String>[
        'create',
        '--empty',
        '--project-name=$projectName',
        '--description=$projectDescription',
        '--org=$appOrgBundle',
        '--platforms=$platforms',
        projectPath
      ],
      runInShell: true
    );

    if (process.exitCode != 0) {
      Console.writeLine(dcli.red('Failed to create Flutter project: ${process.stderr}'));
    }

    await FileModifier.changeAppName(
      projectName: projectName ?? 'example_app',
      appName: appName ?? 'Example App',
      path: projectPath
    );

    DirectoryService.buildStructure(projectPath);

    Console.writeLine(dcli.green('✅  The project was created successfully!'));
  }

  static Future<void> keystore() async {
    if (await Validator.checkVersion()) return;

    final keystoreName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterKeyName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidProjectName
    );

    String path = DirectoryService.choosePath();
    String? projectPath;

    while (Validator.isValidPath('$path/android') == false) {
      Console.writeLine(dcli.red('❌  Project folder not found'));
      path = InputService.getValidatedInput(
          consoleMessage: Constants.kEnterPath,
          errorMessage: Constants.kInvalidPath,
          functionValidator: Validator.isValidPath
      ) ?? '';
    }

    projectPath = path;

    final password = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterKeyPassword,
        errorMessage: Constants.kInvalidPassword,
        functionValidator: Validator.isValidPassword
    );

    final name = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidName
    );

    final orgName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterOrg,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidName
    );

    final city = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterCity,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidName
    );

    final state = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterState,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidName
    );

    final countryCode = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterCountryCode,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidString
    );

    final inputData = [
      password,
      password,
      name,
      'Unknown',
      orgName,
      city,
      state,
      countryCode!.toUpperCase(),
      'yes'
    ];

    final process = await Process.start(
        'keytool',
        <String>[
          '-genkeypair',
          '-v',
          '-keystore',
          '$keystoreName.jks',
          '-keyalg',
          'RSA',
          '-keysize',
          '2048',
          '-validity',
          '10000',
          '-alias',
          'upload'
        ],
        workingDirectory: '$projectPath/android/app',
        runInShell: true
    );

    process.stdout.transform(SystemEncoding().decoder).listen((data) {
      Console.write(data);
    });
    process.stderr.transform(SystemEncoding().decoder).listen((data) {
      Console.write(data);
    });

    for (var data in inputData) {
      process.stdin.writeln(data);
    }

    await process.stdin.close();

    if (await process.exitCode != 0) {
      Console.writeLine(dcli.red('❌  Failed to create key: ${process.stderr}'));
    }

    Console.writeLine(dcli.green('✅  (1/2) The key was created successfully!'));

    final file = File('$projectPath/android/key.properties');
    final content = '''
storePassword=$password
keyPassword=$password
keyAlias=upload
storeFile=$keystoreName.jks
    ''';

    await file.writeAsString(content);

    FileModifier.addContentToBuildGradle(projectPath);

    Console.writeLine(dcli.green('✅  (2/2) Data written successfully!'));
  }
}
