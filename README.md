<p align="center"><img align="center" src=".\assets\dtok_1.png" style="width:200px;"/></p>
<h1 align="center"><a href="https://telsacoin.io/">DTOK</a></h1>


#####  [DTIK Admin](https://github.com/telsacoin/admin) | [Website](https://telsacoin.io/) | [Blog](https://telsacoin.io//blog) | [Telegram](https://t.me/tslacoingoup) | [Twitter](https://twitter.com/tlsacoin) | [Documentation](https://docs.telsacoin.io/) | [Donate](https://liberapay.com/telsacoin/donate)

**[English](readme.md) | [中文](readme_cn.md)**

> DTok is a community powered video sharing app platform where users vote on videos to reward creators, curators, influences and viewers in cryptocurrency, like a decentralized Tiktok.



# The Open Source Tiktok Alternative

> this project is continuously updated,Open source is not easy, please give it a Star★ (☺️ click ★Star in the upper right corner, easy, one second 🤣)! I will continue to update the code according to everyone's attention and personal time!



## The background service uses SpringCloud + IPFS storage + BSC chain
- Front-end app： https://www.pgyer.com/dtok
- Backend admin panel: http://47.95.209.198:8181/

# Preview

<img src="assets/app.gif" alt="app" style="width:80%;" />

# Quickstart
1. Clone repository
   ```shell
   git clone https://github.com/telsacoin/telsavideo.git
   ```
2. Get packages
   ```shell
   fluter pub get
   ```
3. Start your app
   ```shell
   flutter run 
   ```
4. Use the API
   ```shell
   \minio.exe server d:\minio\data --console-address ":9001"
   ```

5. Build apk

   ```shell
   flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --no-shrink
   ```

# Supported Platforms

- Linux
- Windows
- Android
- IOS

# Features
- Video module
- Recommended modules
- Message module
- upload module
- Personal module



# Common Issues
​		While adding an app on your Firebase Project, cross-check your android application's package name (e.g com.example.application) which you will find on AndroidManifest.xml or, build.gradle (app level) file. If the package name is wrong adding SHA1 or SHA512 won't be helpful.

Follow the Firebase SDK Instructions properly. Add the required lines of code which they are recommending you to add.

Don't forget to add the SHA1 or SHA512 to your project which you can easily generate using the following command using the terminal of Android Studio.
```bash
cd android 
gradlew signingReport
Use the command flutter clean on the terminal before running the application.
```

Following the Firebase SDK Instructions properly will save you lots of time.

# Generate model

```bash
 flutter pub run build_runner build
```

# The color of button

https://www.cnblogs.com/dalianpai/p/12347272.html
```html
buttom
background-color: #e33100!important;
box-shadow: 0 15px 18px -6px rgb(227 49 0 / 65%)
```


# Add app icon  common
```bash
flutter pub run flutter_launcher_icons:main
```

# Build apk
```bash
flutter clean && flutter pub get && flutter pub cache repair &&  flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --no-shrink
```


# Known issue
```
../../../development/flutter/packages/flutter/lib/src/material/scaffold.dart:1963:24: Context: Found this candidate, but the arguments don't match.
  311 line
  final ScaffoldState scaffold = Scaffold.of(context);
  static ScaffoldState of(BuildContext context) {
```

# Check the dependencies between the packages
```bash
flutter pub deps
```

# Uninstall the app from mobile
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

