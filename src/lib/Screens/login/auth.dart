//import 'package:auditory/models/user.dart';
import 'package:telsavideo/screens/onboarding/hivedetails.dart';
import 'package:telsavideo/screens/Onboarding/LanguageSelection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
  Stream<User?> get currentUser => _auth.authStateChanges();
}

class AuthBloc {
  final authService = AuthService();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? registrationToken;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Stream<User?> get currentUser => authService.currentUser;

  loginGoogle(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = Dio();
      await _messaging.getToken().then((token) {
        registrationToken = token;
        print(
            '//////////////////////////////////////////////////////${token.toString()} /////////////////////////////////////////////////////////');
      });
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleKey = await result!.authentication;
      print(googleKey.idToken.toString());
      print(googleKey.accessToken.toString());
      String url = 'https://api.aureal.one/public/userAuth';
      var map = Map<String, dynamic>();
      map['identifier'] = googleKey.idToken.toString();
      map['registrationToken'] = registrationToken;
      map['loginType'] = 'google';
      print('registrationToken: ${map['registrationToken']}');
      FormData formData = FormData.fromMap(map);
      var response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data.toString());
        prefs.setString('token', response.data['userData']['token']);
        prefs.setString('userId', response.data['userData']['id']);
        prefs.setString('userName', response.data['userData']['username']);

        if (response.data['userData']['olduser'] == true) {
          if (response.data['userData']['hive_username'] != null) {
            prefs.setString(
                'HiveUserName', response.data['userData']['hive_username']);
            Navigator.popAndPushNamed(context, '/');
          } else {
            Navigator.popAndPushNamed(context, '/');
            //Navigator.popAndPushNamed(context, HiveDetails.id);
          }
        } else {
          //Navigator.popAndPushNamed(context, SelectLanguage.id);
          Navigator.popAndPushNamed(context, '/');
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Could not log you in',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff3a3a3a),
            textColor: Color(0xffe8e8e8),
            fontSize: 12.0);
      }
    } catch (error) {
      print(error);
    }
  }

  loginApple(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = Dio();
      await _messaging.getToken().then((token) {
        registrationToken = token;
        print(
            '//////////////////////////////////////////////////////${token.toString()} /////////////////////////////////////////////////////////');
      });
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print(credential.givenName.toString());
      print(credential.familyName.toString());
      // if(credential.givenName != null || credential.familyName!=n)
      // ignore: unnecessary_null_comparison
      String appleName = (credential.givenName.toString() != null
              ? credential.givenName.toString()
              : '') +
          (credential.givenName.toString() != null ? ' ' : '') +
          (credential.familyName.toString() != null
              ? credential.familyName.toString()
              : '');
      print(credential.authorizationCode.toString());
      String url = 'https://api.aureal.one/public/userAuth';
      var map = Map<String, dynamic>();
      map['identifier'] = credential.authorizationCode.toString();
      map['registrationToken'] = registrationToken;
      map['loginType'] = 'apple';
      map['name'] = appleName;
      print('registrationToken: ${map['registrationToken']}');
      FormData formData = FormData.fromMap(map);
      var response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data.toString());
        prefs.setString('token', response.data['userData']['token']);
        prefs.setString('userId', response.data['userData']['id']);
        prefs.setString('userName', response.data['userData']['username']);

        if (response.data['userData']['olduser'] == true) {
          if (response.data['userData']['hive_username'] != null) {
            prefs.setString(
                'HiveUserName', response.data['userData']['hive_username']);
            Navigator.popAndPushNamed(context, 'Home');
          } else {
            Navigator.popAndPushNamed(context, HiveDetails.id);
          }
        } else {
          Navigator.popAndPushNamed(context, SelectLanguage.id);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Could not log you in',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xff3a3a3a),
            textColor: Color(0xffe8e8e8),
            fontSize: 12.0);
      }
    } catch (error) {
      print(error);
    }
  }
}
