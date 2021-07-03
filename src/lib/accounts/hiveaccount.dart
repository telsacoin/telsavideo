import 'dart:convert';
import 'dart:io';

import 'package:telsavideo/services/interceptor.dart' as postreq;
import 'package:telsavideo/screens/home.dart';
import 'package:telsavideo/screens/onboarding/languageselection.dart';
import 'package:telsavideo/common/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiveAccount extends StatefulWidget {
  static const String id = "Hive Signer";

  @override
  _HiveAccountState createState() => _HiveAccountState();
}

class _HiveAccountState extends State<HiveAccount> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    bool isAndroid = Platform.isIOS;
    if (isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  postreq.Interceptor intercept = postreq.Interceptor();
  late String registrationToken;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Dio dio = Dio();

  void hiveAuth() async {
    await _messaging.getToken().then((token) {
      setState(() {
        registrationToken = token!;
      });
    });

    print(
        "Hive Auth running ###################################################");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = 'https://api.aureal.one/public/userAuth';
    var map = Map<String, dynamic>();
    print(
        "Check this token **************************************************");
    print(registrationToken);
    map['identifier'] = prefs.getString('code');
    map['registrationToken'] = registrationToken;
    print(registrationToken);

    FormData formData = FormData.fromMap(map);

    var response = await dio.post(url, data: formData);

    print("Check this data **************************************************");
    print(response.data);
    if (response.statusCode == 200) {
      prefs.setString('token', response.data['userData']['token']);
      prefs.setString('userId', response.data['userData']['id']);
      prefs.setString('userName', response.data['userData']['username']);
      if (response.data['userData']['hive_username'] != null) {
        prefs.setString(
            'HiveUserName', response.data['userData']['hive_username']);
        prefs.setString(
            'access_token', response.data['userData']['hiveAccessToken']);
      }

      print("running uptill here//////////////");
      if (response.data['userData']['olduser'] == true) {
        Navigator.popAndPushNamed(context, Home.id);
      } else {
        Navigator.popAndPushNamed(context, SelectLanguage.id);
      }
    }
  }

  void registerHiveUser() async {
    String url = 'https://api.aureal.one/public/addHiveUser';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map['hive_username'] = prefs.getString('HiveUserName');
    map['user_id'] = prefs.getString('userId');
    map['code'] = prefs.getString('code');

    FormData formData = FormData.fromMap(map);
    print('test1');

    print(map.toString());

    var response = await intercept.postRequest(formData, url);
    print(
        '//////////////////////////////////////////////////////////////////////////////////');
    prefs.setString(
        'access_token', jsonDecode(response.toString())['access_token']);
    print(prefs.getString('access_token'));
    if (prefs.getString('access_token') != null) {
      Navigator.popAndPushNamed(context, Home.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Hive Signer",
          textScaleFactor: 0.75,
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 4),
        ),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Builder(
              builder: (BuildContext context) {
                return WebView(
                  gestureRecognizers: Set()
                    ..add(
                      Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer(),
                      ), // or null
                    ),
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      'https://hivesigner.com/oauth2/authorize?client_id=telsacoin&redirect_uri=%3Dhttp%253A%252F%252Flocalhost%253A3000%26&response_type=code&scope=offline,comment,vote,comment_option,custom_json',
                  onPageStarted: (url) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    var uri = Uri.parse(url.toString());
                    uri.queryParameters.forEach((key, value) {
                      if (key == 'access_token' ||
                          key == 'username' ||
                          key == 'code') {
                        if (key == 'username' &&
                            prefs.getString('access_token') != null &&
                            prefs.getString('code') != null) {
                          prefs.setString('HiveUserName', value);
                          print(
                              "*************************************************************************************");
                          print(prefs.getString('code'));
                          print(
                              '*************************************************************************************');
                          // registerHiveUser();

                        } else {
                          prefs.setString('$key', value);
                        }

                        print(prefs.getString(key));
                        if (prefs.getString('code') != null) {
                          print(
                              'this is the code : ${prefs.getString('code')}');
                        }
                        if (prefs.getString('userId') != null) {
                          registerHiveUser();
                        } else {
                          hiveAuth();
                        }
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// InAppWebView(
// initialFile:
// 'https://hivesigner.com/oauth2/authorize?client_id=aureal&redirect_uri=%3Dhttp%253A%252F%252Flocalhost%253A3000%26&response_type=code&scope=offline,comment,vote,comment_option,custom_json',
// onLoadStop: (InAppWebViewController controller, url) async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
//
// var uri = Uri.parse(url.toString());
// uri.queryParameters.forEach((key, value) {
// if (key == 'access_token' ||
// key == 'username' ||
// key == 'code') {
// if (key == 'username' &&
// prefs.getString('access_token') != null &&
// prefs.getString('code') != null) {
// prefs.setString('HiveUserName', value);
// print(
// "*************************************************************************************");
// print(prefs.getString('code'));
// print(
// '*************************************************************************************');
// // registerHiveUser();
//
// } else {
// prefs.setString('$key', value);
// }
//
// print(prefs.getString(key));
// if (prefs.getString('code') != null) {
// print(
// 'this is the code : ${prefs.getString('code')}');
// }
// HiveAuth();
// }
// });
// },

//               javascriptMode: JavascriptMode.unrestricted,
//               onPageFinished: (value) async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 print(value);
//                 var uri = Uri.parse(value);
//                 uri.queryParameters.forEach((key, value) {
//                   if (key == 'access_token' ||
//                       key == 'username' ||
//                       key == 'expires_in') {
//                     if (key == 'username' &&
//                         prefs.getString('access_token') != null) {
//                       prefs.setString('HiveUserName', value);
//                       registerHiveUser();
//                     } else {
//                       prefs.setString('$key', value);
//                     }
//
//                     print(prefs.getString(key));
//                   }
//                 });
//
// //
//
// //                await registerHiveUser();
// //                Navigator.popAndPushNamed(context, Home.id);
//               },
// );
