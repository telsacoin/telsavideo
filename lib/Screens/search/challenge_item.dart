import 'package:flutter/material.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/models/dto/discover/discover_challenge_dto.dart';
import 'package:telsavideo/models/vo/discover/discover_challenage_vo.dart';
import 'package:telsavideo/screens/loading/loading.dart';

class ChallengeItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _ChallengeItemState extends State<ChallengeItem> {
  DiscoverChallengeDto dto = new DiscoverChallengeDto(0, 20);

  late Future<DiscoverChallengeVo> getDiscoverChallenges;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDiscoverChallenges = Api.getDiscoverChanllenge(dto);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<DiscoverChallengeVo>(
      future: getDiscoverChallenges,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading;
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 24,
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    'Error, Please restart your app again.',
                    style: TextStyle(color: Colors.white),
                  )),
                )
              ],
            );
          } else if (snapshot.hasData) {
            try {
              return Container();
            } catch (e) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Center(
                    child: Text(
                  'Error, Please restart your app again.',
                  style: TextStyle(color: Colors.white),
                )),
              );
            }
          } else {
            // empty data
            return loading;
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
