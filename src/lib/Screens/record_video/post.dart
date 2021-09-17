import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:telsavideo/screens/home/home.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool comment = true;
  bool save = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          'Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 0.0,
        child: Container(
          color: Colors.black,
          width: width,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Container(
                  width: width - 20.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                  ),
                  child: Text(
                    'Post Video',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30.0),
          Container(
            width: width,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    image: DecorationImage(
                      image: AssetImage('assets/spook.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: (width - 100.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write about your post here',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Select Cover',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
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
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width - 100.0,
                  child: Text(
                    'Comment On',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FlutterSwitch(
                  activeColor: Colors.red,
                  value: comment,
                  onToggle: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width - 100.0,
                  child: Text(
                    'Save to Gallery',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FlutterSwitch(
                  activeColor: Colors.red,
                  value: save,
                  onToggle: (value) {
                    setState(() {
                      save = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getFilterTile(Color color) {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage('assets/ronaldo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
      ),
    );
  }
}
