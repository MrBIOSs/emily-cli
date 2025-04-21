
# Emily Assistant
Command Line Interface (CLI) to create a Flutter project and automate routine processes.

The assistant knows how to:
- Create a Flutter project template.
- Connect to a remote repository in Github.
- generate a keystore file.

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

**Connect a remote Github repository:**
```sh
emily connect -github
```
