import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/city.dart';


import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';

import 'package:chumaki/models/image_on_canvas.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/route.dart';
import 'dart:ui' as ui;

const CITY_SIZE = 50;

class MainView extends StatefulWidget {
  final Company company;

  MainView({required this.company});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with TickerProviderStateMixin {
  TransformationController _transformationController =
      TransformationController();
  late AnimationController _animationController;
  late AnimationController _scaleAnimationController;
  late Animation<Matrix4> _mapAnimation;
  var start = Matrix4.identity()..translate(5340.0, 4195);
  var end = Matrix4.identity()..translate(Sich().point.x, Sich().point.y);
  double animationValue = 0;
  bool showCoordinates = false;
  City? selected;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _scaleAnimationController = AnimationController(
        lowerBound: 0.1,
        upperBound: 2.5,
        vsync: this,
        duration: Duration(seconds: 5));
    _mapAnimation =
        Matrix4Tween(begin: start, end: end).animate(_animationController);
    _mapAnimation.addListener(() {
      setState(() {
        print(_mapAnimation.value);
        var newMatrix = Matrix4.inverted(_mapAnimation.value);
        // newMatrix.scale(_scaleAnimationController.value, _scaleAnimationController.value, 1.0);
        _transformationController.value = newMatrix;
        // _transformationController.value.scale(2.0, 2.0);
      });
    });
    _transformationController.addListener(() {
      print(_transformationController.value.getMaxScaleOnAxis());
    });
    _animationController.addStatusListener(print);
    _animationController.forward();
    _scaleAnimationController.forward();
    _scaleAnimationController.addListener(() {
      print("Scale value: ${_scaleAnimationController.value}");
    });
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
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.yellow,
                            Colors.yellow,
                            Colors.blue,
                            Colors.blue,
                          ],
                          stops: [0, 0.49, 0.51, 1],
                        ),
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: CITY_SIZE * city.size,
                      height: CITY_SIZE * city.size,
                      child: StreamBuilder(
                        stream: city.changes.stream,
                        builder: (context, snapshot) => Stack(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(city.avatarImagePath,
                                  width: CITY_SIZE.toDouble() * city.size),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                ChumakiLocalizations.getForKey(
                                    city.localizedKeyName),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8 * city.size,
                                    backgroundColor: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (city.size > 1)
                              Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  children: [
                                    Image.asset(
                                      Wagon.imagePath,
                                      width: 15 * city.size,
                                    ),
                                    Text(
                                      city.wagons.length.toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                          ],
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
                        color: Colors.grey[400],
                      ),
                      child: SelectedCityView(city: selected!),
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ],
    );
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
