import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:telsavideo/screens/profile.dart';
import 'package:telsavideo/screens/profile/creator_profile.dart';
import 'package:telsavideo/screens/notifications_messages/notifications.dart';
import 'package:telsavideo/screens/record_video/record_video.dart';
import 'package:telsavideo/screens/search/search.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
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
  late AnimationController animationController;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  // ScrollController _scrollController = ScrollController(initialScrollOffset:0);
  PageController foryouController = new PageController();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationController.repeat();
    _controller = VideoPlayerController.asset('assets/vod_1.mp4')
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    animationController.dispose();
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
      return PageView.builder(
          controller: foryouController,
          onPageChanged: (index) {
            setState(() {
              _controller.seekTo(Duration.zero);
              _controller.play();
            });
          },
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      setState(() {
                        if (play) {
                          _controller.pause();
                          play = !play;
                        } else {
                          _controller.play();
                          play = !play;
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text(
                              '@saraalikhan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(text: 'Eiffel Tower '),
                                  TextSpan(
                                      text: '#beautiful\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'See the translation',
                                      style: TextStyle(fontSize: 12))
                                ]),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.music_note,
                                    size: 16, color: Colors.white),
                                Text('R10 - Oboy',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 65, right: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 70,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 23),
                              width: 40,
                              height: 50,
                              child: Stack(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreatorProfileScreen()));
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 19,
                                        backgroundColor: Colors.black,
                                        backgroundImage:
                                            AssetImage('assets/spook.png'),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          Color(0xfd2c58).withOpacity(1),
                                      child: Center(
                                          child: Icon(Icons.add,
                                              size: 15, color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        like = !like;
                                      });
                                    },
                                    child: Icon(Icons.favorite,
                                        size: 30.0,
                                        color:
                                            (like) ? Colors.red : Colors.white),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    '427.9K',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Icon(Icons.sms,
                                            size: 30, color: Colors.white)),
                                    SizedBox(height: 3.0),
                                    Text(
                                      '2051',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(Icons.reply,
                                          size: 30, color: Colors.white)),
                                  SizedBox(height: 3.0),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                              animation: animationController,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0x222222).withOpacity(1),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage:
                                      AssetImage('assets/oboy.jpg'),
                                ),
                              ),
                              builder: (context, _widget) {
                                return Transform.rotate(
                                    angle: animationController.value * 6.3,
                                    child: _widget);
                              },
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            );
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
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage('assets/spook.png'),
                        radius: 30,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child:
                          Text('Sara', style: TextStyle(color: Colors.white))),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatorProfileScreen()));
                    },
                    child: Text('@saraalikhan',
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

  // Plus Button Start
  buttonplus() {
    return InkWell(
      onTap: () {
        _controller.pause();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RecordVideo()));
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
