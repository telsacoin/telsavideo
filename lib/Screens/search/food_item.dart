import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final foodList = [
    {
      'image': 'assets/food/food_1.png',
    },
    {
      'image': 'assets/food/food_2.png',
    },
    {
      'image': 'assets/food/food_3.png',
    },
    {
      'image': 'assets/food/food_4.png',
    },
    {
      'image': 'assets/food/food_5.png',
    },
    {
      'image': 'assets/food/food_6.png',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100.0,
      child: ListView.builder(
        itemCount: foodList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = foodList[index];
          return InkWell(
            onTap: () {},
            child: Container(
              width: 80.0,
              margin: (index == foodList.length - 1)
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
