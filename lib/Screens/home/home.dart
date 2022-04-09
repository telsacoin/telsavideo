import 'dart:async';
import 'dart:developer' as develop;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telsavideo/api/api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telsavideo/http/util.dart';
import 'package:telsavideo/models/dto/recommend/itemlist_dto.dart';
import 'package:telsavideo/models/vo/recommend/itemlist_vo.dart';
import 'package:telsavideo/screens/home/videoplayer.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/login/login.dart';
import 'package:telsavideo/screens/notifications_messages/notifications.dart';
import 'package:telsavideo/screens/record_video/record_video.dart';
import 'package:telsavideo/screens/search/search.dart';
import 'package:video_player/video_player.dart';
import 'package:telsavideo/screens/profile/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool abo = false;
  bool foryou = true;
  bool play = true;
  bool search = false;
  bool notifications = false;
  bool me = false;
  bool home = true;
  bool like = false;
  bool isLogin = false;
  int cursor = 0;
  ItemListDto dto = new ItemListDto(0, 10);
  late Future<ItemListVo> foryouVideos;
  late Future<ItemListVo> followingVideos;

  PageController pageController = PageController(keepPage: true);

  PageController foryouController = new PageController(keepPage: true);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void checkIsLogin() {
    Util.getBool('isLogin').then((value) => {
          isLogin = value!,
          isLogin
              ? null
              : Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()))
        });
  }

  /// get refresh recommend videos
  void _onRefresh() async {
    cursor++;
    dto.cursor = cursor;
    foryouVideos = Api.getRecommendItemList(dto);
    _refreshController.refreshCompleted();
  }

  void _onRefreshFollowingVideos() async {
    cursor++;
    dto.cursor = cursor;
    foryouVideos = Api.getFollowingItemList(dto);
    _refreshController.refreshCompleted();
  }

  /// get first loading recomment videos
  void _onLoading() async {
    dto.cursor = 0;
    foryouVideos = Api.getRecommendItemList(dto);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    dto.cursor = cursor;
    foryouVideos = Api.getRecommendItemList(dto);
    followingVideos = Api.getFollowingItemList(dto);
    checkIsLogin();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
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
                            child: Text(
                                AppLocalizations.of(context)!
                                    .home_top_following,
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
                            child: Text(
                                AppLocalizations.of(context)!.home_top_foryou,
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
    cursor = 0;
    if (foryou) {
      return SmartRefresher(
          controller: _refreshController,
          onRefresh: () {
            develop.log('click refresh');
            _onRefresh();
          },
          onLoading: () {
            develop.log('click loading');
            _onLoading();
          },
          child: FutureBuilder<ItemListVo>(
              future: foryouVideos,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loading;
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error, Please restart your app agagin')
                      ],
                    );
                  } else if (snapshot.hasData) {
                    try {
                      return PageView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: foryouController,
                          onPageChanged: (index) {
                            develop.log(
                                "current index is ${index}, the length is ${snapshot.data!.itemList!.length}");
                            if (index == snapshot.data!.itemList!.length - 1) {
                              develop.log('this item is the last page');
                              _onRefresh();
                            }
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
                    } catch (e) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          'Error, Please restart your app again.',
                          style: TextStyle(color: Colors.white),
                        )),
                      );
                    }
                  } else {
                    // empty data
                    return loading;
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }));
    } else {
      cursor = 0;
      return SmartRefresher(
          controller: _refreshController,
          onRefresh: () {
            develop.log('click refresh');
            _onRefresh();
          },
          onLoading: () {
            develop.log('click loading');
            _onLoading();
          },
          child: FutureBuilder<ItemListVo>(
              future: followingVideos,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loading;
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    if (!isLogin) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 24,
                              color: Colors.black,
                              child: Column(
                                children: [
                                  SizedBox(height: 150),
                                  Center(
                                      child: Text(
                                    'Log in to see videos from creators you follow',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 0),
                                    child: MaterialButton(
                                      padding: EdgeInsets.all(0.0),
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              200,
                                      height: 42.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(42.5)),
                                      onPressed: () {
                                        develop.log('you have logined');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      },
                                      child: Text('Log in',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 24,
                            color: Colors.black,
                            child: Center(
                                child: Text(
                              'Error, Please restart your app again.',
                              style: TextStyle(color: Colors.white),
                            )),
                          )
                        ],
                      );
                    }
                  } else if (snapshot.hasData) {
                    try {
                      return PageView.builder(
                          controller: foryouController,
                          onPageChanged: (index) {
                            //when the video is changing, release the previous video instance.
                            develop.log(
                                "current index is ${index}, the length is ${snapshot.data!.itemList!.length}");
                            if (index == snapshot.data!.itemList!.length - 1) {
                              develop.log('this item is the last page');
                              _onRefreshFollowingVideos();
                            }
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
                    } catch (e) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          'Error, Please restart your app again.',
                          style: TextStyle(color: Colors.white),
                        )),
                      );
                    }
                  } else {
                    // empty data
                    return loading;
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }));
    }
  }
  // Home Screen Code end

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
                          //_controller.pause();
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
                            Text(
                                AppLocalizations.of(context)!.home_buttom_title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('you click the discover button');
                        if (isLogin) {
                          develop.log('you have logined');
                          setState(() {
                            home = false;
                            search = true;
                            notifications = false;
                            me = false;
                          });
                        } else {
                          develop.log('you didn\'t, pls login your app');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }
                        //_controller.pause();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search,
                              color: (search)
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.8),
                              size: 30),
                          Text(
                              AppLocalizations.of(context)!
                                  .home_buttom_discover,
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
                        //_controller.pause();
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
                          Text(
                              AppLocalizations.of(context)!
                                  .home_buttom_notification,
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
                          //_controller.pause();
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
                            Text(
                                AppLocalizations.of(context)!
                                    .home_buttom_persion,
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
        //controller.pause();
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
