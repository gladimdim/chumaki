import 'package:flutter/material.dart';

enum GROUP_TITLE_ALIGNMENT { LEFT, CENTER, RIGHT }

class GroupedControl extends StatelessWidget {
  final Widget title;
  final Widget child;
  final double width;
  final double titleHeight;
  final Color borderColor;
  final double height;
  final double borderWidth;
  final GROUP_TITLE_ALIGNMENT titleAlignment;

  GroupedControl({required this.title,
    required this.child,
    required this.width,
    required this.borderColor,
    required this.height,
    this.borderWidth = 1,
    this.titleAlignment = GROUP_TITLE_ALIGNMENT.LEFT,
    this.titleHeight = 25});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: CustomPaint(
              painter: GroupBorder(titleHeight: titleHeight,
                  color: borderColor,
                  borderWidth: borderWidth),
            ),
          ),

          Align(
            alignment: titleAlignmentToAlign,
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: title,
              ),
            ),
          ),

          //child
          Align(
            alignment: Alignment.center,
            child: child,
          )
        ],
      ),
    );
  }

  Alignment get titleAlignmentToAlign {
    switch (titleAlignment) {
      case GROUP_TITLE_ALIGNMENT.LEFT:
        return Alignment.topLeft;
      case GROUP_TITLE_ALIGNMENT.CENTER:
        return Alignment.topCenter;
      case GROUP_TITLE_ALIGNMENT.RIGHT:
        return Alignment.topRight;
    }
  }
}

class GroupBorder extends CustomPainter {
  final double titleHeight;
  final Color color;
  final double borderWidth;

  GroupBorder(
      {required this.titleHeight, required this.color, required this.borderWidth});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(0, titleHeight / 2)
      ..lineTo(size.width, titleHeight / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
    ..close();
    var paint = Paint()
      ..color = color
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(GroupBorder oldDelegate) => true;
}
