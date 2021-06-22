import 'package:flutter/material.dart';

class AnimatedFlag extends StatefulWidget {
  final Color topColor;
  final Color bottomColor;
  final bool animate;
  const AnimatedFlag(
      {Key? key, required this.topColor, required this.bottomColor, required this.animate})
      : super(key: key);

  @override
  _AnimatedFlagState createState() => _AnimatedFlagState();
}

class _AnimatedFlagState extends State<AnimatedFlag>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorTop;
  late final Animation<Color?> _colorBottom;

  @override
  void didUpdateWidget(AnimatedFlag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate) {
      _controller.repeat(reverse: true);
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _colorTop =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(_controller);
    _colorBottom =
        ColorTween(begin: Colors.yellow, end: Colors.blue).animate(_controller);
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: FlagPainter(topColor: _colorTop.value!, bottomColor: _colorBottom.value!),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FlagPainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;

  FlagPainter({required this.topColor, required this.bottomColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paintBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = Colors.black;

    final pathBorder = Path()
      ..addRect(Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)));

    canvas.drawPath(pathBorder, paintBorder);
    final paintTop = Paint()
      ..style = PaintingStyle.fill
      ..color = topColor;

    final paintBottom = Paint()
      ..style = PaintingStyle.fill
      ..color = bottomColor;

    final pathTop = Path();
    pathTop.addRect(
        Rect.fromPoints(Offset(0.0, 0.0), Offset(size.width, size.height / 2)));

    final pathBottom = Path();
    pathBottom.addRect(Rect.fromPoints(
        Offset(0.0, size.height / 2), Offset(size.width, size.height)));

    canvas.drawPath(pathTop, paintTop);
    canvas.drawPath(pathBottom, paintBottom);
  }

  @override
  bool shouldRepaint(covariant FlagPainter oldDelegate) {
    return oldDelegate.topColor != topColor ||
        oldDelegate.bottomColor != bottomColor;
  }
}
