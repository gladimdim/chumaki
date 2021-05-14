import 'package:flutter/material.dart';

class PressedInContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onPress;

  PressedInContainer({required this.onPress, required this.child});

  @override
  _PressedInContainerState createState() => _PressedInContainerState();
}

class _PressedInContainerState extends State<PressedInContainer>
    with SingleTickerProviderStateMixin {
  double firstDepth = -20;
  late AnimationController _animationController;

  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          widget.onPress();
          _animationController.reverse();
        }
      })
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          _animationController.forward();
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
