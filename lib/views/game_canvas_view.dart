import 'dart:math';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/components/city/city_on_map.dart';
import 'package:chumaki/components/city/selected_city_locked_view.dart';
import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/lviv.dart';

import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';

import 'package:chumaki/models/image_on_canvas.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/utils/points.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const CITY_SIZE = 50;

final globalViewerKey =
    GlobalKey<GameCanvasViewState>(debugLabel: "interactiveViewer");

class GameCanvasView extends StatefulWidget {
  final Company? company;
  final Size screenSize;
  final Duration initialPanDuration;

  GameCanvasView(
      {this.company,
      required this.screenSize,
      required this.initialPanDuration})
      : super(key: globalViewerKey);

  @override
  GameCanvasViewState createState() => GameCanvasViewState();
}

class GameCanvasViewState extends State<GameCanvasView>
    with TickerProviderStateMixin {
  TransformationController _transformationController =
      TransformationController();
  late AnimationController _animationController;
  late Animation<Matrix4> _mapAnimation;
  final Duration animationDuration = Duration(seconds: 2);
  double animationValue = 0;
  bool showCoordinates = false;
  City? selected;
  MAP_MODE mapMode = MAP_MODE.CITY;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: animationDuration, vsync: this);
    navigateFromToCity(to: Lviv(), withDuration: widget.initialPanDuration);
    super.initState();
  }

  @override
  void didUpdateWidget(GameCanvasView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.company != widget.company) {
      navigateFromToCity(to: Sich(), withDuration: animationDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final company = widget.company;
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
                    ),
                  );
                }).toList(),
              if (showCoordinates) ..._renderCoordinateLabels(),
              if (company != null)
                ...company.cityRoutes.map((route) {
                  var first = route.from;
                  bool highlight = false;
                  if (selected != null) {
                    highlight =
                        selected!.getRoutesInCompany(company).contains(route);
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
                                  color:
                                      highlight ? Colors.amber : Colors.brown,
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
              if (company != null)
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
                      child: CityOnMap(
                        city,
                        mapMode: mapMode,
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
                SizedBox(
                  width: CANVAS_WIDTH,
                  height: CANVAS_HEIGHT,
                  child: GestureDetector(
                    onTap: dismissSelectedCity,
                  ),
                ),
              if (selected != null)
                Positioned(
                  left: getShiftedSelectedCity().x,
                  top: getShiftedSelectedCity().y,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3),
                      color: Theme.of(context).backgroundColor,
                      borderRadius: getRadius(),
                    ),
                    child: selected!.isUnlocked()
                        ? ClipRRect(
                            borderRadius: getRadius(),
                            child: SelectedCityView(
                              selected!,
                            ),
                          )
                        : SelectedCityLockedView(selected!),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 0,
          child: IconButton(
            onPressed: () async {
              await company?.save();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        if (selected == null && company != null)
          Positioned(
            bottom: 5,
            left: 10,
            child: Row(
              children: [
                SizedBox(
                  width: 55,
                  height: 55,
                  child: DDDButton(
                    color: mediumGrey,
                    shadowColor: themeData.backgroundColor,
                    onPressed: _toggleMapMode,
                    child: mapMode == MAP_MODE.CITY
                        ? Image.asset("images/resources/wood/wood.png",
                            width: 44)
                        : Image.asset(
                            "images/cities/church.png",
                            width: 44,
                          ),
                  ),
                ),
                SizedBox(
                  width: 55,
                  height: 55,
                  child: Stack(
                    children: [
                      Container(
                        color: themeData.backgroundColor,
                      ),
                      Center(child: Image.asset(Money(0).imagePath, width: 44)),
                      StreamBuilder(
                          stream: company.changes,
                          builder: (context, _) => Center(
                              child:
                                  Text(company.getMoney().amount.toString()))),
                    ],
                  ),
                ),
                SizedBox(
                  width: 55,
                  height: 55,
                  child: DDDButton(
                    color: mediumGrey,
                    shadowColor: themeData.backgroundColor,
                    onPressed: _toggleSoundMode,
                    child: StreamBuilder<APP_PREFERENCES_EVENTS>(
                        stream: AppPreferences.instance.changes.where((event) =>
                            event == APP_PREFERENCES_EVENTS.SOUND_CHANGE),
                        builder: (context, snapshot) {
                          return Image.asset(
                            AppPreferences.instance.getIsSoundEnabled()
                                ? "images/ui/bandura.png"
                                : "images/ui/bandura_back.png",
                            width: 44,
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _renderCoordinateLabels() {
    List<Widget> children = List.empty(growable: true);
    for (var i = 0; i < 53; i++)
      for (var j = 0; j < 42; j++)
        children.add(Positioned(
          top: j * 100 + 20,
          left: i * 100 + 5,
          child: OutlinedText(
            "${i * 100}, ${j * 100}",
          ),
        ));
    return children;
  }

  Point<double> getShiftedSelectedCity() {
    var point = selected!.point;
    var x = min<double>(point.x, CANVAS_WIDTH - CITY_DETAILS_VIEW_WIDTH);
    var y = min<double>(point.y, CANVAS_HEIGHT - CITY_DETAILS_VIEW_WIDTH * 2);
    return Point<double>(x, y);
  }

  Point<double> calculateCenterPointForCity(City city) {
    final width = widget.screenSize.width;
    final height = widget.screenSize.height;
    final sichPoint = city.point;
    final middleX = width / 2;
    final middleY = height / 2;
    return Point<double>(
      sichPoint.x - middleX + Sich().size * CITY_SIZE / 2,
      sichPoint.y - middleY + Sich().size * CITY_SIZE / 2,
    );
  }

  void navigateFromToCity(
      {required City to,
      Duration withDuration = const Duration(milliseconds: 750)}) {
    dismissSelectedCity();

    Matrix4 matrixStart = Matrix4.inverted(_transformationController.value);

    final endPoint = calculateCenterPointForCity(to);
    var end = Matrix4.identity()..translate(endPoint.x, endPoint.y);
    _mapAnimation = Matrix4Tween(begin: matrixStart, end: end)
        .animate(_animationController);
    _animationController.duration = withDuration;
    _mapAnimation.addListener(mapAnimationListener);
    _mapAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _mapAnimation.removeListener(mapAnimationListener);
      }
    });
    _animationController.reset();
    _animationController.forward();
  }

  void mapAnimationListener() {
    setState(() {
      final value = Matrix4.inverted(_mapAnimation.value);
      _transformationController.value = value;
    });
  }

  BorderRadius getRadius() {
    return BorderRadius.only(
        bottomRight: Radius.circular(20), topRight: Radius.circular(20));
  }

  dismissSelectedCity() {
    setState(() {
      selected = null;
    });
  }

  void _toggleMapMode() {
    setState(() {
      if (mapMode == MAP_MODE.CITY) {
        mapMode = MAP_MODE.RESOURCE;
      } else {
        mapMode = MAP_MODE.CITY;
      }
    });
  }

  void _toggleSoundMode() async {
    await AppPreferences.instance.toogleIsSoundEnabled();
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

enum MAP_MODE { CITY, RESOURCE }
