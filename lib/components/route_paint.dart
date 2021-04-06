
import 'package:flutter/material.dart';

class RoutePainter extends CustomPainter {
  final Path path;
  final Color color;
  RoutePainter({required this.path, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
