import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:libphonenumber/libphonenumber.dart';
//import 'package:country_codes/country_codes.dart';
// ignore: unused_import
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/components/api.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/screens/home/home.dart';
import 'package:telsavideo/screens/login/hiveaccount.dart';
import 'package:telsavideo/screens/signup/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime? currentBackPressTime;
  String phoneNumber = '';
  String? phoneIsoCode;
  RegionInfo? _regionInfo;
  final TextEditingController controller = TextEditingController();
  /* CountryDetails details = CountryCodes.detailsForLocale();
  Locale locale = CountryCodes.getDeviceLocale()!; */
  String initialCountry = 'US';
  // PhoneNumber number = PhoneNumber(isoCode: 'CN');
  // SignUp signUp = new SignUp();
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
    var url = apiDevUrl + "/signin";
    Dio dio = new Dio();
    Response response = await dio.post(url,
        data: {"username": params["email"], "password": params["password"]});
    Map<String, dynamic> result = response.data;
    if (result["code"] == 200) {
      saveData("dtok_accessToken", result["accessToken"]);
      saveData("dtok_token_expire", result["expireDate"]);
      saveData("dtok_refreshToken", result["refreshToken"]);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
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
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.0),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 0.0),
                            child: Text(
                              'Welcome to DTOK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 0.0),
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
                          FormBuilderTextField(
                            name: 'email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                            ),
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(context),
                            //   //FormBuilderValidators.email(context),
                            // ]),
                          ),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              icon: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.65)),
                              ),
                            ),
                            obscureText: true,
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(context),
                            //   FormBuilderValidators.minLength(context, 6),
                            // ]),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: MaterialButton(
                              padding: EdgeInsets.all(0.0),
                              minWidth: width,
                              height: 42.5,
                              color: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(42.5)),
                              onPressed: () {
                                showSnackBar(context);
                                /*  Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Register(signUp))); */
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  loginAsync(_formKey.currentState!.value);
                                  print('Valid');
                                } else {
                                  print('Invalid');
                                }
                                print(_formKey.currentState?.value);
                              },
                              child: Text('Login',
                                  style: TextStyle(color: Colors.white)),
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
                              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  ),
                ),
              ),
              /*  Scaffold(
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
                        child: InternationalPhoneNumberInput(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          autoValidate: false,
                          selectorTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          initialValue: number,
                          textFieldController: controller,
                          onInputChanged: onPhoneNumberChange,
                          inputBorder: InputBorder.none,
                          inputDecoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
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
              ), */
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
}
