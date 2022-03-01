import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telsavideo/appBehaviour/my_behaviour.dart';
import 'package:telsavideo/screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        indicatorColor: Colors.white,
        tabBarTheme: TabBarTheme(),
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
    );
  }
}
