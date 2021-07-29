import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget child;
  final dynamic value;
  const BouncingWidget({required this.child, required this.value});

  Widget getChild() {
    return child;
  }

  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 1.0,
      upperBound: 1.5,
    );
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        default:
          break;
      }
    });
  }

  @override
  void didUpdateWidget(BouncingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _controller.value,
          child: child,
        );
      },
      child: widget.getChild(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
