import 'package:flutter/material.dart';
import 'package:telsavideo/screens/profile/creator_profile.dart';

class HomeVideoSlider extends StatefulWidget {
  PageController pageController;
  int position;
  HomeVideoSlider({required this.pageController, required this.position});
  @override
  State<StatefulWidget> createState() => _HomeVideoSliderState();
}

class _HomeVideoSliderState extends State<HomeVideoSlider> {
  @override
  Widget build(BuildContext context) {
    return videoSlider(this.widget.position!);
  }

  // Home Screen Related Page Video Slider Start
  videoSlider(int index) {
    PageController pageController = this.widget.pageController;
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
              child: Container() //VideoPlayer(_controller),
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
                    onTap: () => {
                      //_controller.pause()
                    },
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
}
