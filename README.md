<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

PureMVC Dart [![Dart](https://github.com/saadshams/puremvc-dart-multicore-framework/actions/workflows/dart.yml/badge.svg)](https://github.com/saadshams/puremvc-dart-multicore-framework/actions/workflows/dart.yml)


## Development
### Install Dependencies
dart pub get

### Generate Documentation
dart doc
open doc/api/index.html

### Publish
dart pub publish --dry-run
dart pub publish


### Dart SDK
- Install Homebrew if needed. 
-  Add the official tap.
   brew tap dart-lang/dart
- Install the Dart SDK.
* brew install dart

### Append to PATH
echo 'export PATH="/opt/homebrew/opt/dart/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

Android Studio: SDK Path: /opt/homebrew/opt/dart/libexec

Alternate: Download Flutter SDK and use the dart SDK provided with it. 