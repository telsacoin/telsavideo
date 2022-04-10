import 'dart:async';
import 'dart:developer' as develop;
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/common/icons.dart';
import 'package:telsavideo/common/utils.dart';
import 'package:telsavideo/components/api.dart';
import 'package:telsavideo/models/dto/comment/comment_item_digg_dto.dart';
import 'package:telsavideo/models/vo/recommend/itemlist_vo.dart';
import 'package:telsavideo/screens/home/home_bottom_video_share.dart';
import 'package:telsavideo/screens/loading/loading.dart';
import 'package:telsavideo/screens/profile/creator_profile.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Videoplayer extends StatefulWidget {
  final double? heigth;
  final double? width;
  final ItemList item;
  final Function? function;
  const Videoplayer(
      {Key? key, required this.item, this.heigth, this.width, this.function})
      : super(key: key);

  @override
  _Videoplayer createState() => _Videoplayer();
}

class _Videoplayer extends State<Videoplayer>
    with SingleTickerProviderStateMixin {
  bool play = false;
  bool like = false;
  final Duration duration = Duration(seconds: 1);
  Timer? _timer;
  late VideoPlayerController _controller;
  late VideoPlayerController _musicController;
  late AnimationController _animationController;
  late Future<void> _initializeVideoPlayerFuture;

  // start Timer
  void _startTimer() async {
    develop.log("timer is running at " + DateTime.now().toString());
    final Duration duration = Duration(seconds: 1);
    cancelTimer();
    _timer = Timer.periodic(duration, (timer) {
      if (this.mounted) {
        //setState(() {});
      }
      if (_controller.value.isInitialized) {
        cancelTimer();
      }
    });
  }

  //stop timer
  void cancelTimer() async {
    _timer?.cancel();
  }

  //digg video
  void diggVideo(String videoId) async {
    CommentItemDiggDto dto = new CommentItemDiggDto();
    dto.videoId = videoId;
    Api.postCommnetItemDigg(dto);
  }

  //show bottom comments list from video id
  void showBottomComments() async {
    showNotification("111", "222");
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return DraggableScrollableSheet(
    //       initialChildSize: 0.5,
    //       maxChildSize: 1,
    //       minChildSize: 0.25,
    //       builder: (BuildContext context, ScrollController scrollController) {
    //         return Container(
    //           color: Colors.white,
    //           child: ListView.builder(
    //             controller: scrollController,
    //             itemCount: 25,
    //             itemBuilder: (BuildContext context, int index) {
    //               return ListTile(title: Text('Item $index'));
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }

  //show bottom share panel
  void showBottomShare() async {
    develop.log("click the show bottom share");
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, //
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 21, 23, 35),
        builder: (context) {
          return HomeBottomVideoShare();
        });
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Login successed!'),
      backgroundColor: const Color(0xffae00f0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: 'Done',
          textColor: Colors.white,
          onPressed: () {
            print('Done pressed!');
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    develop.log("playAddr is:" + widget.item.video!.playAddr!);
    _controller = VideoPlayerController.network(
        widget.item.video!.playAddr ?? "",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    _controller.addListener(() {
      setState(() {});
    });

    // Use the controller to loop the video.
    _controller.setLooping(true);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture =
        _controller.initialize(); //.then((_) => setState(() {}));

    // play the video
    _controller.play();

    //start timer to check play statue
    _timer = Timer.periodic(duration, (timer) {
      if (this.mounted) {}
      if (_controller.value.isInitialized) {
        cancelTimer();
      }
    });

    _startTimer();

    //music player
    _musicController = VideoPlayerController.network(
        widget.item.music!.playUrl ?? "",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((value) => {_musicController.play()});

    _musicController.seekTo(Duration.zero);
    _musicController.setLooping(true);

    //music albam
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _musicController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var item = widget.item;
          return Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: RawMaterialButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    setState(() {
                      if (play) {
                        _controller.pause();
                        play = !play;
                      } else {
                        _controller.play();
                        play = !play;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    height: widget.heigth ?? MediaQuery.of(context).size.height,
                    width: widget.width ?? MediaQuery.of(context).size.width,
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
              //video buttom context,like auther name,video description,muisc title.
              Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(
                            '@${item.author!.nickname}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 10, bottom: 10),
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(text: '${item.desc}'),
                                  ]),
                                  //softWrap: false,
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ))),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.music_note,
                                  size: 16, color: Colors.white),
                              Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                width: 150,
                                child: Marquee(
                                  child: Text('${item.music!.title}',
                                      style: TextStyle(color: Colors.white)),
                                  direction: Axis.horizontal,
                                  textDirection: TextDirection.ltr,
                                  animationDuration: Duration(seconds: 1),
                                  directionMarguee:
                                      DirectionMarguee.oneDirection,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //left action buttom,digg,comments,share
              Padding(
                  padding: EdgeInsets.only(bottom: 65, right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 70,
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 23),
                            width: 40,
                            height: 50,
                            child: Stack(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreatorProfileScreen()));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 19,
                                      backgroundColor: Colors.black,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              item.author!.avatarMedium ?? ""),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Color(0xfd2c58).withOpacity(1),
                                    child: Center(
                                        child: Icon(Icons.add,
                                            size: 15, color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      like = !like;
                                    });
                                    // digg video by videoId
                                    diggVideo(item.id!);
                                  },
                                  child: Icon(Icons.favorite,
                                      size: 30.0,
                                      color:
                                          (like) ? Colors.red : Colors.white),
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  '${formattedNumber(item.stats!.diggCount)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showBottomComments();
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(0),
                                      child: Icon(DouyinIcons.chat_bubble,
                                          size: 30, color: Colors.white)),
                                  SizedBox(height: 3.0),
                                  Text(
                                    '${formattedNumber(item.stats!.commentCount!)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showBottomShare();
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Icon(Icons.reply,
                                            size: 30, color: Colors.white)),
                                    SizedBox(height: 3.0),
                                    Text(
                                      AppLocalizations.of(context)!.home_share,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          AnimatedBuilder(
                            animation: _animationController,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0x222222).withOpacity(1),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: CachedNetworkImageProvider(
                                    '${item.author!.avatarMedium}'),
                              ),
                            ),
                            builder: (context, _widget) {
                              return Transform.rotate(
                                  angle: _animationController.value * 6.3,
                                  child: _widget);
                            },
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return loading;
        }
      },
    );
  }
}
