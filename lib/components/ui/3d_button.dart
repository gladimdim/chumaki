import 'package:flutter/material.dart';

class DDDButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color releaseColor;
  final Color shadowColor;
  final VoidCallback onPressed;
  final Duration waitTillCallback;

  const DDDButton(
      {Key? key,
      required this.child,
      this.color = Colors.grey,
      this.shadowColor = Colors.red,
      this.waitTillCallback = const Duration(milliseconds: 200),
      required this.onPressed,
      this.releaseColor = Colors.green})
      : super(key: key);

  @override
  _DDDButtonState createState() => _DDDButtonState();
}

class _DDDButtonState extends State<DDDButton>
    with SingleTickerProviderStateMixin {
  double shift = 4;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.waitTillCallback,
        lowerBound: 0,
        upperBound: 4);
    _controller.addListener(animationListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: (_) => onTapUp(),
      onTapCancel: onTapCancel,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: widget.shadowColor,
              ),
            ),
            Positioned.fill(
              bottom: shift,
              child: Padding(
                padding: EdgeInsets.all(shift),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: widget.color,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapCancel() {
    _controller.reverse();
  }

  void onTapUp() {
    if (_controller.status == AnimationStatus.completed) {
      widget.onPressed();
    }
    _controller.reverse();
  }

  void onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void animationListener() {
    setState(() {
      shift = 4.0 - _controller.value;
    });
  }

  void dispose() {
    _controller.removeListener(animationListener);
    _controller.dispose();
    super.dispose();
  }
}
