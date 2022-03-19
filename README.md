

[English](readme_cn.md)|[中文](readme_cn.md)

## DTok Video App 

> DTok is a community powered video sharing app platform where users vote on videos to reward creators, curators, influences and viewers in cryptocurrency, like a decentralized Tiktok.



## User Flutter to Imitate of the foreign version of Tiktok, this project is continuously updated

### Open source is not easy, please give it a Star★ (☺️ click ★Star in the upper right corner, easy, one second 🤣)! I will continue to update the code according to everyone's attention and personal time!



### The background service uses SpringCloud + IPFS storage + BSC chain

- front-end address： https://www.pgyer.com/dtok

- Backend server address: http://47.95.209.198:8181/

## Preview



![app](assets/app.gif)



## Supported Platforms

- Linux
- Windows

- Android
- IOS



### Working with Uploads

- Video module
- Recommended modules
- Message module
- upload module
- Personal module

## Structure



## Common Issues

While adding an app on your Firebase Project, cross-check your android application's package name (e.g com.example.application) which you will find on AndroidManifest.xml or, build.gradle (app level) file. If the package name is wrong adding SHA1 or SHA512 won't be helpful.

Follow the Firebase SDK Instructions properly. Add the required lines of code which they are recommending you to add.

Don't forget to add the SHA1 or SHA512 to your project which you can easily generate using the following command using the terminal of Android Studio.
```bash
cd android 
gradlew signingReport
Use the command flutter clean on the terminal before running the application.
```

Following the Firebase SDK Instructions properly will save you lots of time.

# generate model
```bash
 flutter pub run build_runner build
```

# the color of button
https://www.cnblogs.com/dalianpai/p/12347272.html
```html
buttom
background-color: #e33100!important;
box-shadow: 0 15px 18px -6px rgb(227 49 0 / 65%)
```


# add app icon  common
```bash
flutter pub run flutter_launcher_icons:main
```

# build apk
```bash
flutter clean && flutter pub get && flutter pub cache repair &&  flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --no-shrink
```


# known issue
```
../../../development/flutter/packages/flutter/lib/src/material/scaffold.dart:1963:24: Context: Found this candidate, but the arguments don't match.
  311 line
  final ScaffoldState scaffold = Scaffold.of(context);
  static ScaffoldState of(BuildContext context) {
```

# check the dependencies between the packages
```bash
flutter pub deps
```

# uninstall the app from mobile
```bash
source ~/.bash_profile
adb uninstall "com.telsa.dtok"
```

# how to setup build apk
https://github.com/marketplace/actions/flutter-action

# upgrade gradlew
```bash
./gradlew wrapper --gradle-version 7
```

# ios build
```bash
flutter clean \
        && rm ios/Podfile.lock pubspec.lock \
        && rm -rf ios/Pods ios/Runner.xcworkspace
```

# upgrade package
```bash
flutter pub upgrade --major-versions
```



## Contributing

If you want to contribute to the project, please read [this page](https://github.com/TelsaCoin/TelsaVideo/wiki/contribute).

