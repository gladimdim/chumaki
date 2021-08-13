import 'dart:math';

import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';

class AnimatedMenuButton extends StatefulWidget {
  final Widget button;
  final Widget content;
  final Duration expandAnimation;
  final Point<double> openedPosition;
  final Point<double> closedPosition;
  final bool opened;

  const AnimatedMenuButton({
    Key? key,
    required this.button,
    required this.content,
    required this.expandAnimation,
    required this.closedPosition,
    required this.openedPosition,
    required this.opened,
  }) : super(key: key);

  @override
  _AnimatedMenuButtonState createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<AnimatedMenuButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: widget.opened ? widget.openedPosition.y : widget.closedPosition.y,
      left: widget.opened ? widget.openedPosition.x : widget.closedPosition.x,
      duration: widget.expandAnimation,
      child: AnimatedSize(
        duration: widget.expandAnimation,
        child: SizedBox(
            width: widget.opened ? MediaQuery.of(context).size.width : MENU_ITEM_WIDTH,
            height:
            widget.opened ? MediaQuery.of(context).size.height : MENU_ITEM_WIDTH,
            child: widget.opened ? widget.content : widget.button),
      ),
    );
  }
}
