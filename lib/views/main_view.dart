import 'dart:math';

import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/models/city.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/route.dart';

const CITY_SIZE = 30;

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double animationValue = 0;
  City? selected;

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
            ...CityRoute.allRoutes.map((route) {
              Point<double> bezierPoint = route.bezierPoint;
              var first = route.from;
              var second = route.to;
              Point<double> finalPoint = Point(second.point.x - first.point.x,
                  second.point.y - first.point.y);
              bool highlight = false;
              if (selected != null) {
                highlight = selected!.routes.contains(route);
              }
              return Positioned(
                left: first.point.x + CITY_SIZE,
                top: first.point.y + CITY_SIZE,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      print(
                          "Pressed on route between ${first.name} and ${second.name}");
                    },
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: animationValue, end: 1 - animationValue),
                      duration: Duration(seconds: 10),
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: RoutePainter(
                            color: highlight ? Colors.green : Colors.black,
                            route: route,
                            progress: value,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
            ...City.allCities.map((city) {
              return Positioned(
                top: city.point.y,
                left: city.point.x,
                child: GestureDetector(
                  onTap: () {
                    print("pressed city: ${city.name}");
                    setState(() {
                      if (selected == city) {
                        selected = null;
                      } else {
                        selected = city;
                      }
                    });
                  },
                  child: ClipOval(
                    child: SizedBox(
                      width: CITY_SIZE * 2,
                      height: CITY_SIZE * 2,
                      child: Container(
                        color: selected == city ? Colors.grey : Colors.red,
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
            }).toList(),
            Positioned(
              left: 200,
              top: 800,
              child: TextButton(
                child: Text("Reset"),
                onPressed: () {
                  setState(() {
                    animationValue = 1 - animationValue;
                  });
                },
              ),
            )
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
