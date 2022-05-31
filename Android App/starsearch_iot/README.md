# StarSearch Android Application
## Installation Instructions

Steps to run the application:
1. Download this package as a ZIP file.
2. Unzip the ZIP file with the folder name: `starsearch_iot`
3. Open Visual Studio Code (VS Code)
4. Locate the project folder in VS Code
```
Note: Installation of Android Studio, Flutter and Dart required.
> Details on setting up Android Studio: https://flutter.dev/docs/get-started/install 
> Details on installing Flutter and Dart in VS Code: https://flutter.dev/docs/development/tools/vs-code
```
5. Inside the terminal, type in `flutter clean`. This ensures all dependencies are not based on the developer's computer.
6. After cleanup, open the Android Phone Emulator in Android Studio OR plug in a compatible Android smartphone in USB debugging mode.
```
Note: Minimum version of Android - Android 6.0 Marshmallow.
> Details on setting up an Android Phone Emulator in Android Studio: https://developer.android.com/studio/run/emulator
> Details on setting up USB Debugging mode: https://developer.android.com/studio/debug/dev-options
```
7. Inside the same terminal, type in `flutter pub get`. This allows all required external packages to be installed inside VS Code.
8. Type in `flutter run` after installation is complete. This sets up the file structures based on your system in VS Code.
9. After building, you might need to run the application manually. Type in `F5` (Run in debugging mode) or `Ctrl+F5` (Run without debugging) to install the APK into the Android device.
