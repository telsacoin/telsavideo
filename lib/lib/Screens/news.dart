import 'package:flutter/material.dart';
import 'package:telsavideo/components/core.dart';
import 'dart:convert';
import 'package:telsavideo/screens/videolist.dart';

class NewsScreen extends StatefulWidget {
  @override
  NewsScreenState createState() => new NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: steemit.getDiscussionsByCreated(), // a Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: new Text('No connection...'));
            case ConnectionState.waiting:
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new CircularProgressIndicator(),
              ));
            default:
              if (snapshot.hasError)
                return Center(child: new Text('Error: ${snapshot.error}'));

              int jump = 0;
              final Orientation orientation =
                  MediaQuery.of(context).orientation;
              final bool isLandscape = orientation == Orientation.landscape;

              var videoItemList = <Widget>[];
              for (var i = 0; i < snapshot.data["result"].length; i++) {
                {
                  int index = i + jump;
                  var data = snapshot.data["result"][index];
                  var permlink = data["permlink"];
                  if (json.decode(data['json_metadata'])["video"] != null) {
                    var title = data['title'];
                    String description;
                    description = json.decode(data['json_metadata'])["video"]
                        ["content"]["description"];
                    /* videoItemList.add(buildRow(data, index, title, description,
                        permlink, context, false)); */
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
                        itemBuilder: (context, i) => videoItemList[i]));
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
        });
  }
}
