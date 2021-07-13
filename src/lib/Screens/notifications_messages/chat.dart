import 'dart:async';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();
  DateTime now = DateTime.now();
  ScrollController _scrollController = new ScrollController();
  String? amPm;
  final chatData = [
    {
      'role': 'me',
      'msg': 'I\'m fine. How are you?',
      'time': '9:38 AM',
      'read': 'unread'
    },
    {
      'role': 'sender',
      'msg': 'How are you?',
      'time': '9:38 AM',
      'read': 'read'
    },
    {'role': 'me', 'msg': 'Hi', 'time': '9:36 AM', 'read': 'read'},
    {'role': 'sender', 'msg': 'Hello', 'time': '9:35 AM', 'read': 'read'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Ellison Perry',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatData.length,
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index) {
                  final item = chatData[index];
                  return Container(
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: (item['role'] == 'sender')
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Padding(
                              padding: (item['role'] == 'sender')
                                  ? EdgeInsets.only(right: 100.0)
                                  : EdgeInsets.only(left: 100.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: (item['role'] == 'sender')
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      ),
                                      color: (item['role'] == 'sender')
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                    child: Text(
                                      item['msg']!,
                                      style: TextStyle(
                                        color: (item['role'] == 'sender')
                                            ? Colors.red
                                            : Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          (item['role'] == 'sender')
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        (item['role'] == 'sender')
                                            ? Container()
                                            : Icon(
                                                (item['read'] == 'read')
                                                    ? Icons.done_all
                                                    : Icons.check,
                                                color: Colors.blueAccent,
                                                size: 14.0,
                                              ),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          item['time']!,
                                          style: TextStyle(
                                            color: Colors.white38,
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
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: width,
              height: 70.0,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: width - 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: TextField(
                      controller: msgController,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type a Message',
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white60,
                        ),
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      if (msgController.text != '') {
                        if (now.hour > 11) {
                          amPm = 'PM';
                        } else {
                          amPm = 'AM';
                        }
                        setState(() {
                          chatData.insert(0, {
                            'role': 'me',
                            'msg': msgController.text,
                            'time': (now.hour > 12)
                                ? '${now.hour - 12}:${now.minute} $amPm'
                                : '${now.hour}:${now.minute} $amPm',
                            'read': 'unread'
                          });
                          msgController.text = '';

                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      }
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.yellow,
                        size: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
