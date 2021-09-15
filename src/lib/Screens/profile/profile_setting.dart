import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  bool privacyStatus = false;
  bool msgStatus = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Privacy Setting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Signika Negative',
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: width - 100.0,
                      child: Text(
                        'Private Account',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CustomSwitch(
                      activeColor: Colors.red,
                      value: privacyStatus,
                      onChanged: (value) {
                        setState(() {
                          privacyStatus = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  'In private account only your followers can show your posts.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.white.withOpacity(0.6)),
                SizedBox(height: 5.0),
                Text(
                  'Message Setting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Signika Negative',
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: width - 100.0,
                      child: Text(
                        'Everyone can message me',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[300],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CustomSwitch(
                      activeColor: Colors.red,
                      value: msgStatus,
                      onChanged: (value) {
                        setState(() {
                          msgStatus = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  'If you on this setting then everyone can message you & If you off this setting then only your followers can message you.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.white.withOpacity(0.6)),
                SizedBox(height: 5.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
