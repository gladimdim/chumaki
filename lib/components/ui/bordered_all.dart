import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:flutter/material.dart';

class BorderedAll extends StatelessWidget {
  final double width;
  final Color color;
  final Widget child;

  const BorderedAll(
      {this.width = 3.0, this.color = Colors.black, required this.child});

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithSides(
      child: child,
      width: width,
      color: color,
      borderDirections: [
        AxisDirection.down,
        AxisDirection.up,
        AxisDirection.left,
        AxisDirection.right
      ],
    );
  }
}
