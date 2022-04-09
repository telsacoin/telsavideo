import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as develop;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telsavideo/screens/login/login.dart';
import 'package:telsavideo/screens/record_video/record_video.dart';

class HomeBottomNavigationFooter extends StatefulWidget {
  bool home;
  bool search;
  bool notifications;
  bool me;
  bool isLogin;
  HomeBottomNavigationFooter(
      {required this.home,
      required this.search,
      required this.notifications,
      required this.me,
      required this.isLogin});
  @override
  State<StatefulWidget> createState() => _HomeBottomNavigationFooterState();
}

class _HomeBottomNavigationFooterState
    extends State<HomeBottomNavigationFooter> {
  @override
  Widget build(BuildContext context) {
    return footer();
  }

  // Bottom Navigation Footer Start
  footer() {
    bool home = this.widget.home;
    bool search = this.widget.search;
    bool notifications = this.widget.notifications;
    bool me = this.widget.me;
    bool isLogin = this.widget.isLogin;
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
