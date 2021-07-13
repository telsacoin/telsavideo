import 'package:flutter/material.dart';
import 'package:telsavideo/screens/notifications_messages/messages.dart';
import 'package:telsavideo/screens/notifications_messages/notification_list.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool notifications = true;
  bool messages = false;

  TextStyle activeTextStyle = TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
  TextStyle nonActiveTextStyle = TextStyle(
      color: Colors.white38, fontSize: 15.0, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  notifications = true;
                  messages = false;
                });
              },
              child: Text(
                'Notifications',
                style: (notifications) ? activeTextStyle : nonActiveTextStyle,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  notifications = false;
                  messages = true;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Messages',
                    style: (messages) ? activeTextStyle : nonActiveTextStyle,
                  ),
                  SizedBox(width: 3.0),
                  (notifications)
                      ? Container(
                          height: 7.0,
                          width: 7.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.5),
                            color: Colors.orange,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: (notifications) ? NotificationList() : Messages(),
        ),
      ),
    );
  }
}
