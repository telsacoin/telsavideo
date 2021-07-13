import 'package:telsavideo/accounts/hiveaccount.dart';
import 'package:telsavideo/services/launchurl.dart';
import 'package:telsavideo/common/sizeconfig.dart';
import 'package:telsavideo/constants.dart';
import 'package:flutter/material.dart';

class HiveDetails extends StatelessWidget {
  static const String id = "Hive Onboarding";

  Launcher launcher = Launcher();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hive",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                5),
                                  ),
                                  Text(
                                    "Fast.",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                4.5,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Text(
                                    "Scalable.",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                4.5,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Text(
                                    "Powerful Blockchain.",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                4.5,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Image.asset(
                                      'assets/images/hive-login.png')),
                            ],
                          ),
                        ),
                        Text(
                          "+",
                          textScaleFactor: 0.75,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal! * 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DTok",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal! * 5,
                                    ),
                                  ),
                                  Text(
                                    "Simplified",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                4.5,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Text(
                                    "Podcasting",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                4.5,
                                        fontWeight: FontWeight.w200),
                                  ),
//                                Text(
//                                  "Powerful Blockchain.",
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontSize:
//                                          SizeConfig.safeBlockHorizontal * 4.5,
//                                      fontWeight: FontWeight.w200),
//                                )
                                ],
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child:
                                      Image.asset('assets/images/Favicon.png')),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                        ),
                        Text(
                          "DTok is enabled by Hive Blockchain. It's important to connect your hive account, Please connect your Hive account to monetise your contribution.",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onTap: () {
                              launcher.launchInBrowser(
                                  'https://hiveonboard.com/create-account');
                              // Navigator.pushNamed(context, HiveAccount.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color(0xff6048F6),
                                    Color(0xff51C9F9)
                                  ])),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                3.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, HiveAccount.id, (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kSecondaryColor),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Already have an account? Sign In",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                3.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.popAndPushNamed(context, 'Home');
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, HiveAccount.id, (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kSecondaryColor),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Skip for now",
                                    textScaleFactor: 0.75,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                3.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
