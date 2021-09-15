import 'package:flutter/material.dart';

class ProfileTabItem extends StatefulWidget {
  final tabItem = [
    {'image': 'assets/dance/dance_1.jpg'},
    {'image': 'assets/dance/dance_2.jpg'},
    {'image': 'assets/dance/dance_3.jpg'},
    {'image': 'assets/dance/dance_4.jpg'},
    {'image': 'assets/dance/dance_5.jpg'},
    {'image': 'assets/dance/dance_6.jpg'},
    {'image': 'assets/laugh/laugh_1.jpg'},
    {'image': 'assets/laugh/laugh_2.jpg'},
    {'image': 'assets/laugh/laugh_3.jpg'},
    {'image': 'assets/laugh/laugh_4.jpg'},
    {'image': 'assets/laugh/laugh_5.jpg'},
    {'image': 'assets/laugh/laugh_6.jpg'},
    {'image': 'assets/dance/dance_1.jpg'},
    {'image': 'assets/dance/dance_2.jpg'},
    {'image': 'assets/dance/dance_3.jpg'},
    {'image': 'assets/dance/dance_4.jpg'},
    {'image': 'assets/dance/dance_5.jpg'},
    {'image': 'assets/dance/dance_6.jpg'},
    {'image': 'assets/laugh/laugh_1.jpg'},
    {'image': 'assets/laugh/laugh_2.jpg'},
    {'image': 'assets/laugh/laugh_3.jpg'},
    {'image': 'assets/laugh/laugh_4.jpg'},
    {'image': 'assets/laugh/laugh_5.jpg'},
    {'image': 'assets/laugh/laugh_6.jpg'}
  ];
  @override
  _ProfileTabItemState createState() => _ProfileTabItemState();
}

class _ProfileTabItemState extends State<ProfileTabItem> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.tabItem.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              image: DecorationImage(
                image: AssetImage(widget.tabItem[index]['image']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
