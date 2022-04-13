import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telsavideo/common/utils.dart';
import 'package:telsavideo/screens/comment/comment_tree.dart';

class HomeBottomVideoComment extends StatefulWidget {
  BuildContext context;
  String? id;
  int? commentCount;
  HomeBottomVideoComment({required this.context, this.id, this.commentCount});
  @override
  State<StatefulWidget> createState() => _HomeBottomVideoCommentState();
}

class _HomeBottomVideoCommentState extends State<HomeBottomVideoComment> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(this.widget.context).size;
    return SafeArea(
        child: Container(
      constraints: BoxConstraints(
          maxHeight: size.height * 0.73, minHeight: size.height * 0.5),
      child: Stack(children: [
        Column(children: [
          _commentHeader(this.widget.commentCount),
          _commentContentContainer(size, this.widget.commentCount),
        ]),
        Positioned(
            bottom: 0, width: size.width, child: _commentPostInnerWrapper()),
      ]),
    ));
  }

  /// the comment header
  _commentHeader(int? commentCount) {
    return Container(
      height: 60,
      child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Center(child: Text('${formattedNumber(commentCount)} comments')),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "X",
                        style: TextStyle(),
                      )))
            ],
          )),
    );
  }

  _commentContentContainer(Size size, int? commentCount) {
    //empty comments
    if (commentCount!.abs() == 0) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: size.height * 0.2),
        child: Center(child: Text("no comments")),
      );
    } else {
      return Container(
          height: size.height * 0.73 - (54 + 60),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Container(
              child: Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  radius: Radius.circular(5.0),
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return CommentTreeWidget<Comment, Comment>(
                          Comment(
                              avatar: 'null',
                              userName: 'null',
                              content:
                                  'felangel made felangel/cubit_and_beyond public '),
                          [
                            Comment(
                                avatar: 'null',
                                userName: 'null',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar: 'null',
                                userName: 'null',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                            Comment(
                                avatar: 'null',
                                userName: 'null',
                                content:
                                    'A Dart template generator which helps teams'),
                            Comment(
                                avatar: 'null',
                                userName: 'null',
                                content:
                                    'A Dart template generator which helps teams generator which helps teams '),
                          ],
                          treeThemeData: TreeThemeData(
                              lineColor: Colors.white, lineWidth: 0),
                          avatarRoot: (context, data) => PreferredSize(
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('assets/user_profile/user_1.jpg'),
                            ),
                            preferredSize: Size.fromRadius(18),
                          ),
                          avatarChild: (context, data) => PreferredSize(
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('assets/user_profile/user_2.jpg'),
                            ),
                            preferredSize: Size.fromRadius(12),
                          ),
                          contentChild: (context, data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'dangngocduc',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${data.content}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('Like'),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        Text('Reply'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          contentRoot: (context, data) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'dangngocduc',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${data.content}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('Like'),
                                        SizedBox(
                                          width: 24,
                                        ),
                                        Text('Reply'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }))));
    }
  }

  /// the comment post inner wrapper
  _commentPostInnerWrapper() {
    return Container(
        height: 54,
        padding: EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1.0,
          color: Color.fromRGBO(22, 24, 35, 0.12),
        ))),
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(22, 24, 35, 0.06),
              border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      suffixIcon: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // added line
                        mainAxisSize: MainAxisSize.min, // added line
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              "assets/icons/at.svg",
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset("assets/icons/emoji.svg"),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      hintText: "Add comment...")),
            )));
  }
}
