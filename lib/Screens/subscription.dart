import 'package:flutter/material.dart';
import 'package:telsavideo/screens/login/login.dart';

class Subscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _subscriptionScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "_subscriptionScaffoldKey");
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150.0, left: 65.0, right: 65.0),
      color: Color.fromRGBO(14, 15, 26, 1),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage("assets/images/int_1581491273221.png")),
            SizedBox(height: 20),
            Center(
              child: Text(
                'You was not logged in',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Log on your account，watch the exciting content you care about',
                style: TextStyle(
                    color: Color.fromRGBO(253, 253, 253, 0.6),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    iconColor:
                        WidgetStateProperty.all(Color.fromRGBO(252, 1, 86, 1))),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((BuildContext context) {
                    return Login();
                  });
                },
              ),
            ),
          ]),
    );
  }
}
