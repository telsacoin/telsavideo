import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:simple_moment/simple_moment.dart';
import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:telsavideo/components/api.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:share/share.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:video_launcher/video_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:telsavideo/screens/profile.dart';

const String testDevice = '62293BE037B83ADC6D2F4E380A6E9456';

int initialShowAd = 3;
int tempShowAd = initialShowAd;

var moment = new Moment.now();

class VideoList extends StatefulWidget {
  @override
  VideoListState createState() => new VideoListState();
}

class VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return context.widget;
  }
}

/*
var videoItemList = <Widget>[];
    for (var i = 0; i < 100; i++) {
      {
        int index = i + jump;
        var data = apiData[tab]["result"][index];
        var permlink = data["permlink"];
        try {
          var title = data['json_metadata'].split('"title":"')[1].split('",')[0];
          String description = data['json_metadata'].split(',"description":"')[1].split('",')[0];
          videoItemList.add(buildRow(data, index, title, description, permlink));
        } catch (e) {}
      }
    }
*/

Widget buildSubtitles(Future future, context, bool heightToParent) {
  int jump = 0;
  final Orientation orientation = MediaQuery.of(context).orientation;
  final bool isLandscape = orientation == Orientation.landscape;
  return new FutureBuilder(
      future: future, // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: new Text('No connection...'));
          case ConnectionState.waiting:
            return Center(child: new CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return Center(child: new Text('Error: ${snapshot.error}'));
            else {
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
                    videoItemList.add(buildRow(data, index, title, description,
                        permlink, context, heightToParent));
                  }
                }
              }

              print(videoItemList.length);
              if (videoItemList.length > 0) {
                print("yes");
                return new Container(
                    color: theme(selectedTheme)["background"],
                    child: new ListView.builder(
                        itemCount: videoItemList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => videoItemList[i]));
              } else {
                print("no");
                return Container(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Nothing found for your search..."),
                      Html(
                        //HtmlText(
                        data:
                            "<a href=\"https://steemit.com/utopian-io/@bostrot/introduction-a-new-steem-dtube-search-platform\">More about this.</a>",
                      )
                    ],
                  ),
                ));
              }
            }
        }
      });
}

Widget _placeholderImage(
    var imgURL, var meta, context, title, data, heightToParent) {
  try {
    String duration = "00:00:00";
    try {
      double total_seconds = meta['video']['info']['duration'];
      duration =
          Duration(seconds: total_seconds.round()).toString().split(".")[0];
    } catch (e) {}
    return Stack(
      children: <Widget>[
        heightToParent
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://video.telsacoin.io/ipfs/" + imgURL,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(
                child: Image.network(
                  "https://video.telsacoin.io/ipfs/" + imgURL,
                  fit: BoxFit.fitHeight,
                ),
              ),
        Column(
          children: <Widget>[
            Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text(
                  duration,
                  style: TextStyle(color: theme(selectedTheme)["background"]),
                ),
              ),
            )
          ],
        ),
        heightToParent
            ? new Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      color: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            new Text(
                              title,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: theme(selectedTheme)["background"],
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            new Text(
                                "by " +
                                    data['author'] +
                                    " • " +
                                    (data['pending_payout_value'] != null
                                        ? "\$" +
                                            data['pending_payout_value']
                                                .replaceAll("SBD", "") +
                                            " • "
                                        : "") +
                                    moment.from(DateTime.parse(data['created'])
                                        .add(Duration(hours: 2))),
                                style: new TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                                maxLines: 1)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container(),
      ],
    );
  } catch (e) {
    print("ex" + e.toString());
    return Image.network(
      "https://video.telsacoin.io/ipfs/Qma585tFzjmzKemYHmDZoKMZHo8Ar7YMoDAS66LzrM2Lm1",
      fit: BoxFit.scaleDown,
    );
  }
}

List sources(meta) {
  var sourcesInit = [
    "480",
    "240",
    "720",
    "1080",
    "",
  ];
  List _tempSources = [];
  int b = 0;
  String _tempVideo;
  for (int i = 0; i < 5; i++) {
    _tempVideo = meta["video"]["content"]["video${sourcesInit[i]}hash"];
    if (_tempVideo != null) {
      _tempSources.add(sourcesInit[i]);
    }
    if (i == 4) {
      return _tempSources;
    }
  }
  return List.empty();
}

Widget buildRow(var data, var index, var title, var description, var permlink,
    context, heightToParent) {
  var moment = new Moment.now();
  // handle metadata from (string)json_metadata
  var meta = json.decode(
      data['json_metadata'].replaceAll(description, "").replaceAll(title, ""));
  return heightToParent
      ? Card(
          child: new InkWell(
            child: _placeholderImage(meta['video']['info']['snaphash'], meta,
                context, title, data, heightToParent),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new VideoScreen(
                          permlink: permlink,
                          data: data,
                          description: description,
                          meta: meta,
                          search: false,
                        )),
              );
            },
          ),
        )
      : new InkWell(
          child: Container(
            width: 210.0,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _placeholderImage(meta['video']['info']['snaphash'],
                      meta, context, title, data, heightToParent),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: new CircleAvatar(
                        radius: 18.0,
                        backgroundImage: new NetworkImage(
                            "https://steemitimages.com/u/" +
                                data["author"] +
                                "/avatar/big"),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            title,
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: theme(selectedTheme)["text"]),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                          new Text(
                              data['author'] +
                                  " • " +
                                  (data['pending_payout_value'] != null
                                      ? "\$" +
                                          data['pending_payout_value']
                                              .replaceAll("SBD", "") +
                                          " • "
                                      : "") +
                                  moment.from(DateTime.parse(data['created'])
                                      .add(Duration(hours: 2))),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: theme(selectedTheme)["accent"]),
                              maxLines: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new VideoScreen(
                        permlink: permlink,
                        data: data,
                        description: description,
                        meta: meta,
                        search: false,
                      )),
            );
          },
          onLongPress: () async {
            return showDialog<Null>(
              context: context,
              builder: (BuildContext dialogContext) {
                List<Widget> resolutions = <Widget>[];
                print(sources(meta));
                for (int i = 0; i < sources(meta).length; i++) {
                  String _tempName = "";
                  switch (sources(meta)[i]) {
                    case "240":
                      _tempName = "SD - 240p";
                      break;
                    case "480":
                      _tempName = "SD - 480p";
                      break;
                    case "720":
                      _tempName = "HD - 720p";
                      break;
                    case "1080":
                      _tempName = "HD - 1080p";
                      break;
                    case "":
                      _tempName = "Source (Highest)";
                      break;
                  }
                  resolutions.add(FlatButton(
                    onPressed: () {
                      downloadFile(
                          meta["video"]["content"]
                              ["video${sources(meta)[i]}hash"],
                          false,
                          context,
                          title);
                      Navigator.pop(dialogContext);
                    },
                    child: Text(
                      _tempName,
                      style: TextStyle(color: theme(selectedTheme)["text"]),
                    ),
                  ));
                  if (i == sources(meta).length - 1) {
                    resolutions.add(FlatButton(
                      onPressed: () {
                        downloadFile(
                            meta["video"]["content"]
                                ["video${sources(meta)[i]}hash"],
                            true,
                            context,
                            title);
                        Navigator.pop(dialogContext);
                      },
                      child: Text(
                        "Audio only",
                        style: TextStyle(
                          color: theme(selectedTheme)["text"],
                        ),
                      ),
                    ));
                  }
                }
                return new AlertDialog(
                    title: Text("Select video quality:"),
                    content: SingleChildScrollView(
                      child: Column(children: resolutions),
                    ));
              },
            );
          },
        );
}

class VideoScreen extends StatefulWidget {
  final String permlink;
  final data;
  final description;
  final meta;
  final search;
  VideoScreen({
    this.data,
    this.search,
    required this.permlink,
    this.description,
    this.meta,
  });
  @override
  VideoScreenState createState() => new VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  // colors for videos
  var upvoteColor = theme(selectedTheme)["accent"];
  var downvoteColor = theme(selectedTheme)["accent"];
  // colors for comments
  var upvoteColors = {};
  var downvoteColors = {};

  var subscribeColor = Colors.white;
  var subscribeButtonColor = Colors.red;
  var subscribed = "Subscribe";
  var gateway = "https://video.dtube.top/ipfs/";
  late Chewie chewiePlayer;
  late VideoPlayerController videoController;

  var _ios = Platform.isIOS;
  late InterstitialAd myInterstitial;

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    keywords: <String>[
      'crypto',
      'dtube',
      'business',
      'currency',
      'blockchain',
      'bitcoin',
      'steem',
      'steemit'
    ],
    contentUrl: 'https://video.telsacoin.io',
    childDirected: false,
    designedForFamilies:
        false, // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[
      testDevice
    ], // Android emulators are considered test devices
  );

  @override
  void initState() {
    super.initState();
    getVideo(widget.permlink, widget.data["author"]);
    if (_ios == true) {
      FirebaseAdMob.instance
          .initialize(appId: "ca-app-pub-9430927632405311~9708042281");
    } else {
      FirebaseAdMob.instance
          .initialize(appId: "ca-app-pub-9430927632405311~3245387668");
    }
    if (_ios == true) {
      myInterstitial = new InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: "ca-app-pub-9430927632405311/9921156081",
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );
    } else {
      myInterstitial = new InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: "ca-app-pub-9430927632405311/4144105868",
        listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );
    }
    myInterstitial..load();
    initializeNotifications();
  }

  double sliderValue = 0.0;
  var content;
  var result = "loading";
  getVideo(var permlink, var author) async {
    Dio dio = new Dio();
    Response response = await dio.post("https://api.steemit.com", data: {
      "id": 0,
      "jsonrpc": "2.0",
      "method": "call",
      "params": [
        "database_api",
        "get_state",
        ["/dtube/@" + author + "/" + permlink]
      ]
    });
    content = response.data["result"]["content"];
    var _temp = await retrieveData("gateway");
    setState(() {
      result = "loaded";
      gateway = _temp;
    });

    if (videoController == null) {
      setState(() {
        videoController = VideoPlayerController.network(gateway +
            widget.meta["video"]["content"]["video${sources()[0]}hash"]);

        ChewieController chewieController = new ChewieController(
          videoPlayerController: videoController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: false,
          placeholder: new Container(
              child: Image.network("https://video.telsacoin.io/ipfs/" +
                  widget.meta['video']['info']['snaphash'])),
        );

        Chewie chewiePlayer = new Chewie(controller: chewieController);

//        chewiePlayer = new Chewie(
//          videoController,
//          aspectRatio: 16 / 9,
//          autoPlay: true,
//          looping: false,
//          placeholder: new Container(
//              child: Image.network("https://video.telsacoin.io/ipfs/" +
//                  widget.meta['video']['info']['snaphash'])),
//        );
      });
    }
  }

  List sources() {
    var sourcesInit = [
      "480",
      "240",
      "720",
      "1080",
      "",
    ];
    List _tempSources = [];
    int b = 0;
    String _tempVideo;
    for (int i = 0; i < 5; i++) {
      _tempVideo =
          widget.meta["video"]["content"]["video${sourcesInit[i]}hash"];
      if (_tempVideo != null) {
        _tempSources.add(sourcesInit[i]);
      }
      if (i == 4) {
        return _tempSources;
      }
    }
    return List.empty();
  }

  setSlider(e) {
    setState(() {
      sliderValue = e;
    });
  }

  //getVideo(permlink);
  @override
  Widget build(BuildContext contextWidget) {
    Screen.keepOn(true);
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        backgroundColor: theme(selectedTheme)["background"],
        body: result == "loading"
            ? Center(child: new CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (contextListViewBuilder, index) {
                        if (index == 0)
                          return new Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  // ignore: unnecessary_null_comparison
                                  videoController != null
                                      ? chewiePlayer
                                      : new CircularProgressIndicator(),
                                  new IconButton(
                                    icon: new Icon(
                                      Icons.arrow_back,
                                      color: theme(selectedTheme)["accent"],
                                    ),
                                    onPressed: () async {
                                      videoController.pause();
                                      tempShowAd--;
                                      if (tempShowAd == 0 &&
                                          await retrieveData("no_ads") ==
                                              null) {
                                        myInterstitial
                                          ..load()
                                          ..show().then((e) {
                                            myInterstitial..load();
                                          });
                                        tempShowAd = initialShowAd;
                                      }
                                      Navigator.pop(contextWidget);
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      widget.data["title"],
                                      style: TextStyle(
                                          color: theme(selectedTheme)["text"],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                  new Text(
                                    "\$" +
                                        (widget.search
                                                ? widget.data["payout"]
                                                : widget.data[
                                                    "pending_payout_value"])
                                            .toString()
                                            .replaceFirst(" SBD", ""),
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: theme(selectedTheme)["accent"]),
                                  ),
                                ],
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // interaction row
                                    new IconButton(
                                        icon: const Icon(Icons.thumb_up),
                                        color: upvoteColor,
                                        onPressed: () {
                                          if (downvoteColor !=
                                              theme(selectedTheme)["accent"]) {
                                            setState(() {
                                              downvoteColor = theme(
                                                  selectedTheme)["accent"];
                                            });
                                          }
                                          setState(() {
                                            upvoteColor =
                                                theme(selectedTheme)["primary"];
                                          });
                                          return voteDialog(
                                              true,
                                              widget.data["author"],
                                              widget.permlink,
                                              contextListViewBuilder);
                                        }),
                                    new IconButton(
                                        icon: const Icon(Icons.thumb_down),
                                        color: downvoteColor,
                                        onPressed: () {
                                          if (upvoteColor !=
                                              theme(selectedTheme)["accent"]) {
                                            setState(() {
                                              upvoteColor = theme(
                                                  selectedTheme)["accent"];
                                            });
                                          }
                                          setState(() {
                                            downvoteColor =
                                                theme(selectedTheme)["primary"];
                                          });
                                          return voteDialog(
                                              false,
                                              widget.data["author"],
                                              widget.permlink,
                                              contextListViewBuilder);
                                        }),
                                    new IconButton(
                                      icon: const Icon(Icons.share),
                                      color: theme(selectedTheme)["accent"],
                                      onPressed: () {
                                        Share.share(
                                            "https://video.telsacoin.io/v/" +
                                                widget.data["author"] +
                                                "/" +
                                                widget.data["permlink"]);
                                      },
                                    ),
                                    new IconButton(
                                      icon: const Icon(Icons.file_download),
                                      color: theme(selectedTheme)["accent"],
                                      onPressed: () async {
                                        return showDialog<Null>(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            List<Widget> resolutions =
                                                <Widget>[];
                                            print(sources());
                                            for (int i = 0;
                                                i < sources().length;
                                                i++) {
                                              String? _tempName;
                                              switch (sources()[i]) {
                                                case "240":
                                                  _tempName = "SD - 240p";
                                                  break;
                                                case "480":
                                                  _tempName = "SD - 480p";
                                                  break;
                                                case "720":
                                                  _tempName = "HD - 720p";
                                                  break;
                                                case "1080":
                                                  _tempName = "HD - 1080p";
                                                  break;
                                                case "":
                                                  _tempName =
                                                      "Source (Highest)";
                                                  break;
                                              }
                                              resolutions.add(FlatButton(
                                                onPressed: () {
                                                  downloadFile(
                                                      widget.meta["video"]
                                                              ["content"][
                                                          "video${sources()[i]}hash"],
                                                      false,
                                                      contextListViewBuilder,
                                                      widget.meta["title"]);
                                                  Navigator.pop(dialogContext);
                                                },
                                                child: Text(
                                                  _tempName!,
                                                  style: TextStyle(
                                                      color:
                                                          theme(selectedTheme)[
                                                              "text"]),
                                                ),
                                              ));
                                              if (i == sources().length - 1) {
                                                // ignore: deprecated_member_use
                                                resolutions.add(FlatButton(
                                                  onPressed: () {
                                                    downloadFile(
                                                        widget.meta["video"]
                                                                ["content"][
                                                            "video${sources()[i]}hash"],
                                                        true,
                                                        contextListViewBuilder,
                                                        widget.meta["title"]);
                                                    Navigator.pop(
                                                        dialogContext);
                                                  },
                                                  child: Text(
                                                    "Audio only",
                                                    style: TextStyle(
                                                      color:
                                                          theme(selectedTheme)[
                                                              "text"],
                                                    ),
                                                  ),
                                                ));
                                              }
                                            }
                                            return new AlertDialog(
                                                title: Text(
                                                    "Select video quality:"),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                      children: resolutions),
                                                ));
                                          },
                                        );
                                      },
                                    ),
                                    new IconButton(
                                      icon: const Icon(Icons.open_in_new),
                                      color: theme(selectedTheme)["accent"],
                                      onPressed: () {
                                        launchVideo(videoController.dataSource);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              new Divider(
                                height: 1.0,
                                color: theme(selectedTheme)["text"],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 10.0),
                                child: new Row(
                                  // avatar, name, subscribe row
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new ProfileScreen(
                                                        profile: widget
                                                            .data["author"])));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          new Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: new CircleAvatar(
                                              radius: 18.0,
                                              backgroundImage: new NetworkImage(
                                                  "https://steemitimages.com/u/" +
                                                      widget.data["author"] +
                                                      "/avatar/big"),
                                            ),
                                          ),
                                          new Text(
                                            widget.data["author"],
                                            style: TextStyle(
                                              color:
                                                  theme(selectedTheme)["text"],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // ignore: deprecated_member_use
                                    new RaisedButton(
                                      color: subscribeButtonColor,
                                      onPressed: () async {
                                        setState(() {
                                          subscribed = subscribed == "Subscribe"
                                              ? "Unsubscribe"
                                              : "Subscribe";
                                          subscribeColor =
                                              subscribed == "Subscribe"
                                                  ? Colors.white
                                                  : Colors.white;
                                          subscribeButtonColor =
                                              subscribed == "Subscribe"
                                                  ? Colors.red
                                                  : Colors.grey;
                                        });
                                        await broadcastSubscribe(
                                            contextListViewBuilder,
                                            widget.data["author"],
                                            subscribed == "Subscribe"
                                                ? true
                                                : false);
                                      },
                                      child: new Text(subscribed,
                                          style: new TextStyle(
                                              color: subscribeColor)),
                                    ),
                                  ],
                                ),
                              ),
                              new Divider(
                                height: 1.0,
                                color: theme(selectedTheme)["text"],
                              ),
                              new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          "added " +
                                              moment.from(DateTime.parse(
                                                      widget.data["created"])
                                                  .add(Duration(hours: 2))),
                                          style: TextStyle(
                                            color: theme(selectedTheme)["text"],
                                          ),
                                        ),
                                      ),
                                      new Html(
                                          data: theme(selectedTheme)["text"] ==
                                                  Colors.white
                                              ? "<p style=\"color: #fff;\">" +
                                                  linkify(
                                                      (widget.description)) +
                                                  "</p>"
                                              : linkify((widget.description))),
                                      new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new TextField(
                                          decoration: new InputDecoration(
                                              hintText: 'Comment something...',
                                              hintStyle: TextStyle(
                                                color: theme(
                                                    selectedTheme)["text"],
                                              )),
                                          onSubmitted: (comment) {
                                            broadcastComment(
                                                contextListViewBuilder,
                                                widget.data["author"],
                                                widget.permlink,
                                                comment.toString());
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                              new Divider(),
                              // TODO: comments class
                            ],
                          );
                        else if (index > 0) {
                          try {
                            var reply = content[content[widget.data["author"] +
                                    "/" +
                                    widget.permlink]["replies"][index - 1]
                                .toString()];
                            var comment = linkify(reply["body"]);
                            if ((reply["body"].toString()).length > 100) {
                              comment = linkify(reply["body"].substring(0, 100))
                                      .toString() +
                                  "...";
                            }
                            return new Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new ExpansionTile(
                                title: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new CircleAvatar(
                                          radius: 13.0,
                                          backgroundImage: new NetworkImage(
                                              "https://steemitimages.com/u/" +
                                                  reply["author"] +
                                                  "/avatar/small"),
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text(
                                                reply["author"],
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  new Text(
                                                    moment.from(DateTime.parse(
                                                            reply["created"])
                                                        .add(Duration(
                                                            hours: 2))),
                                                    style: TextStyle(
                                                        color: theme(
                                                                selectedTheme)[
                                                            "accent"],
                                                        fontSize: 12.0),
                                                  ),
                                                  new Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0),
                                                    child: new Text(
                                                        "\$" +
                                                            reply["pending_payout_value"]
                                                                .toString()
                                                                .replaceFirst(
                                                                    "SBD", ""),
                                                        style: TextStyle(
                                                            color: theme(
                                                                    selectedTheme)[
                                                                "accent"],
                                                            fontSize: 12.0)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Text(
                                      comment,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: theme(selectedTheme)["text"],
                                      ),
                                    ),
                                  ],
                                ),
                                children: <Widget>[
                                  new Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: (reply["body"].toString()).length >
                                            100
                                        ? new Html(data: linkify(reply["body"]))
                                        : new Container(),
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new IconButton(
                                            icon: const Icon(Icons.thumb_up),
                                            color: upvoteColors[
                                                    reply["permlink"]] ??
                                                theme(selectedTheme)["accent"],
                                            onPressed: () {
                                              print(reply["permlink"]);
                                              if (downvoteColors[
                                                      reply["permlink"]] !=
                                                  null) {
                                                setState(() {
                                                  downvoteColors.remove(
                                                      reply["permlink"]);
                                                });
                                              }
                                              setState(() {
                                                upvoteColors[
                                                        reply["permlink"]] =
                                                    theme(selectedTheme)[
                                                        "primary"];
                                              });
                                              return voteDialog(
                                                  true,
                                                  reply["author"],
                                                  reply["permlink"],
                                                  contextListViewBuilder);
                                            }),
                                      ),
                                      new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new IconButton(
                                            icon: const Icon(Icons.thumb_down),
                                            color: downvoteColors[
                                                    reply["permlink"]] ??
                                                theme(selectedTheme)["accent"],
                                            onPressed: () {
                                              if (upvoteColors[
                                                      reply["permlink"]] !=
                                                  null) {
                                                setState(() {
                                                  upvoteColors.remove(
                                                      reply["permlink"]);
                                                });
                                              }
                                              setState(() {
                                                downvoteColors[
                                                        reply["permlink"]] =
                                                    theme(selectedTheme)[
                                                        "primary"];
                                              });
                                              return voteDialog(
                                                  false,
                                                  reply["author"],
                                                  reply["permlink"],
                                                  contextListViewBuilder);
                                            }),
                                      ),
                                    ],
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new TextField(
                                      decoration: new InputDecoration(
                                          hintText: 'Comment something...',
                                          hintStyle: TextStyle(
                                            color: theme(selectedTheme)["text"],
                                          )),
                                      onSubmitted: (comment) {
                                        broadcastComment(
                                            contextListViewBuilder,
                                            reply["author"],
                                            reply["permlink"],
                                            comment);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            );
                          } catch (e) {
                            throw e;
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /*
  bool vote
  true - upvote
  false - downvote
   */

  voteDialog(bool vote, var author, var permlink, contextListViewBuilder) {
    print("slider: $sliderValue");
    return showDialog(
      context: contextListViewBuilder,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contextDialog) {
        return new StatefulBuilder(
            builder: (BuildContext contextStatefulBuilder, setState) {
          return new AlertDialog(
            title: new Text('Select Upvoting power'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 10.0, right: 10.0),
                    child: new Slider(
                      activeColor: Colors.red,
                      onChanged: (e) {
                        setState(() {
                          sliderValue = e;
                        });
                      },
                      value: sliderValue != null ? sliderValue : 10.0,
                      min: 10.0,
                      max: 100.0,
                      divisions: 9,
                      label: sliderValue.toString(),
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CLOSE'),
                onPressed: () {
                  Navigator.of(contextStatefulBuilder, rootNavigator: true)
                      .pop(result);
                },
              ),
              new FlatButton(
                child: new Text(vote ? 'UPVOTE' : 'DOWNVOTE'),
                onPressed: () {
                  Navigator.of(contextStatefulBuilder, rootNavigator: true)
                      .pop(result);
                  broadcastVote(contextStatefulBuilder, author, permlink,
                      vote ? toInt(sliderValue) : toInt(sliderValue) * -1);
                },
              ),
            ],
          );
        });
      },
    );
  }

  Future<bool> _onWillPop() async {
    videoController.pause();
    tempShowAd--;
    if (tempShowAd == 0 && await retrieveData("no_ads") == null) {
      myInterstitial
        ..load()
        ..show().then((e) {
          myInterstitial..load();
        });
      tempShowAd = initialShowAd;
    }
    Navigator.of(context).pop(true);

    return true;
  }
}

setDownloadedFile(url, filename, directory, size) async {
  List<String> _temp = await retrieveDataMap("downloads");
  if (_temp == null) {
    _temp = <String>[];
  }
  _temp.add('{"url": "' +
      url +
      '", "name": "' +
      filename +
      '", "path": "' +
      directory.path +
      '/Download/' +
      filename +
      '", "size": "' +
      size.toString() +
      '"}');
  print(_temp);
  saveDataMap("downloads", _temp);
}

downloadFile(var url, bool audio, contextListViewBuilder, title) async {
  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
  ].request();
  //Map<PermissionGroup, PermissionStatus> permissions =
  //    await PermissionHandler.requestPermissions([PermissionGroup.storage]);
  print("permission request result is " +
      statuses[Permission.location].toString());

  if (true) {
    toast(
        contextListViewBuilder,
        "Downloading " +
            title.replaceAll(" ", "_") +
            ".mp4. You will be notified once it's done.");
    final directory = await getExternalStorageDirectory();
    String filename = title.replaceAll(" ", "_").replaceAll(".", "") +
        (audio ? ".mp3" : ".mp4");

    url = "https://video.telsacoin.io/ipfs/" + url;
    print(url);
    final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: directory!.path + "/Download/",
        fileName: filename,
        showNotification:
            true // show download progress in status bar (for Android)
        );
    var done = false;
    FlutterDownloader.registerCallback((id, status, progress) {
      if (progress == 100 && !done) {
        done = true;
        // save link to settings
        setDownloadedFile(
            url, filename, directory, directory.path + "/Download/");
      }
    });
    /*Dio dio = new Dio();
    Response response = await dio.download(videoController.dataSource, directory.path + "/Download/" + filename, onProgress: (progressedSize, size) {
      if (progressedSize == size) {
        // show notification
        print("finished");
        showNotification("Download finished", filename);
        // save link to settings
        setDownloadedFile(filename, directory, size);
      }
    });

    print(response);
    */
  }
  //launchURL("https://video.telsacoin.io/ipfs/QmcL62wVn2pHrBrrWXjmtP7TnJtwzXGCY8bYQSEUfjyZpD");
}
