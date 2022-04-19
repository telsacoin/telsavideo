import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/components/core.dart';
import 'package:telsavideo/http/base/base_domain.dart';
import 'package:telsavideo/http/util.dart';
import 'package:telsavideo/models/dto/signin/signin_dto.dart';
import 'package:telsavideo/models/vo/signin/signin_vo.dart';
import 'package:telsavideo/screens/home/home.dart';

class PhoneOrEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhoneOrEmailState();
}

class _PhoneOrEmailState extends State<PhoneOrEmail> {
  final _formKey = GlobalKey<FormBuilderState>();

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
  // SignUp signUp = new SignUp();
  // void onPhoneNumberChange(PhoneNumber number) {
  //   signUp.mobile = number.phoneNumber;
  //   print(signUp.mobile);
  // }

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
                              SizedBox(height: 70.0),
                              FormBuilderTextField(
                                name: 'email',
                                initialValue: dto.username,
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 24, 35, 1),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(
                                    Icons.email_outlined,
                                    color: Color.fromRGBO(22, 24, 35, 1),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
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
                                initialValue: dto.password,
                                style: TextStyle(
                                  color: Color.fromRGBO(22, 24, 35, 1),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(
                                    Icons.lock_outline,
                                    color: Color.fromRGBO(22, 24, 35, 1),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.1)),
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
                                  color: Color.fromRGBO(254, 44, 85, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(42.5)),
                                  onPressed: () {
                                    //showSnackBar(context);
                                    /*  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: Register(signUp))); */
                                    if (_formKey.currentState
                                            ?.saveAndValidate() ??
                                        false) {
                                      loginAsync(_formKey.currentState!.value);
                                      print('Valid');
                                    } else {
                                      print('Invalid');
                                    }
                                    print(_formKey.currentState?.value);
                                  },
                                  child: Text('Log in',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 15.0),
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
}
