import 'package:flutter/material.dart';
import 'package:telsavideo/components/api.dart';
//import 'package:flutter_html_view/flutter_html_text.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String profile;
  ProfileScreen({
    required this.profile,
  });
  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: theme(selectedTheme)["background"],
        title: new Text(widget.profile),
        automaticallyImplyLeading: false,
        leading: new Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: theme(selectedTheme)["accent"],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: new FutureBuilder(
          future: steemit
              .getDiscussionsByBlog(widget.profile), // a Future<String> or null
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
                      /* videoItemList.add(buildRow(data, index, title,
                          description, permlink, context, false)); */
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
                        Text("No videos found."),
                        /*
                        HtmlText(
                          data:
                              "<a href=\"https://steemit.com/utopian-io/@bostrot/introduction-a-new-steem-dtube-search-platform\">More about this.</a>",
                        )

                         */
                      ],
                    ),
                  ));
                }
            }
          }),
    );
  }
}
