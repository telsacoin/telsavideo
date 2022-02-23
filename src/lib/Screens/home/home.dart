import 'dart:async';
import 'dart:convert';
import 'dart:developer' as develop;
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:telsavideo/Screens/video.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/models/video/DTok.dart';
import 'package:telsavideo/screens/home/videoplayer.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/profile/creator_profile.dart';
import 'package:telsavideo/screens/notifications_messages/notifications.dart';
import 'package:telsavideo/screens/record_video/record_video.dart';
import 'package:telsavideo/screens/search/search.dart';
import 'package:video_player/video_player.dart';
import 'package:telsavideo/screens/profile/profile.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  bool abo = false;
  bool foryou = true;
  bool play = true;
  bool search = false;
  bool notifications = false;
  bool me = false;
  bool home = true;
  bool like = false;
  late VideoPlayerController _controller;
  //late VideoPlayerController _musicController;
  //late AnimationController animationController;
  late Future<DTok> videos;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  // ScrollController _scrollController = ScrollController(initialScrollOffset:0);
  PageController foryouController = new PageController();

  Future<DTok> getVideos() async {
    String url = apiUrl;
    if (kDebugMode) {
      url = apiDevUrl;
    }
    //url += "/get_posts_by_filters";
    url += "/recommend/item_list";
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
    DTok dTok = new DTok();
    try {
      var response = await dio.get(url);
      print(response);

      var data = json.encode(response.data);
      var dData = json.decode(data);

      DTok dTok = DTok.fromJson(dData);
      List<ItemList> list=[];
      for(ItemList itemList in dTok.itemList!){
          if(itemList.video!.playAddr?.isNotEmpty==true){
              list.add(itemList);
          }
      }
      dTok.itemList=list;
      print(dTok);
      return dTok;
    } catch (e) {
      print(e);
    }
    return dTok;

    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    var code = prefs.getString('code');
    var map = Map<String, dynamic>();
    map["filters"] = "trending";
    var query = Map<String, dynamic>();
    query["tag"] = "telsacoin";
    query["limit"] = 10;
    map["query"] = query;

    dio.options.headers = {
      'Content-Type': 'application/json',
      'authorization': code
    };
    try {
      var response = await dio.post(url,
          data: map, options: Options(contentType: "application/json"));
      print(response);
      print(url);
      if (response.statusCode == 200) {
        video = List<Video>.from(json
            .decode(json.encode(response.data))
            .map((x) => Video.fromJson(x)));
      }
    } catch (e) {
      print(e);
    } */
    //return DTok();
  }

  @override
  void initState() {
    super.initState();
    videos = getVideos();
    _controller = VideoPlayerController.network("http://appmedia.qq.com/media/cross/assets/uploadFile/20170523/5923d26dac66b.mp4")..initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              (home)
                  ? homescreen()
                  : (search)
                      ? Search()
                      : (notifications)
                          ? Notifications()
                          : Profile(),
              Positioned(
                bottom: 0.0,
                child: footer(),
              ),
              (home)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              setState(() {
                                abo = true;
                                foryou = false;
                              });
                            },
                            child: Text('Following',
                                style: abo
                                    ? TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)
                                    : TextStyle(
                                        color: Colors.white, fontSize: 16))),
                        Text('|',
                            style: TextStyle(color: Colors.white, fontSize: 5)),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                abo = false;
                                foryou = true;
                              });
                            },
                            child: Text('For You',
                                style: foryou
                                    ? TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)
                                    : TextStyle(
                                        color: Colors.white, fontSize: 16))),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        onWillPop: () async {
          bool exitStatus = onWillPop();
          if (exitStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    return true;
  }

  // Home Screen Code Start
  homescreen() {
    if (foryou) {
      return FutureBuilder<DTok>(
          future: videos,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading;
            } else if (snapshot.hasData) {
              return PageView.builder(
                  controller: foryouController,
                  onPageChanged: (index) {
                    //when the video is changing, release the previous video instance.
                    //disposeVideo();
                    setState(() {});
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.itemList!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.itemList![index];
                    return Videoplayer(
                      item: item,
                      width: MediaQuery.of(context).size.width,
                      heigth: MediaQuery.of(context).size.height,
                    );
                  });
            } else {
              return Loading;
            }
          });
    } else {
      _controller.play();
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Text(
                        'Trendy creators',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text('Follow to an account to discover its',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8))),
                          ),
                          Center(
                            child: Text('Latest videos here.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8))),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 372,
                margin: EdgeInsets.only(top: 25),
                child: PageView.builder(
                    dragStartBehavior: DragStartBehavior.down,
                    controller: pageController,
                    itemCount: 5,
                    itemBuilder: (context, position) {
                      return videoSlider(position);
                    }),
              )
            ],
          ));
    }
  }
  // Home Screen Code end

  // Home Screen Related Page Video Slider Start
  videoSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 372,
            width: Curves.easeInOut.transform(value) * 300,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: VideoPlayer(_controller),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 370 / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage('assets/spook.png'),
                        radius: 30,
                      ),
                    ),
                    onTap: () => {_controller.pause()},
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child:
                          Text('DTok', style: TextStyle(color: Colors.white))),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatorProfileScreen()));
                    },
                    child: Text('@telsacoin',
                        style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50, right: 50, top: 12),
                      decoration: BoxDecoration(
                        color: Color(0xfe2b54).withOpacity(1),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  // Home Screen Related Page Video Slider End

  // Bottom Navigation Footer Start
  footer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.7,
            color: Colors.white.withOpacity(0.6),
          ),
          Container(
            color: (home) ? Colors.transparent : Colors.black,
            height: 60.0,
            child: Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          _controller.pause();
                          setState(() {
                            home = true;
                            search = false;
                            notifications = false;
                            me = false;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.home,
                                color: (home)
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.8),
                                size: 30),
                            Text('Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _controller.pause();
                        setState(() {
                          home = false;
                          search = true;
                          notifications = false;
                          me = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search,
                              color: (search)
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.8),
                              size: 30),
                          Text('Discover',
                              style: TextStyle(
                                  color: (search)
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.8),
                                  fontSize: 10))
                        ],
                      ),
                    ),
                    buttonplus(),
                    InkWell(
                      onTap: () {
                        _controller.pause();
                        setState(() {
                          home = false;
                          search = false;
                          notifications = true;
                          me = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.notifications_none,
                              color: (notifications)
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.8),
                              size: 30),
                          Text('Notifications',
                              style: TextStyle(
                                  color: (notifications)
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.8),
                                  fontSize: 10))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          _controller.pause();
                          setState(() {
                            home = false;
                            search = false;
                            notifications = false;
                            me = true;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.person,
                                color: (me)
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.8),
                                size: 30),
                            Text('Me',
                                style: TextStyle(
                                    color: (me)
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.8),
                                    fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
  // Bottom Navigation Footer End

  Future<List<CameraDescription>> startCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    var cameras = await availableCameras();
    develop.log("摄像头启动正常");
    return cameras;
  }

  // Plus Button Start
  buttonplus() {
    return InkWell(
      onTap: () {
        _controller.pause();
        startCamera().then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecordVideo(cameras: value)))
            });
        ;
      },
      child: Container(
        width: 46,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 28,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0x2dd3e7).withOpacity(1)),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 28,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xed316a).withOpacity(1)),
              ),
            ),
            Center(
              child: Container(
                width: 28,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Center(child: Icon(Icons.add, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
  // Plus Button End
}
