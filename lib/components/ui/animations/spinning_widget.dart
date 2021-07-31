import 'dart:math';

import 'package:flutter/material.dart';

class SpinningWidget extends StatefulWidget {
  final AxisDirection direction;
  final Widget child;
  const SpinningWidget(
      {Key? key, this.direction = AxisDirection.left, required this.child})
      : super(key: key);

  @override
  _SpinningWidgetState createState() => _SpinningWidgetState();
}

class _SpinningWidgetState extends State<SpinningWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    double upper = 2 * pi;
    double lower = 0;
    _rotateController =
        AnimationController(vsync: this, upperBound: upper, lowerBound: lower)
          ..duration = Duration(seconds: 2)
          ..repeat();

    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateController.repeat();
      }
    });
    _rotateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final correction = widget.direction == AxisDirection.left ? 1 : -1;
    return AnimatedBuilder(
      animation: _rotateController,
      builder: (context, child) => Transform.rotate(
          angle: _rotateController.value * correction, child: child),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _rotateController.stop();
    super.dispose();
  }
}
