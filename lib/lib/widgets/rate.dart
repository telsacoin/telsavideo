import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  0 - Start
  1 - First negative
  2 - First positive
 */

var tree = 0;
var hide = true;

class RateWidget extends StatefulWidget {
  @override
  RateWidgetState createState() => RateWidgetState();
}

class RateWidgetState extends State<RateWidget> {
  pref() async {
    final prefs = await SharedPreferences.getInstance();
    if (int.parse(prefs.getString("started")!) > 3) {
      if (prefs != null && hide) {
        setState(() {
          hide = prefs.getBool("rating")!;
        });
      } else {
        prefs.setBool("rating", hide);
      }
    }
  }

  @override
  void initState() {
    pref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //hide = false; //TODO: remove in release
    // TODO: implement build
    if (!hide) {
      switch (tree) {
        case 0:
          return rateWidget(
            "Enjoying DTube Viewer?",
            "Not really",
            "Yes!",
          );
          break;
        case 1:
          return rateWidget(
            "Would you mind giving us some feedback?",
            "No, thanks",
            "Ok, sure",
          );
          break;
        case 2:
          return rateWidget(
            "How about a rating on the " +
                (Platform.isIOS ? "App" : "Play") +
                " Store, then?",
            "Not really",
            "Ok, sure!",
          );
          break;
      }
    } else {
      return new Container();
    }
    return Container();
  }

  Widget rateWidget(String question, String negative, String positive) {
    return Stack(
      children: <Widget>[
        new Container(
          color: Colors.lightBlue,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  question,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      width: 150.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(
                              width: 2.0, color: const Color(0xFFFFFFFF)),
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Material(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(20.0),
                        child: new TextButton(
                          onPressed: () {
                            switch (tree) {
                              case 0:
                                setState(() {
                                  tree = 1;
                                });
                                break;
                              case 1:
                                setState(() {
                                  hide = true;
                                });
                                break;
                              case 2:
                                setState(() {
                                  hide = true;
                                });
                                break;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                            child: new Text(
                              negative,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      width: 150.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(
                              width: 2.0, color: const Color(0xFFFFFFFF)),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        child: new TextButton(
                          onPressed: () {
                            switch (tree) {
                              // first positive
                              case 0:
                                setState(() {
                                  tree = 2;
                                });
                                break;
                              // second negative -> positive
                              case 1:
                                setState(() {
                                  hide = true;
                                });
                                launchURL(
                                    "mailto:feedback@bostrot.pro?subject=DTube Viewer Feedback");
                                break;
                              // second positive
                              case 2:
                                setState(() {
                                  hide = true;
                                });
                                Platform.isAndroid
                                    ? launchURL(
                                        "market://details?id=pro.bostrot.dtubeviewer")
                                    : launchURL(
                                        "itms://itunes.apple.com/us/app/dtube-viewer/id1358140255");
                                break;
                            }
                          },
                          child: new Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                            child: new Text(
                              positive,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.lightBlue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 45.0,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    hide = true;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

launchURL(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
