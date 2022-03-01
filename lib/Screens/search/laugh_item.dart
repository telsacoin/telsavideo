import 'package:flutter/material.dart';

class LaughList extends StatefulWidget {
  @override
  _LaughListState createState() => _LaughListState();
}

class _LaughListState extends State<LaughList> {
  final laughList = [
    {
      'image': 'assets/laugh/laugh_1.jpg',
    },
    {
      'image': 'assets/laugh/laugh_2.jpg',
    },
    {
      'image': 'assets/laugh/laugh_3.jpg',
    },
    {
      'image': 'assets/laugh/laugh_4.jpg',
    },
    {
      'image': 'assets/laugh/laugh_5.jpg',
    },
    {
      'image': 'assets/laugh/laugh_6.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100.0,
      child: ListView.builder(
        itemCount: laughList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = laughList[index];
          return InkWell(
            onTap: () {},
            child: Container(
              width: 80.0,
              margin: (index == laughList.length - 1)
                  ? EdgeInsets.only(left: 10.0, right: 10.0)
                  : EdgeInsets.only(
                      left: 10.0,
                    ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
