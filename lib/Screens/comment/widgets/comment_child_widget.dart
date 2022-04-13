import './tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentChildWidget extends StatelessWidget {
  final PreferredSizeWidget? avatar;
  final Widget? content;
  final bool? isLast;
  final Size? avatarRoot;

  const CommentChildWidget({
    required this.isLast,
    required this.avatar,
    required this.content,
    required this.avatarRoot,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : avatarRoot!.width + 8.0,
        bottom: 8,
        top: 8,
        right: isRTL ? avatarRoot!.width + 8.0 : 0);

    return CustomPaint(
      painter: _Painter(
        isLast: isLast!,
        padding: padding,
        textDirection: Directionality.of(context),
        avatarRoot: avatarRoot,
        avatarChild: avatar!.preferredSize,
        pathColor: context.watch<TreeThemeData>().lineColor,
        strokeWidth: context.watch<TreeThemeData>().lineWidth,
      ),
      child: Container(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatar!,
            const SizedBox(
              width: 8,
            ),
            Expanded(child: content!),
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  bool isLast = false;

  EdgeInsets? padding;
  final TextDirection textDirection;
  Size? avatarRoot;
  Size? avatarChild;
  Color? pathColor;
  double? strokeWidth;

  _Painter({
    required this.isLast,
    required this.textDirection,
    this.padding,
    this.avatarRoot,
    this.avatarChild,
    this.pathColor,
    this.strokeWidth,
  }) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    if (textDirection == TextDirection.rtl) canvas.translate(size.width, 0);
    double rootDx = avatarRoot!.width / 2;
    if (textDirection == TextDirection.rtl) rootDx *= -1;
    path.moveTo(rootDx, 0);
    path.cubicTo(
      rootDx,
      0,
      rootDx,
      padding!.top + avatarChild!.height / 2,
      rootDx * 2,
      padding!.top + avatarChild!.height / 2,
    );
    canvas.drawPath(path, _paint);

    if (!isLast) {
      canvas.drawLine(
        Offset(rootDx, 0),
        Offset(rootDx, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
