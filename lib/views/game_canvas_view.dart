import 'dart:math';
import 'dart:ui' as ui;

import 'package:chumaki/components/city/city_on_map.dart';
import 'package:chumaki/components/city/selected_city_locked_view.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/route_paint.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/components/ui/notification_box.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/image_on_canvas.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/utils/points.dart';
import 'package:chumaki/views/general_help_view.dart';
import 'package:chumaki/views/logger_view.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum MAP_MODE { CITY, RESOURCE }

const CITY_SIZE = 50;
const double MENU_ITEM_WIDTH = 55.0;

final globalViewerKey =
    GlobalKey<GameCanvasViewState>(debugLabel: "interactiveViewer");

class GameCanvasView extends StatefulWidget {
  final Company? company;
  final Size screenSize;
  final Duration initialPanDuration;
  final VoidCallback onBackPressed;

  GameCanvasView(
      {this.company,
      Key? key,
      required this.screenSize,
      required this.onBackPressed,
      required this.initialPanDuration})
      : super(key: key);

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
    super.initState();
    _animationController =
        AnimationController(duration: animationDuration, vsync: this);
    if (widget.company == null) {
      navigateToCity(
          to: Company().allCities.takeRandom(),
          withDuration: widget.initialPanDuration);
    } else {
      navigateToCity(to: Sich(), withDuration: animationDuration);
    }
  }

  @override
  void didUpdateWidget(GameCanvasView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.company != widget.company) {
      navigateToCity(to: Sich(), withDuration: animationDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final company = widget.company;
    return Stack(
      children: [
        InteractiveViewer(
          panEnabled: widget.company != null,
          scaleEnabled: widget.company != null,
          transformationController: _transformationController,
          minScale: 0.1,
          constrained: false,
          maxScale: 3.0,
          child: Stack(
            children: [
              ResizedImage(
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
                        stream: MergeStream([
                          company.refToCityByName(route.from).changes,
                          company.refToCityByName(route.to).changes
                        ]).where((event) => [
                              CITY_EVENTS.WAGON_ARRIVED,
                              CITY_EVENTS.WAGON_DISPATCHED
                            ].contains(event)),
                        builder: (context, snapshot) {
                          return FutureBuilder(
                            future: ImageOnCanvas.wagonImage.asBytes(),
                            builder: (context, snapshotImage) {
                              if (snapshotImage.hasData) {
                                var data = snapshotImage.data as ui.Image;

                                return route.routeTasks.isEmpty
                                    ? CustomPaint(
                                        painter: RoutePainter(
                                          color: highlight
                                              ? Colors.amber
                                              : Colors.brown,
                                          route: route,
                                          image: data,
                                        ),
                                      )
                                    : StreamBuilder(
                                        stream: Stream.periodic(
                                            Duration(milliseconds: 33)),
                                        builder: (context, snapshot) {
                                          return CustomPaint(
                                            painter: RoutePainter(
                                              color: highlight
                                                  ? Colors.amber
                                                  : Colors.brown,
                                              route: route,
                                              image: data,
                                            ),
                                          );
                                        });
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
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
                        print("pressed city: ${city.localizedKeyName}");
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
                      // color: Theme.of(context).backgroundColor,
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
        if (selected == null && company != null) LoggerView(company: company),
        if (selected == null && company != null) GeneralHelpViewButton(),
        if (company != null)
          Positioned(
            top: 5,
            left: _menuShiftFor(0),
            child: AnimatedSize(
              alignment: Alignment.centerLeft,
              duration: Duration(milliseconds: 400),
              child: Row(
                children: [
                  Container(
                    color: themeData.backgroundColor,
                    child: SizedBox(
                      width: MENU_ITEM_WIDTH,
                      height: MENU_ITEM_WIDTH,
                      child: DDDButton(
                        color: mediumGrey,
                        shadowColor: themeData.backgroundColor,
                        waitTillCallback: Duration(milliseconds: 0),
                        onPressed: onBackPressed,
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  if (selected == null)
                    SizedBox(
                      width: MENU_ITEM_WIDTH,
                      height: MENU_ITEM_WIDTH,
                      child: DDDButton(
                        color: mediumGrey,
                        shadowColor: themeData.backgroundColor,
                        onPressed: _toggleMapMode,
                        child: mapMode == MAP_MODE.CITY
                            ? ResizedImage("images/resources/wood/wood.png",
                                width: 44)
                            : ResizedImage(
                                "images/cities/church.png",
                                width: 44,
                              ),
                      ),
                    ),
                  SizedBox(
                    width: MENU_ITEM_WIDTH,
                    height: MENU_ITEM_WIDTH,
                    child: Stack(
                      children: [
                        Container(
                          color: themeData.backgroundColor,
                        ),
                        Center(
                            child: ResizedImage(Money(0).imagePath, width: 44)),
                        StreamBuilder(
                          stream: company.changes,
                          builder: (context, _) => Center(
                            child: BouncingOutlinedText(
                              company.getMoney().amount.toInt().toString(),
                              outlineColor: Colors.black,
                              fontColor: Colors.yellow,
                              size: 18,
                              style: gameTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NotificationBox(
                    company: company,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  double _menuShiftFor(int index) {
    return (index * MENU_ITEM_WIDTH).toDouble();
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

  onBackPressed() async {
    final company = widget.company;
    if (company == null) {
      return;
    }
    if (selected != null) {
      dismissSelectedCity();
    } else {
      await company.save();
      SoundManager.instance.detachFromCompany();
      company.dispose();
      widget.onBackPressed();
    }
  }

  Point<double> getShiftedSelectedCity() {
    var point = selected!.point;
    var x = min<double>(point.x, CANVAS_WIDTH - CITY_DETAILS_VIEW_WIDTH);
    var y = min<double>(point.y, CANVAS_HEIGHT - CITY_DETAILS_VIEW_WIDTH * 1.7);
    return Point<double>(x, y);
  }

  Point<double> calculateCenterPointForCity(City city) {
    final width = widget.screenSize.width;
    final height = widget.screenSize.height;
    final cityPoint = city.point;
    final middleX = width / 2;
    final middleY = height / 2;
    return Point<double>(
      cityPoint.x - middleX + city.size * CITY_SIZE / 2,
      cityPoint.y - middleY + city.size * CITY_SIZE / 2,
    );
  }

  void navigateToCity(
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
    _mapAnimation.addStatusListener(_onMapAnimationStatusChange);
    _animationController.reset();
    _animationController.forward();
  }

  void _onMapAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _mapAnimation.removeListener(mapAnimationListener);
      _mapAnimation.removeStatusListener(_onMapAnimationStatusChange);
      if (widget.company == null) {
        final fakeCompany = Company();
        print("Navigating to city");
        navigateToCity(
            to: fakeCompany.allCities.takeRandom(),
            withDuration: widget.initialPanDuration);
      }
    }
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

  void showHelp() {}

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }
}
