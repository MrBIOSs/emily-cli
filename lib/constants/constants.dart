import 'dart:io';

class Constants {
  static const kLogo = '''
  ░▒▓████████▓▒░▒▓██████████████▓▒░░▒▓█▓▒░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░    ░▒▓██████▓▒░  
  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     
  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░     
  ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░ 
  ''';
  static const kCreateCommand = 'create';
  static const kConnectCommand = 'connect';
  static const kHelpCommand = 'help';

  static const kUpdateDartVersion = 'Please update your version of Dart.';

  static final kCurrentPath = Directory.current.path;
  static const kEnterProjectName = 'Enter a project name: ';
  static const kEnterValidProjectName = 'Please enter a valid project name (example_app): ';
  static const kNeedSpecifyPath = 'Do you need specify path? Note if you select "No" project will be created '
      'in a current location (Yes/No): ';
  static const kYes = 'yes';
  static const kNo = 'no';
  static const kEnterPath = 'Please specify the path where you want to create the project: ';
  static const kInvalidPath = 'Invalid path. Please specify a valid path: ';
  static const kAppName = 'Please specify the app display name: ';
  static const kInvalidValue = 'Invalid value';
  static const kAppOrgBundle = 'Please specify org bundle id (com.example): ';
  static const kProjectDescription = 'Please specify project description: ';
  static const kChoosePlatform = 'Please choose the platforms: ';

  static const kEnterProjectPath = 'Please specify the path to the project: ';
  static const kUsernameGithub = 'Please specify your github username: ';
  static const kRepositoryGithub = 'please specify the name of the github repository: ';
}
