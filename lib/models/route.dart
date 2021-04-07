import 'dart:math';

import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/task.dart';
import 'package:rxdart/rxdart.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;
  List<RouteTask> routeTasks = List.empty(growable: true);


  BehaviorSubject _innerChanges = BehaviorSubject();
  late ValueStream changes;

  CityRoute(this.to, this.from, this.bezierPoint);

  void addTask(RouteTask task) {
    routeTasks.add(task);
  }

  static List<CityRoute> allRoutes = [
    CityRoute(Nizhin(), Sich(), Point<double>(80.0, 20.0)),
    CityRoute(Nizhin(), Sloboda(), Point<double>(80.0, 40.0)),
    CityRoute(Cherkasy(), Sloboda(), Point<double>(-80.0, 40.0)),
    CityRoute(Cherkasy(), Yagidne(), Point<double>(50.0, 50.0)),
    CityRoute(Cherkasy(), Nizhin(), Point<double>(0.0, 0.0)),
    CityRoute(Yagidne(), Kaniv(), Point<double>(10.0, 30.0)),
    CityRoute(Sich(), Kaniv(), Point<double>(5.0, 5.0)),
    CityRoute(Sich(), Yagidne(), Point<double>(-75.0, -55.0)),
    CityRoute(Sloboda(), Yagidne(), Point<double>(75.0, 55.0)),
  ];
}
