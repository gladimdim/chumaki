import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:flutter/material.dart';

class BorderedBottom extends StatelessWidget {
  final double width;
  final Color color;
  final Widget child;

  const BorderedBottom(
      {this.width = 3.0, this.color = Colors.black, required this.child});

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithSide(
      child: child,
      borderDirection: AxisDirection.down,
    );
  }
}
