import 'package:flutter/material.dart';

class DanceList extends StatefulWidget {
  @override
  _DanceListState createState() => _DanceListState();
}

class _DanceListState extends State<DanceList> {
  final danceList = [
    {
      'image': 'assets/dance/dance_1.jpg',
    },
    {
      'image': 'assets/dance/dance_2.jpg',
    },
    {
      'image': 'assets/dance/dance_3.jpg',
    },
    {
      'image': 'assets/dance/dance_4.jpg',
    },
    {
      'image': 'assets/dance/dance_5.jpg',
    },
    {
      'image': 'assets/dance/dance_6.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100.0,
      child: ListView.builder(
        itemCount: danceList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = danceList[index];
          return InkWell(
            onTap: () {},
            child: Container(
              width: 80.0,
              margin: (index == danceList.length - 1)
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
