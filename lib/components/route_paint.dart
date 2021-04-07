import 'dart:math';

import 'package:chumaki/models/route.dart';
import 'package:flutter/material.dart';

class RoutePainter extends CustomPainter {
  // final Path path;
  final Color color;
  final CityRoute route;
  RoutePainter({required this.color, required this.route,});


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
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    route.routeTasks.forEach((routeTask) {
      var start = routeTask.from;
      Offset offsetStart;
      Offset offsetEnd;
      if (start == route.from) {
        offsetStart = Offset(0, 0);
        offsetEnd = Offset(finalPoint.x, finalPoint.y);
      } else {
        offsetStart = Offset(finalPoint.x, finalPoint.y);
        offsetEnd =  Offset(0, 0);
      }
      var rectPath = Rect.fromCircle(
        center: getQuadraticCurvePoint(
            offsetStart, Offset(route.bezierPoint.x, route.bezierPoint.y), offsetEnd, routeTask.leftProgress()),
        radius: 10,
      );
      canvas.drawRect(rectPath, paint);
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
