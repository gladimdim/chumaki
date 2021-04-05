import 'dart:math';

import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

        ),
        ...cities.map((city) {
          return  Positioned(
            top: city.y,
            left: city.x,
            child: GestureDetector(
              onTap: () {
                print("pressed circle");
              },
              child: ClipOval(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
        }),

      ],
    );
  }
}

List<Point<double>> cities = [Point(100,200), Point(300, 50), Point(200, 75)];

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(30, 30), 30, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
