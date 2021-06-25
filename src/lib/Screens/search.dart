import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:telsavideo/components/api.dart';
import 'package:telsavideo/screens/videolist.dart';
import 'dart:convert';
//import 'package:flutter_html_view/flutter_html_text.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => new SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  var content;
  var result = "loading";
  var apiData3;
  var tags = [
    {"term": "dtube", "count": 2461},
    {"term": "life", "count": 364},
    {"term": "onelovedtube", "count": 265},
    {"term": "music", "count": 248},
    {"term": "vlog", "count": 194},
    {"term": "dtubedaily", "count": 188},
    {"term": "steemit", "count": 188},
    {"term": "news", "count": 171},
    {"term": "video", "count": 137},
    {"term": "gaming", "count": 124},
    {"term": "funny", "count": 123},
    {"term": "politics", "count": 113},
    {"term": "travel", "count": 106},
    {"term": "steem", "count": 97},
    {"term": "cryptocurrency", "count": 90},
    {"term": "bitcoin", "count": 84},
    {"term": "art", "count": 73},
    {"term": "deutsch", "count": 73},
    {"term": "spanish", "count": 71},
    {"term": "fun", "count": 64},
    {"term": "entertainment", "count": 58},
    {"term": "blog", "count": 55},
    {"term": "food", "count": 49},
    {"term": "crypto", "count": 48},
    {"term": "money", "count": 47},
    {"term": "openmic", "count": 46},
    {"term": "trump", "count": 46},
    {"term": "steempowerment", "count": 44},
    {"term": "nature", "count": 43},
    {"term": "cervantes", "count": 42},
    {"term": "mindcontrol", "count": 40},
    {"term": "comedy", "count": 39},
    {"term": "blockchain", "count": 36},
    {"term": "polish", "count": 36},
    {"term": "love", "count": 33},
    {"term": "nsfw", "count": 33},
    {"term": "freedom", "count": 31},
    {"term": "", "count": 30},
    {"term": "health", "count": 30},
    {"term": "india", "count": 28},
    {"term": "artzone", "count": 26},
    {"term": "conspiracy", "count": 26},
    {"term": "government", "count": 26},
    {"term": "magic", "count": 26},
    {"term": "podcast", "count": 26},
    {"term": "cn", "count": 25},
    {"term": "motivation", "count": 22},
    {"term": "rap", "count": 22},
    {"term": "russia", "count": 21},
    {"term": "community", "count": 20}
  ];

  getTags() async {
    var _tags = await steemit.getTrendingTags();
    setState(() {
      tags = _tags;
    });
  }

  var search;

  @override
  void initState() {
    search = "";
    getTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0),
      child: new Column(
        children: <Widget>[
          Center(
              child: Container(
                  height: 30.0, child: Image.asset('assets/DTube_Black.png'))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Title, Person or Category",
              ),
              onFieldSubmitted: (str) {
                setState(() {
                  search = str;
                });
              },
            ),
          ),
          Expanded(
            child: search != null && search != ""
                ? Column(
                    children: <Widget>[
                      new FlatButton(
                          child: Text("Reset search"),
                          onPressed: () {
                            setState(() {
                              search = null;
                            });
                          }),
                      Expanded(
                        child: new FutureBuilder(
                            future: steemit.getDiscussionsBySearch(
                                search), // a Future<String> or null
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
                                        child: new Text(
                                            'Error: ${snapshot.error}'));

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
                                        color:
                                            theme(selectedTheme)["background"],
                                        child: new GridView.builder(
                                            primary: true,
                                            itemCount: videoItemList.length,
                                            gridDelegate:
                                                new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 2.0,
                                              crossAxisCount:
                                                  isLandscape ? 4 : 2,
                                              mainAxisSpacing: 5.0,
                                            ),
                                            padding: const EdgeInsets.all(4.0),
                                            itemBuilder: (context, i) =>
                                                videoItemList[i]));
                                  } else {
                                    return Container(
                                        child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              "Nothing found for your search..."),
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
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return FlatButton(
                        child: Text(tags[index]["term"].toString()),
                        onPressed: () {
                          setState(() {
                            search = tags[index]["term"];
                          });
                        },
                      );
                    }),
          )
        ],
      ),
    );
    //body: buildSubtitles(steemit.getDiscussionsBySearch(widget.search), context, false),
  }
}
