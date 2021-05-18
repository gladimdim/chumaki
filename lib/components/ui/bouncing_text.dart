import 'package:flutter/material.dart';

class BouncingText extends StatefulWidget {
  final String text;

  const BouncingText(this.text);

  Widget getChild() {
    return Text(text);
  }

  @override
  _BouncingTextState createState() => _BouncingTextState();
}

class _BouncingTextState extends State<BouncingText>
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
  void didUpdateWidget(BouncingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
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
