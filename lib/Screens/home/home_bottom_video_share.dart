import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomVideoShare extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBottomVideoShareState();
}

class _HomeBottomVideoShareState extends State<HomeBottomVideoShare> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 90, maxHeight: 300),
        child: Stack(children: [
          Column(
            children: [
              _topTitle(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 0.5,
                color: Colors.grey,
              ),
              _shareAppContainer(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: _bottomActions()),
        ]));
  }

  _topTitle() {
    return Container(
      height: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              child: Text("Share to",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }

  _shareApp(String icon, String text, {Color? color}) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(children: [
        SvgPicture.asset(
          icon,
          color: color,
          width: 44,
        ),
        SizedBox(
          height: 5,
        ),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 10))
      ]),
    );
  }

  _shareAppContainer() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _shareApp("assets/icons/copylink.svg", "Copy link"),
            _shareApp("assets/icons/twitter.svg", "Twitter"),
            _shareApp("assets/icons/facebook.svg", "Facebook"),
            _shareApp("assets/icons/line.svg", "SMS"),
            _shareApp("assets/icons/whatsapp.svg", "WhatApps"),
            _shareApp("assets/icons/report.svg", "Report",
                color: Colors.white70),
          ],
        ),
      ),
    );
  }

  _bottomActions() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 30,
          decoration: BoxDecoration(color: Colors.white10),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                //bottom: 0,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
