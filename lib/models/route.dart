import 'dart:math';

import 'package:chumaki/models/city.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;

  CityRoute(this.to, this.from, this.bezierPoint);

  static List<CityRoute> allRoutes =  [
    CityRoute(Nizhin(), Sich(), Point<double>(80.0, 20.0)),
    CityRoute(Nizhin(), Sloboda(), Point<double>(80.0, 40.0)),
    CityRoute(Cherkasy(), Sloboda(), Point<double>(-80.0, 40.0)),
    CityRoute(Cherkasy(), Yagidne(), Point<double>(150.0, 150.0)),
    CityRoute(Cherkasy(), Kaniv(), Point<double>(250.0, 250.0)),
  ];

}