import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/models/HiveData.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/login.dart';
import 'package:telsavideo/screens/profile/profile_setting.dart';
import 'package:telsavideo/screens/profile/profile_tab_item.dart';
import 'package:telsavideo/screens/profile/term_of_use.dart';
import 'package:telsavideo/screens/profile/edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Profiletate();
}

class _Profiletate extends State<Profile> {
  static List<String> choices = <String>[
    'Profile Setting',
    'Share Profile',
    'Term of Use',
    'Rate App',
    'Logout'
  ];

  late Future<HiveData> hiveData;

  Future<HiveData> userProfile() async {
    String appUser = await rootBundle.loadString('assets/user.json');
    final prefs = await SharedPreferences.getInstance();
    //log(appUser);
    HiveData _hiveData = HiveData.fromJson(json.decode(appUser));
    log(_hiveData.name);
    //Navigator.popAndPushNamed(context, '/hive');
    setState(() {
      String? hiveDataString = prefs.getString('hiveData');
      if (hiveDataString != null) {
        _hiveData = HiveData.fromJson(json.decode(hiveDataString));
      } else {
        /* Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false); */
      }
    });
    return _hiveData;
  }

  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 130.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You sure want to logout?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void choiceAction(String choice) {
    if (choice == 'Profile Setting') {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: ProfileSetting()));
    } else if (choice == 'Share Profile') {
      print('Share Profile');
    } else if (choice == 'Term of Use') {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: TermOfUse()));
    } else if (choice == 'Rate App') {
      print('Rate App');
    } else if (choice == 'Logout') {
      logoutDialogue();
    }
  }

  @override
  void initState() {
    super.initState();
    hiveData = userProfile();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<HiveData>(
        future: hiveData,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading;
          } else if (snapshot.hasData) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.black,
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 410,
                        pinned: true,
                        forceElevated: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.black,
                        elevation: 0.0,
                        actions: <Widget>[
                          PopupMenuButton<String>(
                            onSelected: choiceAction,
                            color: Colors.white,
                            itemBuilder: (BuildContext context) {
                              return choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(
                                    children: [
                                      Icon(
                                        (choice == 'Profile Setting')
                                            ? Icons.perm_identity
                                            : (choice == 'Share Profile')
                                                ? Icons.share
                                                : (choice == 'Term of Use')
                                                    ? Icons.vpn_key
                                                    : (choice == 'Rate App')
                                                        ? Icons.star
                                                        : Icons.exit_to_app,
                                        color: Colors.black,
                                        size: 18.0,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        choice,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            width: width,
                            height: 390.0,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              color: Colors.black,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 90.0,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45.0),
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${snapshot.data!.userMetadata.profile.coverImage}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  '${snapshot.data!.account.name}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      borderRadius: BorderRadius.circular(5.0),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: EditProfile()));
                                      },
                                      child: Container(
                                        width: 120.0,
                                        height: 35.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                              color: Colors.white70,
                                              width: 2.0),
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        const url =
                                            'https://www.instagram.com/tlsacoin/';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Image.asset('assets/insta.png',
                                          height: 30.0, fit: BoxFit.fitHeight),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '5.5m',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Likes',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '2.3m',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Followers',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '59',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Following',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottom: TabBar(
                          tabs: [
                            Tab(
                              child: Icon(Icons.dashboard, color: Colors.white),
                            ),
                            Tab(
                              child: Icon(Icons.favorite_border,
                                  color: Colors.white),
                            ),
                            Tab(
                              child: Icon(Icons.bookmark_border,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.7),
                        child: ProfileTabItem(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.7),
                        child: ProfileTabItem(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.7),
                        child: ProfileTabItem(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading;
          }
        });
  }
}

 /* return SafeArea(
      child: Scaffold(
        //color: Colors.black12,
        body: FutureBuilder<HiveData>(
          future: hiveData,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading;
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white12))),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "${snapshot.data!.user}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${snapshot.data!.userMetadata.profile.coverImage}",
                                    height: 100.0,
                                    width: 100.0,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "@${snapshot.data!.user}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${snapshot.data!.account.balance}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Balance",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.white54,
                                  width: 1,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${snapshot.data!.account.hbdBalance}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "HBD Balance",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.black54,
                                  width: 1,
                                  height: 15,
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "1000 TSLA",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "TSLA",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 140,
                                  height: 47,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border:
                                          Border.all(color: Colors.white12)),
                                  child: Center(
                                    child: Text(
                                      "Edit profile",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 45,
                                  height: 47,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border:
                                          Border.all(color: Colors.white12)),
                                  child: Center(
                                      child: Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                  )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                      color: Color.fromARGB(1, 26, 26, 26))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 2,
                                        width: 55,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.favorite_border,
                                          color: Colors.white70),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: 2,
                                        width: 55,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.lock_outline,
                                        color: Colors.white70,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        height: 2,
                                        width: 55,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        border: Border.all(
                                            color: Colors.black87, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/Ii4Cv63yG9iYawDtKC/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                            color: Colors.white70, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/tqfS3mgQU28ko/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                            color: Colors.white70, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/3o72EX5QZ9N9d51dqo/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                            color: Colors.white70, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/4oMoIbIQrvCjm/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                            color: Colors.white70, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/aZmD30dCFaPXG/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                            color: Colors.white70, width: .5)),
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://media.giphy.com/media/NU8tcjnPaODTy/giphy.gif",
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
} 
*/