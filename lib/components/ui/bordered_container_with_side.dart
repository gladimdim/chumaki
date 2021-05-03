import 'package:flutter/material.dart';

class BorderedContainerWithSide extends StatelessWidget {
  final double width;
  final Color color;
  final Widget child;
  final AxisDirection borderDirection;

  const BorderedContainerWithSide({
    this.width = 3.0,
    this.color = Colors.black,
    required this.child,
    this.borderDirection = AxisDirection.up,
  });

  Map<AxisDirection, BorderSide> get _sidesForDirection {
    return {
      AxisDirection.up:
          borderDirection == AxisDirection.up ? _side : BorderSide.none,
      AxisDirection.down:
          borderDirection == AxisDirection.down ? _side : BorderSide.none,
      AxisDirection.left:
          borderDirection == AxisDirection.left ? _side : BorderSide.none,
      AxisDirection.right:
          borderDirection == AxisDirection.right ? _side : BorderSide.none,
    };
  }

  BorderSide get _side {
    return BorderSide(width: width, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: _sidesForDirection[AxisDirection.down]!,
          top: _sidesForDirection[AxisDirection.up]!,
          left: _sidesForDirection[AxisDirection.left]!,
          right: _sidesForDirection[AxisDirection.right]!,
        ),
      ),
      child: child,
    );
  }
}
