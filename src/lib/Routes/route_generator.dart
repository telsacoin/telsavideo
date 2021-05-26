import 'package:flutter/material.dart';
import 'package:telsavideo/Screens/homeScreen.dart';
import 'package:telsavideo/Screens/loginScreen.dart';

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
        return MaterialPageRoute(builder: (_) => Container());
      case '/live':
        return MaterialPageRoute(builder: (_) => Container());
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
          child: Text('Error'),
        ),
      );
    });
  }
}
