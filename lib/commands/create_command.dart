import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:mason_logger/mason_logger.dart';

import 'package:emily/constants/constants.dart';
import 'package:emily/services/services.dart';
import 'package:emily/utils/utils.dart';

class CreateCommand {
  static Future<void> flutterTemplate() async {
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
      Console.writeLine(dcli.red('❌  Failed to create Flutter project: ${process.stderr}'));
      exit(1);
    }

    await FileModifier.changeAppName(
      projectName: projectName ?? 'example_app',
      appName: appName ?? 'Example App',
      path: projectPath
    );

    final directories = [
      'assets/fonts',
      'assets/icons',
      'assets/images',
      'assets/launcher_icon',
      'assets/splash',
      'lib/api/dto',
      'lib/api/requests',
      'lib/init',
      'lib/features',
      'lib/core',
      'lib/repositories',
      'lib/router',
      'lib/ui/images',
      'lib/ui/icons',
      'lib/ui/theme',
      'lib/ui/widgets',
      'lib/utils/mixin',
      'lib/utils/extensions',
      'docs'
    ];

    DirectoryService.buildStructure(projectPath: projectPath, directories: directories);

    Console.writeLine(dcli.green('✅  The project was created successfully!'));
  }

  static Future<void> keystore() async {
    final keystoreName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterKeyName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidProjectName
    );

    final projectPath = DirectoryService.getValidProjectPath('android');

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
      exit(1);
    }

    Console.writeLine(dcli.green('✅  (1/2) The key was created successfully!'));

    final content = '''
storePassword=$password
keyPassword=$password
keyAlias=upload
storeFile=$keystoreName.jks
    ''';

    FileService.createFile(filePath: '$projectPath/android/key.properties', content: content);
    FileModifier.addContentToBuildGradle(projectPath);

    Console.writeLine(dcli.green('✅  (2/2) Data written successfully!'));
  }

  static Future<void> feature() async {
    final featureName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterFeatureName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidSingleString
    ).snakeCase();

    final projectPath = DirectoryService.getValidProjectPath('lib/features');

    final directories = [
      'lib/features/$featureName',
      'lib/features/$featureName/logic',
      'lib/features/$featureName/logic/utils',
      'lib/features/$featureName/view',
      'lib/features/$featureName/view/widgets',
      'lib/features/$featureName/models'
    ];

    await DirectoryService.buildStructure(projectPath: projectPath, directories: directories);

    FileService.createFile(
        filePath: '$projectPath/lib/features/$featureName/$featureName.dart',
        content: '''export 'view/view.dart';'''
    );
    FileService.createFile(filePath: '$projectPath/lib/features/$featureName/logic/utils/utils.dart');
    FileService.createFile(filePath: '$projectPath/lib/features/$featureName/view/view.dart');
    FileService.createFile(filePath: '$projectPath/lib/features/$featureName/view/widgets/widgets.dart');
    FileService.createFile(filePath: '$projectPath/lib/features/$featureName/models/models.dart');

    Console.writeLine(dcli.green('✅  The folder structure for feature has been successfully created!'));
  }

  static Future<void> bloc() async {
    final blocName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterBlocName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidSingleString
    ).snakeCase();

    final blocClassName = blocName.toCamelCase();
    final path = DirectoryService.choosePath();

    FileService.createFile(
        filePath: '$path/${blocName}_bloc.dart',
        content: '''
part '${blocName}_event.dart';
part '${blocName}_state.dart';

class ${blocClassName}Bloc extends Bloc<${blocClassName}Event, ${blocClassName}State> {
  ${blocClassName}Bloc() : super(${blocClassName}Initial()) {
    on<Example>(_example);
  }
  
  Future<void> _example(
    Example event,
    Emitter<${blocClassName}State> emit
  ) async {
    
  }
}
        '''
    );

    FileService.createFile(
        filePath: '$path/${blocName}_event.dart',
        content: '''
part of '${blocName}_bloc.dart';

sealed class ${blocClassName}Event extends Equatable {
  const ${blocClassName}Event();
  
  @override
  List<Object> get props => [];
}

final class Example extends ${blocClassName}Event {}
        '''
    );

    FileService.createFile(
        filePath: '$path/${blocName}_state.dart',
        content: '''
part of '${blocName}_bloc.dart';

sealed class ${blocClassName}State extends Equatable {
  @override
  List<Object> get props => [];
}

final class ${blocClassName}Initial extends ${blocClassName}State {}

final class ${blocClassName}Loading extends ${blocClassName}State {}

final class ${blocClassName}Loaded extends ${blocClassName}State {}

final class ${blocClassName}Failure extends ${blocClassName}State {
  ${blocClassName}Failure(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}
        '''
    );

    Console.writeLine(dcli.green('✅  Bloc successfully created!'));
  }

  static Future<void> cubit() async {
    final cubitName = InputService.getValidatedInput(
        consoleMessage: Constants.kEnterBlocName,
        errorMessage: Constants.kInvalidValue,
        functionValidator: Validator.isValidSingleString
    ).snakeCase();

    final cubitClassName = cubitName.toCamelCase();
    final path = DirectoryService.choosePath();

    FileService.createFile(
        filePath: '$path/${cubitName}_cubit.dart',
        content: '''
part '${cubitName}_state.dart';

class ${cubitClassName}Cubit extends Cubit<${cubitClassName}State> {
  ${cubitClassName}Cubit() : super(${cubitClassName}State());
  
}
        '''
    );

    FileService.createFile(
        filePath: '$path/${cubitName}_state.dart',
        content: '''
part of '${cubitName}_cubit.dart';

class ${cubitClassName}State extends Equatable {
  const ${cubitClassName}State();
  
  @override
  List<Object> get props => [];
}
        '''
    );

    Console.writeLine(dcli.green('✅  Cubit successfully created!'));
  }
}
