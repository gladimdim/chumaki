import 'dart:math';

import 'package:flutter/material.dart';

class SpinningStar extends StatefulWidget {
  const SpinningStar({Key? key}) : super(key: key);

  @override
  State<SpinningStar> createState() => _SpinningStarState();
}

class _SpinningStarState extends State<SpinningStar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;
  late final Animation<double?> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _colorAnimation =
        ColorTween(begin: Colors.blue[300]!, end: Colors.red[500]!).animate(
      _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value!,
          child: Transform.scale(
            scale: 1 + (_controller.value * 0.2),
            child: Icon(
              Icons.star,
              color: _colorAnimation.value,
              size: 48,
            ),
          ),
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

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(30, 30)
      ..lineTo(50, 30)
      ..lineTo(50, 50)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
