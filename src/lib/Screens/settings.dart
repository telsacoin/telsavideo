import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telsavideo/components/api.dart';
import 'package:flutter_billing/flutter_billing.dart';
import 'dart:io' show Platform;
import 'package:telsavideo/main.dart';
import 'package:telsavideo/screens/login.dart';

class BuildSettings extends StatefulWidget {
  @override
  createState() => new BuildSettingsState();
}

// settings screen
class BuildSettingsState extends State<BuildSettings> {
  var user;
  var key;
  var _gateway;
  var currentGateway;
  var _value;

  _getCurrentGateway() async {
    var _temp = await retrieveData("gateway");
    setState(() {
      currentGateway = _temp;
    });
  }

  @override
  void initState() {
    _getCurrentGateway();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: theme(selectedTheme)["background"],
      child: ListView(
        children: <Widget>[
          new ListTile(
            title: Text("Support the dev"),
          ),
          new ListTile(
            title: Text("Join Discord | Features | Bugs | more"),
            onTap: () {
              launchURL("https://discord.gg/fZvGq3D");
            },
            leading: Icon(FontAwesomeIcons.discord),
          ),
          new Divider(),
          new ListTile(
            title: Text("Contribute on GitHub"),
            onTap: () {
              launchURL("https://github.com/bostrot/DTubeViewer");
            },
            leading: Icon(FontAwesomeIcons.github),
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.shoppingCart,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "Remove ads",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () async {
              await analytics.logViewItem(
                  itemId: "noads", itemName: "NoAds", itemCategory: "inapp");
              if (Platform.isIOS) {
              } else {
                final Billing billing = new Billing(onError: (e) {
                  return Scaffold.of(context)
                      .showSnackBar(new SnackBar(content: new Text(e)))
                      .close();
                });
                final bool purchased = await billing.isPurchased('no_ads');
                if (purchased) {
                  saveData("no_ads", "true");
                  return Scaffold.of(context)
                      .showSnackBar(new SnackBar(
                        content: new Text(
                            "Thanks for supporting me! Ads will not show up again."),
                      ))
                      .close();
                } else {
                  final bool purchased = await billing.purchase('no_ads');
                  if (purchased) {
                    saveData("no_ads", "true");
                    // ignore: deprecated_member_use
                    return Scaffold.of(context)
                        // ignore: deprecated_member_use
                        .showSnackBar(new SnackBar(
                          content: new Text(
                              "Thanks for supporting me! Ads will not show up again."),
                        ))
                        .close();
                  }
                }
              }
            },
          ),
          new Divider(),
          Platform.isIOS
              ? new ListTile(
                  leading: new Icon(FontAwesomeIcons.shoppingCart,
                      color: theme(selectedTheme)["accent"]),
                  title: new Text(
                    "Restore purchase",
                    style: TextStyle(color: theme(selectedTheme)["text"]),
                  ),
                  onTap: () async {
                    if (Platform.isIOS) {
                      final Billing billing = new Billing(onError: (e) {
                        return Scaffold.of(context)
                            .showSnackBar(new SnackBar(
                              content: new Text(e.toString()),
                            ))
                            .close();
                      });
                      final bool purchased =
                          await billing.isPurchased('no_ads');
                      if (purchased) {
                        saveData("noads", "true");
                        return Scaffold.of(context)
                            .showSnackBar(new SnackBar(
                              content: new Text(
                                  "Thanks for supporting me! Ads will not show up again."),
                            ))
                            .close();
                      } else {
                        final bool purchased = await billing.purchase('no_ads');
                        if (purchased) {
                          saveData("noads", "true");
                          return Scaffold.of(context)
                              .showSnackBar(new SnackBar(
                                content: new Text(
                                    "Thanks for supporting me! Ads will not show up again."),
                              ))
                              .close();
                        }
                      }
                    } else {
                      final Billing billing = new Billing(onError: (e) {
                        return Scaffold.of(context)
                            .showSnackBar(new SnackBar(
                              content: new Text(e.toString()),
                            ))
                            .close();
                      });
                      final bool purchased =
                          await billing.isPurchased('no_ads');
                      if (purchased) {
                        saveData("no_ads", "true");
                        return Scaffold.of(context)
                            .showSnackBar(new SnackBar(
                              content: new Text(
                                  "Thanks for supporting me! Ads will not show up again."),
                            ))
                            .close();
                      } else {
                        final bool purchased = await billing.purchase('no_ads');
                        if (purchased) {
                          saveData("no_ads", "true");
                          return Scaffold.of(context)
                              .showSnackBar(new SnackBar(
                                content: new Text(
                                    "Thanks for supporting me! Ads will not show up again."),
                              ))
                              .close();
                        }
                      }
                    }
                  },
                )
              : Container(),
          Platform.isIOS ? new Divider() : Container(),
          new ListTile(
            title: new Text(
              "Options",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
          ),
          new ListTile(
              leading: new Icon(FontAwesomeIcons.server,
                  color: theme(selectedTheme)["accent"]),
              title: new Text(
                "Gateway",
                style: TextStyle(color: theme(selectedTheme)["text"]),
              ),
              onTap: () {
                /* return showDialog<Null>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return new StatefulBuilder(
                      builder: (BuildContext contextStatefulBuilder, setState) {
                    return new AlertDialog(
                      title: new Text('Theme (Restart APP)'),
                      content: new DropdownButton<String>(
                        value: _value,
                        items: <DropdownMenuItem<String>>[
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("normal")["primary"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Red (Standard)'),
                                ),
                              ],
                            ),
                            value: 'normal',
                          ),
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("black")["background"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Black'),
                                ),
                              ],
                            ),
                            value: 'black',
                          ),
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("blue")["primary"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Blue'),
                                ),
                              ],
                            ),
                            value: 'blue',
                          ),
                        ],
                        onChanged: (String value) async {
                          setState(() => _value = value);
                          analytics.logEvent(
                              name: "theme",
                              parameters: <String, dynamic>{
                                "value": value,
                              });
                          saveData("theme", value);
                        },
                      ),
                      actions: <Widget>[
                        // ignore: deprecated_member_use
                        new FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Save"))
                      ],
                    );
                  });
                },
              );
            },
             */
              }),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.paintBrush,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "Theme",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              /* return showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return new StatefulBuilder(
                      builder: (BuildContext contextStatefulBuilder, setState) {
                    return new AlertDialog(
                      title: new Text('Theme (Restart APP)'),
                      content: new DropdownButton<String>(
                        value: _value,
                        items: <DropdownMenuItem<String>>[
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("normal")["primary"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Red (Standard)'),
                                ),
                              ],
                            ),
                            value: 'normal',
                          ),
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("black")["background"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Black'),
                                ),
                              ],
                            ),
                            value: 'black',
                          ),
                          new DropdownMenuItem(
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.circle,
                                  color: theme("blue")["primary"],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(left: 8.0),
                                  child: new Text('Blue'),
                                ),
                              ],
                            ),
                            value: 'blue',
                          ),
                        ],
                        onChanged: (String value) async {
                          setState(() => _value = value);
                          analytics.logEvent(
                              name: "theme",
                              parameters: <String, dynamic>{
                                "value": value,
                              });
                          saveData("theme", value);
                        },
                      ),
                      actions: <Widget>[
                        // ignore: deprecated_member_use
                        new FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Text("Save"))
                      ],
                    );
                  });
                },
              ); */
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.signOutAlt,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "Logout",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              saveData("user", null);
              saveData("key", null);
              setState(() {
                user = null;
              });
              final snackBar = new SnackBar(
                content: new Text(
                    'All user data has been cleared. You may need to restart the app.'),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              "Ressources",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.upload,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "Upload",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              launchURL("https://d.tube/#!/upload");
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.infoCircle,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "About",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              /* return showDialog<Null>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: new Text('Content streaming app v0.1.0'),
                    content: new SingleChildScrollView(
                      child: new ListBody(
                        children: <Widget>[
                          new Text('This application is a web video player which ' +
                              'can be connected and used with various open source video ' +
                              'projects. It is open source and available on. Feel free to ' +
                              'contribute.'),
                          new Text(
                              'The distributor and developer of this app are in no way affiliated ' +
                                  'with the video project\'s company or developer.'),
                          new FlatButton(
                            onPressed: () {
                              launchURL("https://bostrot.pro/");
                            },
                            child: new Text('\nMade with ♥ by Bostrot'),
                          ),
                          new Text(
                            "and following open source libraries:",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 8.0),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL("https://github.com/flutter/flutter");
                            },
                            child: new Text('\nflutter'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL("https://fontawesome.com/");
                            },
                            child: new Text('\nfont_awesome_flutter'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL("https://github.com/flutterchina/dio");
                            },
                            child: new Text('\ndio'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://github.com/rinukkusu/simple_moment");
                            },
                            child: new Text('\nsimple_moment'),
                          ),
                          // ignore: deprecated_member_use
                          new FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://github.com/flutter/plugins/tree/master/packages/video_player");
                            },
                            child: new Text('\nvideo_player'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL("https://github.com/brianegan/chewie");
                            },
                            child: new Text('\nchewie'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://github.com/flutter/plugins/tree/master/packages/url_launcher");
                            },
                            child: new Text('\nurl_launcher'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://github.com/flutter/plugins/tree/master/packages/shared_preferences");
                            },
                            child: new Text('\nshared_preferences'),
                          ),
                          new FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://pub.dartlang.org/packages/screen");
                            },
                            child: new Text('\nscreen'),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ); */
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.userSecret,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "Privacy Policy",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              launchURL("https://www.iubenda.com/privacy-policy/8143066");
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              "My Links",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.rss,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "My Blog",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              launchURL("https://bostrot.pro/");
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.twitter,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "My Twitter",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              launchURL("https://twitter.com/Bostrot_");
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.newspaper,
                color: theme(selectedTheme)["accent"]),
            title: new Text(
              "My Newsletter",
              style: TextStyle(color: theme(selectedTheme)["text"]),
            ),
            onTap: () {
              launchURL("http://eepurl.com/do_FIr");
            },
          ),
        ],
      ),
    );
  }
}

class _ {}
