import 'dart:math';

import 'package:chumaki/components/city/city_on_map.dart';
import 'package:chumaki/components/city/selected_city_locked_view.dart';
import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/models/cities/city.dart';

import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';

import 'package:chumaki/models/image_on_canvas.dart';
import 'package:chumaki/utils/points.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const CITY_SIZE = 50;

class GameCanvasView extends StatefulWidget {
  final Company company;
  final Size screenSize;

  GameCanvasView({required this.company, required this.screenSize});

  @override
  _GameCanvasViewState createState() => _GameCanvasViewState();
}

class _GameCanvasViewState extends State<GameCanvasView>
    with TickerProviderStateMixin {
  TransformationController _transformationController =
      TransformationController();
  late AnimationController _animationController;
  late Animation<Matrix4> _mapAnimation;
  final Duration animationDuration = Duration(seconds: 2);
  double animationValue = 0;
  bool showCoordinates = false;
  City? selected;

  @override
  void initState() {
    // pan animation
    var centerPoint = calculateCenterPoint();
    var start = Matrix4.identity()..translate(CANVAS_WIDTH, CANVAS_HEIGHT);
    var end = Matrix4.identity()..translate(centerPoint.x, centerPoint.y);
    _animationController =
        AnimationController(duration: animationDuration, vsync: this);
    _mapAnimation =
        Matrix4Tween(begin: start, end: end).animate(_animationController);
    _mapAnimation.addListener(() {
      setState(() {
        final value = Matrix4.inverted(_mapAnimation.value);
        _transformationController.value = value;
      });
    });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _transformationController,
          minScale: 0.1,
          constrained: false,
          maxScale: 3.0,
          child: Stack(
            children: [
              Image.asset(
                "images/boplan_map_huge.jpg",
                width: CANVAS_WIDTH,
                height: CANVAS_HEIGHT,
              ),
              if (showCoordinates)
                ...List.generate(53, (index) {
                  return Positioned(
                    top: 0,
                    left: index * 100,
                    child: Container(
                      width: 5,
                      height: CANVAS_HEIGHT,
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
                      width: CANVAS_WIDTH,
                      color: Colors.black,
                      child: Text(
                        (index * 100).toString(),
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
                  );
                }).toList(),
              ...company.cityRoutes.map((route) {
                var first = route.from;
                bool highlight = false;
                if (selected != null) {
                  highlight = selected!.getRoutesInCompany(company).contains(route);
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
              ...company.allCities.map((city) {
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
                    child: CityOnMap(city),
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
                SizedBox(
                  width: CANVAS_WIDTH,
                  height: CANVAS_HEIGHT,
                  child: GestureDetector(
                    onTap: dismissSelectedCity,
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
                        color: Colors.grey[400],
                      ),
                      child: selected!.isUnlocked()
                          ? SelectedCityView(selected!)
                          : SelectedCityLockedView(selected!),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 0,
          child: Opacity(
            opacity: 0.5,
            child: IconButton(
              onPressed: () async {
                await company.save();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ],
    );
  }

  Point<double> calculateCenterPoint() {
    final width = widget.screenSize.width;
    final height = widget.screenSize.height;
    final sichPoint = Sich().point;
    final middleX = width / 2;
    final middleY = height / 2;
    return Point<double>(
      sichPoint.x - middleX + Sich().size * CITY_SIZE / 2,
      sichPoint.y - middleY + Sich().size * CITY_SIZE / 2,
    );
  }

  dismissSelectedCity() {
    setState(() {
      selected = null;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
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
