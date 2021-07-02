import 'package:flutter/material.dart';

class ScaleAnimated extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScaleAnimated({Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  _ScaleAnimatedState createState() => _ScaleAnimatedState();
}

class _ScaleAnimatedState extends State<ScaleAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration, upperBound: 1.0, lowerBound: 0.0);
    _controller.forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child:  widget.child,
    );
  }
}
