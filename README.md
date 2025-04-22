<p style="text-align: center;">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"  alt=""/>
  <img src="https://img.shields.io/badge/MIT-green?style=for-the-badge"  alt=""/>
</p>
<br />

# Emily Assistant
Command Line Interface (CLI) to create a Flutter project and automate routine processes.

The assistant knows how to:
- Create a Flutter project template.
- Connect to a remote repository in Github.
- Generate a keystore file.
- Create a folder structure for the feature.
- Create a bloc and cubit template.
- Add packages to the project.

## Getting Started
Activate globally:
```sh
dart pub global activate emily
```
or
```sh
dart pub global activate --source path /path/to/emily
```

## Available commands

**Create a Flutter project template:**
```sh
emily create -template
```

**Generate a keystore file:**
```sh
emily create -key
```

**Create a folder structure for the feature:**
```sh
emily create -feature
```

**Create a bloc template (bloc, state, event):**
```sh
emily create -bloc
```

**Create a cubit template (cubit, state):**
```sh
emily create -cubit
```

**Connect a remote Github repository:**
```sh
emily connect -github
```

**Add package to pubspec:**
```sh
emily add package
```

**Add package flutter_native_splash to pubspec:**
```sh
emily add -flutter_native_splash
```
