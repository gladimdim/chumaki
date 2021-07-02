import 'package:flutter/material.dart';

class Disappear extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const Disappear({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  _DisappearState createState() => _DisappearState();
}

class _DisappearState extends State<Disappear>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: 1 - _controller.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
