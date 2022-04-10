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
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(this.widget.context).size;
    return Container(
      constraints: BoxConstraints(
          maxHeight: size.height * 0.73, minHeight: size.height * 0.5),
      child: Stack(children: [
        Column(children: [
          _commentHeader(this.widget.commentCount),
          _commentContentContainer(size),
          // ListView.builder(
          //   controller: scrollController,
          //   itemCount: 25,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(title: Text('Item $index'));
          //   },
          // )
        ]),
        Positioned(
            bottom: 0, width: size.width, child: _commentPostInnerWrapper()),
      ]),
    );
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

  _commentContentContainer(Size size) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: size.height * 0.2),
      child: Center(
        child: Text("no comments."),
      ),
    );
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
                      hintText: "add comment...")),
            )));
  }
}
