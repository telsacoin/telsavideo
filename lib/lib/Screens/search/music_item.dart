import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/models/dto/discover/discover_music_dto.dart';
import 'package:telsavideo/models/vo/discover/discover_music_vo.dart';
import 'package:telsavideo/screens/loading/loading.dart';

class MusicItem extends StatefulWidget {
  @override
  _MusicItemState createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  late Future<DiscoverMusicVo> getDiscoverMusics;

  DiscoverMusicDto dto = new DiscoverMusicDto(0, 10);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDiscoverMusics = Api.getDiscoverMusic(dto);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<DiscoverMusicVo>(
      future: getDiscoverMusics,
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
              return Container(
                width: width,
                height: 100.0,
                child: ListView.builder(
                  itemCount: snapshot.data!.musicInfoList.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final length = snapshot.data!.musicInfoList.length;
                    final item = snapshot.data!.musicInfoList[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 80.0,
                        margin: (index == length - 1)
                            ? EdgeInsets.only(left: 10.0, right: 10.0)
                            : EdgeInsets.only(
                                left: 10.0,
                              ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                item.music.coverLarge),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                ),
              );
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
