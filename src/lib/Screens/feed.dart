import 'package:flutter/material.dart';
import 'package:telsavideo/screens/login/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telsavideo/components/api.dart';
import 'package:telsavideo/screens/videolist.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telsavideo/screens/login_copy.dart';
import 'dart:convert';

var apiData4;

class BuildFeed extends StatefulWidget {
  @override
  createState() => new BuildFeedState();
}

class BuildFeedState extends State<BuildFeed> {
  var user;
  var key;
  var userData;
  var steemPriceData;

  checkUser() async {
    var _temp = {
      "user": await retrieveData("user"),
      "key": await retrieveData("key")
    };
    setState(() {
      user = _temp["user"];
      key = _temp["key"];
    });
    if (user != null && key != null) {
      var _tempData = await steemit.getAccount(user);
      var _tempPrice = await steemit.getSteemPrice();
      setState(() {
        userData = _tempData;
        steemPriceData = _tempPrice;
      });
      print(steemPriceData);
    }
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(user ?? "An error occured."),
      ),
      body: new Container(
          color: theme(selectedTheme)["background"],
          child: user == null
              ? new Column(
                  children: <Widget>[
                    new Card(
                      color: theme(selectedTheme)["background"],
                      child: new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Center(
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, left: 4.0, right: 4.0),
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    new Login()));
                                      },
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(
                                            "Login with Steemconnect",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      color: Colors.blueAccent,
                                    ),
                                    new FlatButton(
                                        onPressed: () {
                                          launch("https://signup.steemit.com/");
                                        },
                                        child: new Text(
                                          "No account? Register now on steemit.com",
                                          style: TextStyle(
                                              color:
                                                  theme(selectedTheme)["text"]),
                                        )),
                                    new FlatButton(
                                        onPressed: () {
                                          launch(
                                              "https://video.telsacoin.io/#faq1");
                                        },
                                        child: new Text(
                                          "Trouble logging in? Visit the FAQ",
                                          style: TextStyle(
                                              color:
                                                  theme(selectedTheme)["text"]),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    new FutureBuilder(
                        future: steemit.getDiscussionsByFeed(
                            user), // a Future<String> or null
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                  child: new Text('No connection...'));
                            case ConnectionState.waiting:
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new CircularProgressIndicator(),
                              ));
                            default:
                              if (snapshot.hasError)
                                return Center(
                                    child:
                                        new Text('Error: ${snapshot.error}'));

                              int jump = 0;
                              final Orientation orientation =
                                  MediaQuery.of(context).orientation;
                              final bool isLandscape =
                                  orientation == Orientation.landscape;

                              var videoItemList = <Widget>[];
                              for (var i = 0;
                                  i < snapshot.data["result"].length;
                                  i++) {
                                {
                                  int index = i + jump;
                                  var data = snapshot.data["result"][index];
                                  var permlink = data["permlink"];
                                  if (json.decode(
                                          data['json_metadata'])["video"] !=
                                      null) {
                                    var title = data['title'];
                                    String description;
                                    description = json.decode(
                                            data['json_metadata'])["video"]
                                        ["content"]["description"];
                                    videoItemList.add(buildRow(
                                        data,
                                        index,
                                        title,
                                        description,
                                        permlink,
                                        context,
                                        false));
                                  }
                                }
                              }

                              if (videoItemList.length > 0) {
                                return new Container(
                                    color: theme(selectedTheme)["background"],
                                    child: new GridView.builder(
                                        primary: true,
                                        itemCount: videoItemList.length,
                                        gridDelegate:
                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 2.0,
                                          crossAxisCount: isLandscape ? 4 : 2,
                                          mainAxisSpacing: 5.0,
                                        ),
                                        padding: const EdgeInsets.all(4.0),
                                        itemBuilder: (context, i) =>
                                            videoItemList[i]));
                              } else {
                                return Container(
                                    child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Nothing found..."),
                                    ],
                                  ),
                                ));
                              }
                          }
                        }),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        userData != null &&
                                steemPriceData != null &&
                                userData["result"] != null
                            ? new Opacity(
                                opacity: 0.9,
                                child: new FlatButton(
                                  color: theme(selectedTheme)["background"],
                                  onPressed: () {
                                    print("pressed");
                                  },
                                  child: new ListTile(
                                    leading: new CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(0, 0, 0, 0.0),
                                      backgroundImage: new NetworkImage(
                                          "https://steemitimages.com/u/" +
                                              user +
                                              "/avatar/small"),
                                    ),
                                    title: new Text(user),
                                    trailing: new Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: <Widget>[
                                                new Icon(
                                                  FontAwesomeIcons.bolt,
                                                  color: Colors.white,
                                                  size: 12.0,
                                                ),
                                                new Text(
                                                  " " +
                                                      (userData["result"][0][
                                                                  "voting_power"] /
                                                              100)
                                                          .toString() +
                                                      "%",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        new Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: new Text(
                                              "\$" +
                                                  (double.parse(userData[
                                                                      "result"]
                                                                  [0]["balance"]
                                                              .toString()
                                                              .replaceAll(
                                                                  " STEEM",
                                                                  "")) +
                                                          double.parse(
                                                              steemPriceData[0][
                                                                  "price_usd"]))
                                                      .toStringAsFixed(2)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                )),
    );
  }
}
