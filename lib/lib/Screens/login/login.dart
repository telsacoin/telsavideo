import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:libphonenumber/libphonenumber.dart';
//import 'package:country_codes/country_codes.dart';
// ignore: unused_import
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/components/core.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/http/base/base_domain.dart';
import 'package:telsavideo/http/util.dart';
import 'package:telsavideo/models/dto/signin/signin_dto.dart';
import 'package:telsavideo/models/dto/signup/signup_dto.dart';
import 'package:telsavideo/models/vo/signin/signin_vo.dart';
import 'package:telsavideo/screens/home/home.dart';
import 'package:telsavideo/screens/login/hiveaccount.dart';
import 'package:telsavideo/screens/signup/register.dart';
import 'package:telsavideo/screens/signup/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime? currentBackPressTime;
  String phoneNumber = '';
  String? phoneIsoCode;
  RegionInfo? _regionInfo;
  SignInDto dto = new SignInDto("122333", "1222333");
  final TextEditingController controller = TextEditingController();
  /* CountryDetails details = CountryCodes.detailsForLocale();
  Locale locale = CountryCodes.getDeviceLocale()!; */
  String initialCountry = 'US';
  // PhoneNumber number = PhoneNumber(isoCode: 'CN');
  SignUpDto signUp = new SignUpDto();
  // void onPhoneNumberChange(PhoneNumber number) {
  //   signUp.mobile = number.phoneNumber;
  //   print(signUp.mobile);
  // }

  Future<void> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
        ? false
        : prefs.getBool('isLoggedIn');

    if (isLoggedIn!) {
      // wrong call in wrong place!
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  Future<void> loginAsync(Map<String, dynamic> params) async {
    dto.username = params["email"];
    dto.password = params["password"];
    SignInVo result = await Api.postLoginResponse(dto);
    print(result);
    Util.set('isLogin', true);
    Util.set(BaseDomain.xUSERTOKEN, result.accessToken);
    Util.set("dtok_accessToken", result.accessToken);
    Util.set("dtok_token_expire", result.expiresInDate);
    Util.set("dtok_refreshToken", result.refreshToken);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  }

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(color: Colors.white
          //image: DecorationImage(
          //image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
          ),
      child: Stack(
        children: <Widget>[
          // Positioned(
          //   top: 0.0,
          //   left: 0.0,
          //   child: Container(
          //     width: width,
          //     height: height,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         stops: [0.1, 0.3, 0.5, 0.7, 0.9],
          //         colors: [
          //           kBgColorTop.withOpacity(0.4),
          //           kBgColorTop.withOpacity(0.55),
          //           kBgColorBottom.withOpacity(0.7),
          //           kBgColorBottom.withOpacity(0.8),
          //           kBgColorBottom.withOpacity(1.0),
          //           /* kBgColorTop.withOpacity(0.4),
          //           kBgColorBottom.withOpacity(1.0), */
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 32, right: 32, top: 0, bottom: 0),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 0, right: 0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => {Navigator.of(context).pop()},
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.centerLeft,
                                  child: Image(
                                    image: AssetImage("assets/icons/close.png"),
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {showMsg(context, "", "通知消息！")},
                                child: SvgPicture.asset(
                                  "assets/icons/help.svg",
                                  width: 22,
                                  height: 22,
                                ),
                              )
                            ],
                          ),
                        ),
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              Center(
                                child: Text(
                                  'Log in to DTOK',
                                  style: TextStyle(
                                    color: Color.fromRGBO(22, 24, 35, 1),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: Text(
                                  'Manage your account, check notification. comment on videos, and more',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(22, 24, 35, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: Register(null)))
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/user.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                              "Use phone / email / username"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/line.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Continue with Line"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/twitter.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Continue with Twitter"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/google.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Continue with Google"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/facebook.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Continue with Facebook"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/kakaotalk_circle.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child:
                                              Text("Continue with KakaoTalk"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/apple.svg",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text("Continue with Apple"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Color.fromRGBO(22, 24, 35, 0.12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                width: 1.0,
                                                color: Color.fromRGBO(
                                                    22, 24, 35, 0.12)),
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/instagram.png",
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child:
                                              Text("Continue with Instagram"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              onWillPop: () async {
                bool exitStatus = onWillPop();
                if (exitStatus) {
                  exit(0);
                }
                return false;
              },
            ),
          ),
          Positioned(bottom: 0, child: _loginFooter(width))
        ],
      ),
    );
  }

  onWillPop() {
    return true;
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Login successed!'),
      backgroundColor: const Color(0xffae00f0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: 'Done',
          textColor: Colors.white,
          onPressed: () {
            print('Done pressed!');
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// add the footer
  _loginFooter(double width) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Color.fromRGBO(22, 24, 35, 0.3)),
      width: width,
      height: 61,
      child: InkWell(
        onTap: () => {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don’t have an account? ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
