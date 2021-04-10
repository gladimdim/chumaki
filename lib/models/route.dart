import 'dart:math';

import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/task.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;
  List<RouteTask> routeTasks = List.empty(growable: true);


  CityRoute(this.to, this.from, this.bezierPoint);

  static List<CityRoute> allRoutes = [
    CityRoute(Nizhin(), Pereyaslav(), Point<double>(75.0, 140.0)),
    CityRoute(Cherkasy(), Pereyaslav(), Point<double>(80.0, -200.0)),
    CityRoute(Cherkasy(), Chigirin(), Point<double>(50.0, 50.0)),
    CityRoute(Cherkasy(), Nizhin(), Point<double>(0.0, 0.0)),
    CityRoute(Cherkasy(), Kaniv(), Point<double>(10.0, 10.0)),
    CityRoute(Sich(), Chigirin(), Point<double>(-75.0, -55.0)),
    CityRoute(Pereyaslav(), Chigirin(), Point<double>(-150.0, 155.0)),
  ];
}
