import 'dart:math';

import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/extensions/list.dart';
import 'dart:ui' as ui;
const CITY_SIZE = 30;

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double animationValue = 0;
  bool showCoordinates = true;
  City? selected;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.2,
      constrained: false,
      maxScale: 3,
      child: Stack(
        children: [
          Image.asset(
            "images/boplan_map_huge.jpg",
            width: 5340,
            height: 4195,
          ),
          if (showCoordinates)
          ...List.generate(53, (index) {
            return Positioned(
              top: 0,
              left: index * 100,
              child: Container(
                width: 5,
                height: 4195,
                color: Colors.black,
                child: Text((index * 100).toString(), style: TextStyle(fontSize: 18, color: Colors.red),),
              ),
            );
          }).toList(),
          if (showCoordinates)
          ...List.generate(42, (index) {
            return Positioned(
              top: index * 100,
              left: 0,
              child: Container(
                height: 15,
                width: 5430,
                color: Colors.black,
                child: Text((index * 100).toString(), style: TextStyle(fontSize: 18, color: Colors.red),),
              ),
            );
          }).toList(),
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
                child: StreamBuilder(
                  stream: Stream.periodic(Duration(milliseconds: 33),),
                  builder: (context, data) => FutureBuilder(
                    future: ImageOnCanvas.wagonImage.asBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data as ui.Image;
                        return CustomPaint(
                          painter: RoutePainter(
                            color: highlight ? Colors.amber : Colors.brown,
                            route: route,
                            image: data,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
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
                  CityRoute cityRoute = city.routes.takeRandom();
                  var from = city;
                  var to;
                  if (cityRoute.from.equalsTo(city)) {
                    to = cityRoute.to;
                  } else {
                    to = cityRoute.from;
                  }
                  print("from: ${from.name} to: ${to.name}");
                  var newTask = RouteTask(to, from);
                  cityRoute.addTask(newTask);
                  newTask.start();
                  newTask.changes.listen((event) {
                    print(event);
                  });
                  setState(() {
                      selected = city;
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
          ),
          Positioned(
            left: 300,
            top: 900,
            child: TextButton(
              child: Text("Toggle lines"),
              onPressed: () {
                setState(() {
                  showCoordinates = !showCoordinates;
                });
              },
            ),
          )
        ],
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
