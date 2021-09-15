import 'package:flutter/material.dart';
import 'package:telsavideo/screens/profile/creator_profile.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final notificationList = [
    {
      'role': 'like',
      'userImage': 'assets/user_profile/user_1.jpg',
      'name': 'Robert Junior',
      'time': '7m',
      'image': 'assets/dance/dance_1.jpg',
    },
    {
      'role': 'like',
      'userImage': 'assets/user_profile/user_2.jpg',
      'name': 'Don Hart',
      'time': '7m',
      'image': 'assets/dance/dance_2.jpg',
    },
    {
      'role': 'comment',
      'userImage': 'assets/user_profile/user_3.jpg',
      'name': 'Emili Williamson',
      'time': '8m',
      'image': 'assets/dance/dance_3.jpg',
    },
    {
      'role': 'comment',
      'userImage': 'assets/user_profile/user_4.jpg',
      'name': 'Ema Watson',
      'time': '9m',
      'image': 'assets/dance/dance_4.jpg',
    },
    {
      'role': 'like',
      'userImage': 'assets/user_profile/user_5.jpg',
      'name': 'Rosy Gold',
      'time': '11m',
      'image': 'assets/dance/dance_1.jpg',
    },
    {
      'role': 'comment',
      'userImage': 'assets/user_profile/user_1.jpg',
      'name': 'Robert Junior',
      'time': '13m',
      'image': 'assets/dance/dance_6.jpg',
    },
    {
      'role': 'like',
      'userImage': 'assets/user_profile/user_3.jpg',
      'name': 'Emili Williamson',
      'time': '15m',
      'image': 'assets/dance/dance_3.jpg',
    },
    {
      'role': 'like',
      'userImage': 'assets/user_profile/user_4.jpg',
      'name': 'Ema Watson',
      'time': '16m',
      'image': 'assets/dance/dance_4.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notificationList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = notificationList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatorProfileScreen()));
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.white30,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage(item['userImage']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item['name']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    (item['role'] == 'like')
                                        ? 'liked your video.'
                                        : 'commented on your video',
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    '${item['time']!} ago',
                                    style: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                width: 40.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: AssetImage(item['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.orange,
                                ),
                                child: Icon(
                                    (item['role'] == 'like')
                                        ? Icons.favorite
                                        : Icons.mode_comment,
                                    color: Colors.white,
                                    size: 13.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
