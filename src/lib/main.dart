// ADD THIS IMPORT
import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/Routes/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:telsavideo/screens/login.dart';

import 'components/api.dart';

var videoData;

// analytics
FirebaseAnalytics analytics = new FirebaseAnalytics();
var pubIndex = 0;

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (!kReleaseMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZoned<Future<Null>>(() async {
    // ADD THIS LINE
    //debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});

    var _temp = {"user": await retrieveData("user")};
    user = _temp["user"];

    // set theme
    var _tempTheme = await retrieveData("theme");
    if (_tempTheme != null && _tempTheme != "value") {
      print(_tempTheme);
      selectedTheme = _tempTheme;
    } else {
      selectedTheme = "normal";
    }

    var internet = true;

    // first start
    dynamic _tempBuildNumber = "0";
    int buildNumber = 1;
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      buildNumber = int.parse(packageInfo.buildNumber);
      //tempBuildNumber = await retrieveData("buildNumber");
    } catch (e) {}

    if (_tempBuildNumber == null ||
        int.parse(_tempBuildNumber) < buildNumber && user == null) {
      saveData("gateway", "https://video.dtube.top/ipfs/");
      saveData("buildNumber", buildNumber.toString());
      runApp(MyApp());
    } else {
      runApp(MyApp());
    }

    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('{$error $stackTrace}');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('he', 'IL'), // Hebrew
        const Locale('zh', 'CN'),
        // ... other locales the app supports
      ],
      //debugShowCheckedModeBanner: true,
      title: 'DTok',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        //fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
