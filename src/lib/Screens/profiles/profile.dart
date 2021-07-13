import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/models/HiveData.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/login.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Profiletate();
}

class _Profiletate extends State<Profile> {
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
        //Navigator.popAndPushNamed(context, '/hive');
        /* Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false); */
      }
    });
    return _hiveData;
  }

  @override
  void initState() {
    super.initState();
    hiveData = userProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //color: Colors.black12,
        body: FutureBuilder<HiveData>(
          future: hiveData,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white12))),
                      //padding:EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                                    border: Border.all(color: Colors.white12)),
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
                                    border: Border.all(color: Colors.white12)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Loading;
          },
        ),
      ),
    );
  }
}
