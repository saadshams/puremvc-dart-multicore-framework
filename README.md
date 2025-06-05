## [PureMVC](http://puremvc.github.com/) Dart MultiCore Framework [![Dart](https://github.com/saadshams/puremvc-dart-multicore-framework/actions/workflows/dart.yml/badge.svg)](https://github.com/saadshams/puremvc-dart-multicore-framework/actions/workflows/dart.yml)

PureMVC is a lightweight framework for creating applications based upon the classic [Model-View-Controller](http://en.wikipedia.org/wiki/Model-view-controller) design meta-pattern. This is a Dart port of the [AS3 reference implementation of the MultiCore Version](https://github.com/PureMVC/puremvc-as3-multicore-framework/wiki). It supports [modular programming](http://en.wikipedia.org/wiki/Modular_programming) through the use of [Multiton](http://en.wikipedia.org/wiki/Multiton) Core actors.

* [Package](http://pub.dartlang.org/packages/puremvc)
* [API Docs](http://puremvc.org/pages/docs/Dart/multicore/puremvc.html)

## Installation
`dart pub add puremvc`

## Development

#### Dart SDK Setup
* **Mac**
  1. Install Homebrew if it's not already installed. https://brew.sh
  2. Add the official tap.
     `brew tap dart-lang/dart`
  3. Install Dart SDK:
     `brew install dart`
* **Windows**
  1. Install Chocolatey. https://chocolatey.org/install
  2. Install Dark SDK:
     `choco install dart-sdk`

* **Alternate Option:** You can also use the Dart SDK bundled with [Flutter SDK](https://docs.flutter.dev/get-started/install) at `flutter/bin/cache/dart-sdk`.

#### Add Dart to PATH:
* **Mac**
    1. Add to the path: `echo 'export PATH="/opt/homebrew/opt/dart/bin:$PATH"' >> ~/.zshrc`
    2. Apply the changes: `source ~/.zshrc`

* **Windows**
  - Add to Start > System Environment Variables > Environment Variables > System variables
  - `C:\ProgramData\chocolatey\lib\dart-sdk\tools\dart-sdk\bin`

* **Verify:** `dart --version`

#### Android Studio Dart SDK Path:
* **Install Dart Plugin:** Go to Android Studio -> Settings -> Plugins -> Search for Dart, then click Install
* **Enable Dart for Your Project:** Go to Android Studio -> Settings -> Languages and Frameworks -> Dart
  * Check Enable Dart Support for the project 'project-name'
  * Under Dart Support for Modules, ensure all modules are selected
* **Mac**: `/opt/homebrew/opt/dart/libexec`
* **Windows**: `C:\ProgramData\chocolatey\lib\dart-sdk\tools\dart-sdk\bin`

**Test:** `dart test`  
**Documentation:** `dart doc && open doc/api/index.html`  
**Publish:** `dart pub publish --dry-run` || `dart pub publish`  

---

## Demos
* [Reverse Text](https://github.com/PureMVC/puremvc-dart-demo-reversetext/wiki)

## Status
Production - [Version 2.1.0](https://github.com/PureMVC/puremvc-dart-multicore-framework/blob/master/VERSION)

## Platforms / Technologies
* [Google Dart](http://www.dartlang.org)
* [Flutter](https://en.wikipedia.org/wiki/Flutter_(software))

## License
* PureMVC MultiCore Framework for Dart - Copyright © 2025 [Cliff Hall](https://www.linkedin.com/in/cliff/), [Saad Shams](https://www.linkedin.com/in/muizz/)
* PureMVC - Copyright © 2006-2025 [Futurescale, Inc](http://futurescale.com).
* All rights reserved.

* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
   * Neither the name of Futurescale, Inc., PureMVC.org, nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
