import 'package:flutter/material.dart';

class ScalingWidget extends StatefulWidget {
  final double min;
  final double max;
  final Widget child;
  final Duration duration;
  const ScalingWidget(
      {Key? key,
      this.min = 1.0,
      this.max = 1.2,
      required this.child,
      this.duration = const Duration(milliseconds: 300)})
      : super(key: key);

  @override
  _ScalingWidget createState() => _ScalingWidget();
}

class _ScalingWidget extends State<ScalingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, upperBound: widget.max, lowerBound: widget.min)
      ..duration = widget.duration
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          Transform.scale(scale: _controller.value, child: child),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }
}
