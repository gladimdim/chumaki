import 'dart:math';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/task.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;
  List<RouteTask> routeTasks = List.empty(growable: true);


  CityRoute(this.to, this.from, this.bezierPoint);

  static List<CityRoute> allRoutes = [
    CityRoute(City.cherkasy, City.chigirin, Point<double>(50.0, 50.0)),
    CityRoute(City.pereyaslav, City.nizhin, Point<double>(0.0, 0.0)),
    CityRoute(City.cherkasy, City.kaniv, Point<double>(10.0, 10.0)),
    CityRoute(City.sich, City.chigirin, Point<double>(-675.0, 0.0)),
    CityRoute(City.pereyaslav, City.chigirin, Point<double>(-150.0, 155.0)),
    CityRoute(City.kyiv, City.nizhin, Point<double>(-50, 50)),
    CityRoute(City.kyiv, City.pereyaslav, Point<double>(300, 0)),
    CityRoute(City.kaniv, City.pereyaslav, Point<double>(100, -50)),
    CityRoute(City.ochakiv, City.sich, Point<double>(450, -230)),
  ];
}
