import 'package:chumaki/components/title_text.dart';
import 'package:flutter/material.dart';

enum GROUP_TITLE_ALIGNMENT { LEFT, CENTER, RIGHT }

class GroupedControl extends StatelessWidget {
  final String title;
  final Widget child;
  final double width;
  final double titleHeight;
  final Color borderColor;
  final double height;
  final double borderWidth;
  final GROUP_TITLE_ALIGNMENT titleAlignment;

  GroupedControl(
      {required this.title,
      required this.child,
      required this.width,
      required this.borderColor,
      required this.height,
      this.borderWidth = 1,
        this.titleAlignment = GROUP_TITLE_ALIGNMENT.LEFT,
      this.titleHeight = 25});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
          ),
          // top
          Positioned(
            top: titleHeight / 2,
            left: 0,
            child: Container(
              height: borderWidth,
              width: width,
              color: borderColor,
            ),
          ),
          // left
          Positioned(
            left: 0,
            top: titleHeight / 2,
            child: Container(
                height: height - titleHeight / 2, width: borderWidth, color: borderColor),
          ),
          // right
          Positioned(
            top: titleHeight / 2,
            right: 0,
            child: Container(
                height: height - titleHeight / 2, width: borderWidth, color: borderColor),
          ),
          // bottom
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              color: borderColor,
              width: width,
              height: borderWidth,
            ),
          ),
          // title
          Align(
            alignment: titleAlignmentToAlign,
            child: Container(
              color: Colors.grey[400],
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TitleText(title),
              ),
            ),
          ),

          //child
          Positioned(
            top: titleHeight,
            left: 0,
            child: child,
          )
        ],
      ),
    );
  }

  Alignment get titleAlignmentToAlign {
    switch (titleAlignment) {
      case GROUP_TITLE_ALIGNMENT.LEFT: return Alignment.topLeft;
      case GROUP_TITLE_ALIGNMENT.CENTER: return Alignment.topCenter;
      case GROUP_TITLE_ALIGNMENT.RIGHT: return Alignment.topRight;
    }
  }

  BorderSide get _borderSide {
    return BorderSide(width: 2, color: borderColor);
  }
}
