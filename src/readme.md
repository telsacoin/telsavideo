

While adding an app on your Firebase Project, cross-check your android application's package name (e.g com.example.application) which you will find on AndroidManifest.xml or, build.gradle (app level) file. If the package name is wrong adding SHA1 or SHA512 won't be helpful.

Follow the Firebase SDK Instructions properly. Add the required lines of code which they are recommending you to add.

Don't forget to add the SHA1 or SHA512 to your project which you can easily generate using the following command using the terminal of Android Studio.

cd android 
gradlew signingReport
Use the command flutter clean on the terminal before running the application.

Following the Firebase SDK Instructions properly will save you lots of time.

# the project structure
[lib\screen
[lib\models
[lib\service

# generate model
`
 flutter pub run build_runner build
`


https://www.cnblogs.com/dalianpai/p/12347272.html
buttom
background-color: #e33100!important;
box-shadow: 0 15px 18px -6px rgb(227 49 0 / 65%)



# add app icon  common
`
flutter pub run flutter_launcher_icons:main
`

# build apk
`
flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --no-sound-null-safety
`


# known issue
`
../../../development/flutter/packages/flutter/lib/src/material/scaffold.dart:1963:24: Context: Found this candidate, but the arguments don't match.
  311 line
  final ScaffoldState scaffold = Scaffold.of(context);
  static ScaffoldState of(BuildContext context) {
`


