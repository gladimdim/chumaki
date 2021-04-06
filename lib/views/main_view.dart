import 'dart:math';

import 'package:chumaki/models/city.dart';
import 'package:flutter/material.dart';
const CITY_SIZE = 30;
class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              width: 2000,
              height: 2000,
            ),
            ...City.allCities.map((city) {
              return Positioned(
                top: city.point.y,
                left: city.point.x,
                child: GestureDetector(
                  onTap: () {
                    print("pressed city: ${city.name}");
                  },
                  child: ClipOval(
                    child: SizedBox(
                      width: CITY_SIZE * 2,
                      height: CITY_SIZE * 2,
                      child: Container(
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            "${city.name}",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            ...routes.keys.map((key) {
              Point<double> bezierPoint = routes[key]!;
              var first = key.item1;
              var second = key.item2;
              Point<double> finalPoint = Point(second.point.x - first.point.x, second.point.y - first.point.y);
              return Positioned(
                left: first.point.x + CITY_SIZE,
                top: first.point.y + CITY_SIZE,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      print("Pressed on route between ${first.name} and ${second.name}");
                    },
                    child: CustomPaint(
                      painter: CurvePainter(
                        path: Path()
                          ..moveTo(0, 0)
                          ..quadraticBezierTo(bezierPoint.x, bezierPoint.y, finalPoint.x, finalPoint.y),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(20, 20, 300, 50)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }
}

class CurvePainter extends CustomPainter {
  final Path path;

  CurvePainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // canvas.drawRect(bounds, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
