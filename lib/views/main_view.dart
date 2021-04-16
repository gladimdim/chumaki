import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/models/city.dart';

import 'package:chumaki/models/image_on_canvas.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/route.dart';
import 'dart:ui' as ui;

const CITY_SIZE = 50;

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double animationValue = 0;
  bool showCoordinates = false;
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
                  child: Text(
                    (index * 100).toString(),
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
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
                  child: Text(
                    (index * 100).toString(),
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              );
            }).toList(),
          ...CityRoute.allRoutes.map((route) {
            var first = route.from;
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
                  stream: Stream.periodic(Duration(milliseconds: 33)),
                  builder: (context, snapshot) => FutureBuilder(
                    future: ImageOnCanvas.wagonImage.asBytes(),
                    builder: (context, snapshotImage) {
                      if (snapshotImage.hasData) {
                        var data = snapshotImage.data as ui.Image;
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
                    },
                  ),
                ),
              ),
            );
          }).toList(),
          // ...Company.instance.tasks.map((routeTask) {
          //   return AnimatedRouteTask(routeTask);
          // }).toList(),
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
                        child: StreamBuilder(
                          stream: city.changes.stream,
                          builder: (context, snapshot) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "${city.name}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                              Text(city.wagons.length.toString()),
                            ],
                          ),
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
          ),
          if (selected != null)
            Positioned(
              left: selected!.point.x - 150,
              top: selected!.point.y + 64,
              child: SizedBox(
                width: CITY_DETAILS_VIEW_WIDTH,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    color: Colors.brown,
                  ),
                  child: SelectedCityView(city: selected!),
                ),
              ),
            ),
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
