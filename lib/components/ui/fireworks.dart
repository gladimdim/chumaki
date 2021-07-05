import 'dart:math';

import 'package:flutter/material.dart';

class FireWorks extends StatefulWidget {
  final Duration duration;
  final bool disappearOnEnd;
  final int amountOfSparkles;

  const FireWorks(
      {Key? key,
      required this.duration,
      this.disappearOnEnd = true,
      required this.amountOfSparkles})
      : super(key: key);

  @override
  _FireWorksState createState() => _FireWorksState();
}

class _FireWorksState extends State<FireWorks>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: List.generate(widget.amountOfSparkles, (index) => index)
              .map(
                (index) => Sparkle(
                  canvasSize: Size(constraints.maxWidth, constraints.maxHeight),
                  duration: widget.duration,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Sparkle extends StatefulWidget {
  final Duration duration;
  final double size;
  final Size canvasSize;
  late final int posX;
  late final int posY;

  Sparkle({
    Key? key,
    required this.duration,
    required this.canvasSize,
    this.size = 50,
  }) {
    posX = Random().nextInt(canvasSize.width.toInt());
    posY = Random().nextInt(canvasSize.height.toInt());
  }

  @override
  _SparkleState createState() => _SparkleState();
}

class _SparkleState extends State<Sparkle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final int directionX;

  @override
  void initState() {
    super.initState();
    directionX = Random().nextInt(2) == 1 ? 1 : -1;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      upperBound: randomDouble,
      lowerBound: 0.0,
    );
    Future.delayed(
        Duration(
            milliseconds:
                (widget.duration.inMilliseconds * randomDouble).toInt()), () {
      if (mounted) {
        setState(() {
          _controller.forward();
        });
      }
    });
  }

  double randomDouble = Random().nextDouble();

  @override
  Widget build(BuildContext context) {
    if (!_controller.isAnimating) {
      return Container();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => _controller.isCompleted
          ? Container()
          : Positioned(
              top: widget.posY - 50 * _controller.value,
              left: widget.posX + directionX * 50 * _controller.value,
              child: Container(
                width: 10 + widget.size * _controller.value,
                height: 10 + widget.size * _controller.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Color.lerp(Colors.red, Colors.yellow, _controller.value),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FireWorksPainter extends CustomPainter {
  FireWorksPainter({required this.sparkles, required this.progress}) {
    print("building");
  }

  int sparkles;
  double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, deltaH(size)), 5.0, paint);

    // canvas.drawPath(path, paint);
  }

  double perMillisecond(double height) {
    return height / 1000;
  }

  double deltaH(Size size) {
    return size.height * (1 - progress);
  }

  @override
  bool shouldRepaint(covariant FireWorksPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
