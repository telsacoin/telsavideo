import 'package:flutter/material.dart';
import 'package:telsavideo/accounts/hiveaccount.dart';
import 'package:telsavideo/screens/home/home.dart';
import 'package:telsavideo/screens/login.dart';
import 'package:telsavideo/screens/profile/profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/login':
        if (args is String) {}
        return MaterialPageRoute(builder: (_) => Login());
      case '/search':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/live':
        return MaterialPageRoute(builder: (_) => Container());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/hive':
        return MaterialPageRoute(builder: (_) => HiveAccount());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Oops! something went wrong!'),
        ),
        body: Center(
          child: Text('App Error'),
        ),
      );
    });
  }
}
