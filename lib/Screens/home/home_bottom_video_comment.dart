import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telsavideo/common/utils.dart';

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
        child: Container(
            //flex: 1,
            child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                radius: Radius.circular(5.0),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: CircleAvatar(
                          child: Text("头像"),
                          backgroundColor: Colors.purple,
                        ),
                        title: Text("作者 " + index.toString(),
                            style: TextStyle(
                                color: Color.fromRGBO(22, 24, 35, 1))),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("评论内容 ${index.toString()}"),
                              Row(children: [
                                Text("时间"),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text("回复"))
                              ])
                            ]),
                        trailing: Column(children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            size: 20,
                          ),
                          Text(
                            "18",
                            style: TextStyle(
                                color: Color.fromRGBO(22, 24, 35, 0.5)),
                          ),
                        ]));
                  },
                ))),
      );
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
