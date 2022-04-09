import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:telsavideo/screens/home/home_video_slider.dart';

class HomeSuggestedAccounts extends StatefulWidget {
  PageController pageController;
  HomeSuggestedAccounts({required this.pageController});
  @override
  State<StatefulWidget> createState() => _HomeSuggestedAccountsState();
}

class _HomeSuggestedAccountsState extends State<HomeSuggestedAccounts> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = this.widget.pageController;
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
                    return HomeVideoSlider(
                        pageController: pageController, position: position);
                  }),
            )
          ],
        ));
  }
}
