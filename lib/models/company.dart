import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';

class Company {
  List<RouteTask> tasks = List.empty(growable: true);
  final List<CityRoute> cityRoutes = CityRoute.allRoutes;
  static final Company instance = Company._internal();
  Company._internal();

  addTaskForRoute(RouteTask routeTask, CityRoute route) {
    tasks.add(routeTask);
  }

  CityRoute getRouteForTask(RouteTask routeTask) {
    var from = routeTask.from;
    var to = routeTask.to;
    return cityRoutes.firstWhere((route) {
      return (route.to.equalsTo(to) && route.from.equalsTo(from)) || (route.to.equalsTo(from) && route.from.equalsTo(to));
    });
  }
}