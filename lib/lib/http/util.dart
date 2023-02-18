import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  /// change the app theme
  var selectedTheme = "normal";
  dynamic theme(String mode) {
    switch (mode) {
      case "blue":
        return {
          "primary": Colors.blue,
          "accent": Colors.grey,
          "text": Colors.black,
          "background": Colors.white
        };
      case "black":
        return {
          "primary": Colors.red,
          "accent": Colors.white,
          "text": Colors.white,
          "background": Colors.black
        };
      case "normal":
        return {
          "primary": Colors.red,
          "accent": Colors.grey,
          "text": Colors.black,
          "background": Colors.white
        };
    }
  }

  static set(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is DateTime) {
      prefs.setString(key, value.toString());
    } else if (value is num) {
      prefs.setInt(key, int.parse(value.toString()));
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List) {
      prefs.setStringList(key, value.cast<String>());
    }
  }

  static getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? data = prefs.getInt(key);
    return data ?? null;
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data ?? null;
  }

  static getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? data = prefs.getDouble(key);
    return data ?? null;
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? data = prefs.getBool(key);
    return data ?? null;
  }

  static getStringList<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List data = prefs.getStringList(key)!.toList();
    return data;
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void saveData(var key, var data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  void saveDataMap(var key, List<String> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
  }

  retrieveData(var key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(key));
  }

  retrieveDataMap(var key) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(key));
  }

  String linkify(String text) {
    text = text.replaceAll("\\n", "\n");
    var urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var result = new RegExp(urlPattern, caseSensitive: false).allMatches(text);

    for (Match m in result) {
      String? match = m.group(0);
      text = text.replaceFirst(
          match!, "<a href=\"" + match + "\">" + match + "</a>");
    }
    return text;
  }

  toast(context, text) {
    double _tempSpeed = text.length / 10;
    return Scaffold.of(context).showBottomSheet((context) =>
        // ignore: deprecated_member_use
        (new SnackBar(
          content: new Text(text),
          duration: Duration(seconds: _tempSpeed.round()),
        )));
  }

  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  // initializeNotifications() {
  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('ic_launcher');
  //   var initializationSettingsIOS = new IOSInitializationSettings();
  //   var initializationSettings = new InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  //   flutterLocalNotificationsPlugin!.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification);
  // }

  Future<dynamic> onSelectNotification(String? payload) async {
    debugPrint('notification payload: ' + payload!);
    //OpenFile.open("/storage/emulated/0/Download/" + payload);
    /*await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    )*/
  }

  // Future showNotification(String title, var body) async {
  //   print("showNotification");
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'channel', 'Downloads',
  //       channelDescription: 'Notifications for finished downloads.',
  //       importance: Importance.max,
  //       priority: Priority.high);
  //   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //       iOS: iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin!
  //       .show(0, title, body, platformChannelSpecifics, payload: body);
  // }
}
