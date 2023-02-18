import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:page_transition/page_transition.dart';
import 'package:telsavideo/screens/notifications_messages/chat.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final messageList = [
    {
      'userImage': 'assets/user_profile/user_3.jpg',
      'name': 'Ellison Perry',
      'message': 'Hey, How are you?',
      'time': '1d ago',
      'status': 'unread'
    },
    {
      'userImage': 'assets/user_profile/user_1.jpg',
      'name': 'Mark Perry',
      'message': 'You\'re so funny',
      'time': '2d ago',
      'status': 'read'
    },
    {
      'userImage': 'assets/user_profile/user_2.jpg',
      'name': 'Robert Junior',
      'message': 'Hello beautiful',
      'time': '2d ago',
      'status': 'read'
    },
    {
      'userImage': 'assets/user_profile/user_4.jpg',
      'name': 'Emma Watson',
      'message': 'I miss you very badly',
      'time': '3d ago',
      'status': 'unread'
    },
    {
      'userImage': 'assets/user_profile/user_5.jpg',
      'name': 'Emily Hemsworth',
      'message': 'Can we meet today?',
      'time': '6d ago',
      'status': 'read'
    },
    {
      'userImage': 'assets/user_profile/user_6.jpg',
      'name': 'Rocky Watson',
      'message': 'Hi sweatheart',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'userImage': 'assets/user_profile/user_6.jpg',
      'name': 'Cris Maxwell',
      'message': 'How are you today?',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'userImage': 'assets/user_profile/user_6.jpg',
      'name': 'David Lynn',
      'message': 'Oh my god!',
      'time': '2w ago',
      'status': 'unread'
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: messageList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = messageList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: ChatScreen()));
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    item['name']!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 7.0),
                                  Container(
                                    height: (item['status'] == 'unread')
                                        ? 7.0
                                        : 0.0,
                                    width: (item['status'] == 'unread')
                                        ? 7.0
                                        : 0.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.5),
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: width - 150.0,
                                child: Text(
                                  item['message']!,
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        item['time']!,
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
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
