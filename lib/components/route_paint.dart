import 'dart:math';

import 'package:chumaki/models/route.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class RoutePainter extends CustomPainter {
  // final Path path;
  final Color color;
  final CityRoute route;
  final ui.Image image;
  RoutePainter({required this.color, required this.route, required this.image});


  @override
  void paint(Canvas canvas, Size size) {
    var first = route.from;
    var second = route.to;
    Point<double> finalPoint = Point(second.point.x - first.point.x, second.point.y - first.point.y);
    var path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(route.bezierPoint.x, route.bezierPoint.y, finalPoint.x, finalPoint.y);
    var paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    var carrierPaint = Paint()
      ..color = Colors.brown.withAlpha(180)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    route.routeTasks.forEach((routeTask) {
      var start = routeTask.from;
      Offset offsetStart;
      Offset offsetEnd;
      if (start.equalsTo(route.from)) {
        offsetStart = Offset(0, 0);
        offsetEnd = Offset(finalPoint.x, finalPoint.y);
      } else {
        offsetStart = Offset(finalPoint.x, finalPoint.y);
        offsetEnd =  Offset(0, 0);
      }

      var wagonOffset = getQuadraticCurvePoint(
          offsetStart, Offset(route.bezierPoint.x, route.bezierPoint.y), offsetEnd, routeTask.leftProgress());

      canvas.drawCircle(wagonOffset, 32, carrierPaint);
      canvas.drawImage(image, wagonOffset - Offset(32, 32), Paint());
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Offset getQuadraticCurvePoint(
    Offset start, Offset control, Offset end, double position) {
  return Offset(
    _getQBezierValue(position, start.dx, control.dx, end.dx),
    _getQBezierValue(position, start.dy, control.dy, end.dy),
  );
}

double _getQBezierValue(double t, double p1, double p2, double p3) {
  final iT = 1 - t;
  return iT * iT * p1 + 2 * iT * t * p2 + t * t * p3;
}
