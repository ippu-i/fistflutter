#!/bin/bash エラーが発生した際スクリプトを終了するコマンド
set -euxo pipefail

## Install Flutter
cd /workspaces/
git clone https://github.com/flutter/flutter.git -b stable

sudo apt-get update
sudo apt-get install clang build-essential cmake ninja-build pkg-config gtk-3.0

cd /workspaces/fistflutter/first_flutter/

flutter --version
flutter pub global activate melos
flutter pub global activate grinder
flutter pub get --no-example
dart pub get --no-example

exit 0

