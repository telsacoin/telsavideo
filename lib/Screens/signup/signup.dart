import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:libphonenumber/libphonenumber.dart';
//import 'package:country_codes/country_codes.dart';
// ignore: unused_import
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/models/signup/signup.dart';
import 'package:telsavideo/screens/home/home.dart';
import 'package:telsavideo/screens/login/hiveaccount.dart';
import 'package:telsavideo/screens/signup/register.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? currentBackPressTime;
  String phoneNumber = '';
  String? phoneIsoCode;
  bool _isValid = false;
  String _normalized = '';
  RegionInfo? _regionInfo;
  String _carrierName = '';
  final TextEditingController controller = TextEditingController();
  /* CountryDetails details = CountryCodes.detailsForLocale();
  Locale locale = CountryCodes.getDeviceLocale()!; */
  String initialCountry = 'US';
  // PhoneNumber number = PhoneNumber(isoCode: 'CN');
  SignUp signUp = new SignUp();
  // void onPhoneNumberChange(PhoneNumber number) {
  //   signUp.mobile = number.phoneNumber;
  //   print(signUp.mobile);
  // }

  _showDetails() async {
    var s = controller.text;

    bool? isValid =
        await PhoneNumberUtil.isValidPhoneNumber(phoneNumber: s, isoCode: 'US');
    String? normalizedNumber = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: s, isoCode: 'US');
    RegionInfo regionInfo =
        await PhoneNumberUtil.getRegionInfo(phoneNumber: s, isoCode: 'US');
    String? carrierName =
        await PhoneNumberUtil.getNameForNumber(phoneNumber: s, isoCode: 'US');

    setState(() {
      _isValid = isValid??false;
      _normalized = normalizedNumber??"N/A";
      _regionInfo = regionInfo;
      _carrierName = carrierName??"N/A";
    });
  }


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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    checkAuth();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    kBgColorTop.withOpacity(0.4),
                    kBgColorTop.withOpacity(0.55),
                    kBgColorBottom.withOpacity(0.7),
                    kBgColorBottom.withOpacity(0.8),
                    kBgColorBottom.withOpacity(1.0),
                    /* kBgColorTop.withOpacity(0.4),
                    kBgColorBottom.withOpacity(1.0), */
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Welcome back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Login in your account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 70.0),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        // child: InternationalPhoneNumberInput(
                        //   textStyle: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   autoValidateMode: AutovalidateMode.disabled,
                        //   selectorTextStyle: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   initialValue: number,
                        //   textFieldController: controller,
                        //   onInputChanged: onPhoneNumberChange,
                        //   inputBorder: InputBorder.none,
                        //   inputDecoration: InputDecoration(
                        //     contentPadding: EdgeInsets.only(left: 20.0),
                        //     hintText: 'Phone Number',
                        //     hintStyle: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 16.0,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //     border: InputBorder.none,
                        //   ),
                        //   selectorConfig: SelectorConfig(
                        //       selectorType: PhoneInputSelectorType.DIALOG),
                        // ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Register(signUp)));
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.5, 0.9],
                              colors: [
                                /* Colors.red[300]!.withOpacity(0.8),
                                Colors.red[500]!.withOpacity(0.8),
                                Colors.red[800]!.withOpacity(0.8), */
                                kButtomColor.withOpacity(0.8),
                                kButtomColor.withOpacity(0.8),
                                kButtomColor.withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'We\'ll send OTP for Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    InkWell(
                      onTap: () {
                        print("Hive Signer Activated");
                        /* showBarModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return HiveAccount();
                            }); */
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HiveAccount()));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xFFFFFEFE),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/hive.png',
                                height: 25.0,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Log in with Hive',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xFF3B5998),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/facebook.png',
                                height: 25.0,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Log in with Facebook',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/google.png',
                                height: 25.0,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Log in with Google',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }

  onWillPop() {
    return true;
  }
}
