import 'package:flutter/material.dart';
import 'package:telsavideo/screens/record_video/post.dart';

class RecordVideo extends StatefulWidget {
  @override
  _RecordVideoState createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/ronaldo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (filter)
                ? Container(
                    width: width,
                    height: 130.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.red.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.blue.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.orange.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.green.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.yellow.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.pink.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.deepOrange.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.indigo.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                        getFilterTile(Colors.grey.withOpacity(0.35)),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(height: 15.0),
            (filter)
                ? Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.music_note,
                                    color: Colors.white, size: 25.0),
                                SizedBox(width: 5.0),
                                Text(
                                  'Add Music',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Post()));
                          },
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(25.0, 11.0, 25.0, 11.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.black,
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.black.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.photo_album,
                                  size: 24.0, color: Colors.white),
                              onPressed: () {},
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  filter = true;
                                });
                              },
                              child: Container(
                                width: 70.0,
                                height: 70.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: Icon(Icons.videocam,
                                    size: 30.0, color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.flash_off,
                                  size: 24.0, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.keyboard_arrow_up,
                                size: 20.0, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              'Swipe up for gallery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  getFilterTile(Color color) {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.white),
        image: DecorationImage(
          image: AssetImage('assets/ronaldo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1.0, color: Colors.white),
          color: color,
        ),
      ),
    );
  }
}
