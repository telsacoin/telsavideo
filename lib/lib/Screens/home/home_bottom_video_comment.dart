import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telsavideo/common/utils.dart';
import 'package:telsavideo/components/core.dart';
import 'package:telsavideo/models/vo/comment/comment_item_list_vo.dart';
import 'package:telsavideo/models/vo/comment/json.dart';
import 'package:telsavideo/screens/comment/comment_tree.dart';
import 'package:telsavideo/screens/loading/loading.dart';

class HomeBottomVideoComment extends StatefulWidget {
  final BuildContext context;
  final String? id;
  final int? commentCount;
  HomeBottomVideoComment({required this.context, this.id, this.commentCount});
  @override
  State<StatefulWidget> createState() => _HomeBottomVideoCommentState();
}

class _HomeBottomVideoCommentState extends State<HomeBottomVideoComment> {
  ScrollController scrollController = new ScrollController();

  ///determine
  bool isVisable = false;

  /// text editing
  TextEditingController? textEditingController;

  Future<List<Comments>>? comments;

  void onlike(BuildContext context) async {}

  Future<List<Comments>> getComments() async {
    var commentItemList = CommentItemListVo.fromJson(json);
    return commentItemList.comments!;
  }

  void addItemToList() async {
    setState(() async {
      (await comments)!.insert(
          0,
          new Comments(
              createTime: DateTime.now().millisecondsSinceEpoch,
              text: textEditingController!.text));
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = new TextEditingController();
    comments = getComments();
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
            bottom: 0,
            width: size.width,
            child: _commentPostInnerWrapper(size)),
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
                      child: Container(
                        width: 26,
                        height: 26,
                        child: Text(
                          "✕",
                          style: TextStyle(fontSize: 16),
                        ),
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
          child: FutureBuilder(
              future: comments,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Comments>> snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loading;
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                  } else if (snapshot.hasData) {
                    final datas = snapshot.data!;
                    return Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        radius: Radius.circular(5.0),
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: datas.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Comment> replyComments =
                                  List.empty(growable: true);
                              var replyComment = datas[index].replyComment ??
                                  List.empty(growable: true);
                              if (null != datas[index].replyComment) {
                                replyComment.forEach((item) => {
                                      replyComments.add(new Comment(
                                          avatar: item.user!.nickname!,
                                          userName: item.user!.nickname!,
                                          content: item.text!,
                                          createTime: item.createTime,
                                          diggCount: item.diggCount,
                                          hasChild: item.replyComment != null
                                              ? true
                                              : false))
                                    });
                              }
                              return CommentTreeWidget<Comment, Comment>(
                                Comment(
                                    avatar: 'null',
                                    userName: datas[index].user!.nickname,
                                    content: datas[index].text,
                                    createTime: datas[index].createTime,
                                    diggCount: datas[index].diggCount,
                                    hasChild: datas[index].replyComment != null
                                        ? true
                                        : false),
                                replyComments,
                                treeThemeData: TreeThemeData(
                                    lineColor: Colors.white, lineWidth: 0),
                                avatarRoot: (context, data) => PreferredSize(
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: AssetImage(
                                        'assets/user_profile/user_1.jpg'),
                                  ),
                                  preferredSize: Size.fromRadius(18),
                                ),
                                contentRoot: (context, data) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 8,
                                            left: 8,
                                            right: 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.userName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13,
                                                      color: Color.fromRGBO(
                                                          22, 24, 35, 1)),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${data.content}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      data.hasChild!
                                          ? DefaultTextStyle(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.bold),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(readTimestamp(
                                                        data.createTime!)),
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Text('Reply'),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.only(top: 8),
                                            )
                                    ],
                                  );
                                },
                                favoriteRoot: (context, data) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () => onlike(context),
                                          child: Icon(
                                            Icons.favorite_border_outlined,
                                            size: 20,
                                            color:
                                                Color.fromRGBO(22, 24, 35, 0.5),
                                          ),
                                        ),
                                        Text(
                                          "${data.diggCount}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      22, 24, 35, 0.5)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                avatarChild: (context, data) => PreferredSize(
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: AssetImage(
                                        'assets/user_profile/user_2.jpg'),
                                  ),
                                  preferredSize: Size.fromRadius(12),
                                ),
                                contentChild: (context, data) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 8,
                                            left: 8,
                                            right: 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.userName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${data.content}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      data.hasChild!
                                          ? DefaultTextStyle(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.bold),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(readTimestamp(
                                                        data.createTime!)),
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Text('Reply'),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.only(top: 4))
                                    ],
                                  );
                                },
                                favoriteChild: (context, data) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.favorite_border_outlined,
                                          size: 20,
                                          color:
                                              Color.fromRGBO(22, 24, 35, 0.5),
                                        ),
                                        Text(
                                          "${data.diggCount}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      22, 24, 35, 0.5)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }));
                  } else {
                    return loading;
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
                return loading;
              }));
    }
  }

  /// the comment post inner wrapper
  _commentPostInnerWrapper(Size size) {
    return Container(
        height: 54,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1.0,
          color: Color.fromRGBO(22, 24, 35, 0.12),
        ))),
        child: Row(children: [
          Container(
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
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 18, bottom: 0, right: 0),
                        width: size.width - 113 - (isVisable ? 34 : 0),
                        child: TextFormField(
                            controller: textEditingController,
                            onChanged: (value) {
                              setState(() {
                                isVisable = value.length > 0 ? true : false;
                              });
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Add comment...")),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7.5, right: 14),
                        child: SvgPicture.asset(
                          "assets/icons/at.svg",
                          width: 22,
                          height: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7.5, right: 8),
                        child: SvgPicture.asset(
                          "assets/icons/emoji.svg",
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          isVisable
              ? InkWell(
                  onTap: () {
                    showMsg(context, "test", textEditingController!.text);
                    //addItemToList();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, top: 2.5),
                    child: SvgPicture.asset(
                      "assets/icons/send.svg",
                      width: 22,
                      height: 22,
                    ),
                  ),
                )
              : SizedBox.shrink()
        ]));
  }
}
