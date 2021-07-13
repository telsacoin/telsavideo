import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dio/adapter.dart';
import 'package:telsavideo/screens/profile/profile.dart';
import 'package:telsavideo/services/interceptor.dart' as postreq;
import 'package:telsavideo/screens/home/home.dart';
import 'package:telsavideo/screens/onboarding/languageselection.dart';
import 'package:telsavideo/common/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../constants.dart';

class HiveAccount extends StatefulWidget {
  static const String id = "Hive Signer";

  @override
  _HiveAccountState createState() => _HiveAccountState();
}

class _HiveAccountState extends State<HiveAccount> {
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        saveFormData: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //check if user has authuzation
    checkAuth();
    // Enable hybrid composition.
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  postreq.Interceptor intercept = postreq.Interceptor();
  late String registrationToken;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Dio dio = Dio();

  Future<void> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
        ? false
        : prefs.getBool('isLoggedIn');

    if (isLoggedIn!) {
      // wrong call in wrong place!
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  void hiveAuth() async {
    await _messaging.getToken().then((token) {
      setState(() {
        registrationToken = token!;
      });
    });

    print(
        "Hive Auth running ###################################################");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = apiUrl + '/me';
    var map = Map<String, dynamic>();
    print(
        "Check this token **************************************************");
    //print(registrationToken);
    map['code'] = prefs.getString('code');
    map['username'] = prefs.getString('username');
    //print(registrationToken);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
    var response = await dio.post(url, data: map);

    print("Check this data **************************************************");
    LinkedHashMap<String, dynamic> result = response.data;
    print("the response data is " + json.encode(result));
    if (response.statusCode == 200) {
      //prefs.setString('token', result['userData']['token']);
      prefs.setString('userId', result['_id']);
      prefs.setString('userName', result['name']);
      if (result['hive_username'] != null) {
        prefs.setString('HiveUserName', result['hive_username']);
        //prefs.setString('access_token', response.data['userData']['hiveAccessToken']);
      }

      prefs.setString('hiveData', json.encode(result));

      print("running uptill here//////////////");
      if (result['olduser'] == true) {
        Navigator.popAndPushNamed(context, '/');
      } else {
        Navigator.popAndPushNamed(context, '/');
        //Navigator.popAndPushNamed(context, SelectLanguage.id);
      }
    }
  }

  void getAccessToken() async {
    String url = apiUrl + '/oauth2/token';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map['username'] = prefs.getString('username');
    map['code'] = prefs.getString('code');

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
    print('get user token!');

    var response = await dio.post(url,
        data: map); //await intercept.postRequest(formData, url);
    log('//////////////////////////////////////////////////////////////////////////////////');
    if (response.statusCode == 200) {
      Map<String, dynamic> result = response.data;
      result.forEach((key, value) {
        prefs.setString('$key', value);
      });

      hiveAuth();
    }
  }

  void registerHiveUser() async {
    String url = apiUrl + '/me';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map['username'] = prefs.getString('username');
    map['user_id'] = prefs.getString('userId');
    map['code'] = prefs.getString('code');

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };

    /* String? jsonString = await controller.getHtml();
    var decodeSucceeded = false;
    try {
      var decodedJSON = json.decode(jsonStrin) as Map<String, dynamic>;
      decodeSucceeded = true;
      decodedJSON.forEach((key, value) {
        prefs.setString('$key', value);
      });
    } on FormatException catch (e) {
      print('The provided string is not valid JSON $e');
    }
    print('Decoding succeeded: $decodeSucceeded'); */

    var response = await dio.post(url,
        data: map); //await intercept.postRequest(formData, url);
    print(
        '//////////////////////////////////////////////////////////////////////////////////');
    //prefs.setString('access_token', jsonDecode(response.toString())['access_token']);
    Navigator.popAndPushNamed(context, '/');
    /* print(prefs.getString('access_token'));
    if (prefs.getString('access_token') != null) {
      //Navigator.popAndPushNamed(context, Home.id);
      Navigator.popAndPushNamed(context, '/');
    } */
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int times = 0;
    Uri initialUrl = Uri.parse(
        'https://hivesigner.com/login?client_id=telsacoin&response_type=code&redirect_uri=https%3A%2F%2Fapi.telsacoin.io%2Fapi%2Foauth2%2Ftoken&scope=offline,comment,vote,comment_option,custom_json');
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
                return InAppWebView(
                  initialUrlRequest: URLRequest(url: initialUrl),
                  initialOptions: options,
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onProgressChanged: (controller, i) {
                    print("the progress is " + i.toString() + "%");
                  },
                  onLoadStop: (controller, url) async {
                    var uri = Uri.parse(url.toString());
                    print("the url is " + url.toString());
                    //avoid the url fired seravel times
                    if (!url!.host.contains("api.telsacoin.io")) return;
                    print("the new url is " + url.toString());
                    //pullToRefreshController!.endRefreshing();
                    //this.url = url.toString();
                    //urlController.text = this.url;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    uri.queryParameters.forEach((key, value) {
                      if (key == 'access_token' ||
                          key == 'username' ||
                          key == 'code') {
                        if (key == 'username' &&
                            prefs.getString('access_token') != null &&
                            prefs.getString('code') != null) {
                          prefs.setString('username', value);
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
                          if (times == 0) {
                            getAccessToken();
                            //registerHiveUser();
                          }
                        } else {
                          if (times == 0) {
                            getAccessToken();
                            //hiveAuth();
                          }
                        }
                        times++;
                      }
                    });
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    log(consoleMessage.message);
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

//https://stackoverflow.com/questions/62236740/how-to-add-circularprogressindicator-when-loading-web-page-using-flutter-inappwe

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


/* return InAppWebView(
  initialUrlRequest: URLRequest(
      url: Uri.parse(
          'https://hivesigner.com/login?client_id=telsacoin&response_type=code&redirect_uri=https%3A%2F%2Fapi.telsacoin.io%2Fapi%2Foauth2%2Ftoken&scope=offline,comment,vote,comment_option,custom_json')),
  //javascriptMode: JavascriptMode.unrestricted,
  initialOptions: options,
  pullToRefreshController: pullToRefreshController,
  onWebViewCreated: (controller) {
    webViewController = controller;
  },
  onProgressChanged: (controller, i) {
    print(i);
  },
  onLoadStart: (controller, url) {
    setState(() async {
      this.url = url.toString();
      urlController.text = this.url;

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
    });
  },
); */