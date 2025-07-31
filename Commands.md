for injection
⁠ shell
 flutter packages pub run build_runner clean
 flutter packages pub run build_runner build
 ⁠

prepare ios
⁠ shell
 flutter clean
 flutter pub get
cd ios
pod install
cd ..
 ⁠

apply dart fixes
⁠ shell
dart fix --apply
 ⁠

launch icon
⁠ shell
 flutter pub run flutter_launcher_icons
 ⁠
splash
⁠ shell
 flutter pub run flutter_native_splash:create
 ⁠

change package
⁠ shell
dart run change_app_package_name:main com.wingora.app
 ⁠

change app name
⁠ shell
dart run rename_app:main all="Wingora"
 ⁠
get sha
⁠ shell
cd android
./gradlew signingReport
 ⁠
generate assets
⁠ shell
fluttergen -c pubspec.yaml
 ⁠

generate file that contains localization keys
⁠ shell
 flutter pub run easy_localization:generate -S "assets/translations" -O "lib/common/resources/gen" -o "locale_keys.g.dart" -f keys
