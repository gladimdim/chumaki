import 'dart:collection';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/tasks/route.dart';
import 'package:chumaki/models/tasks/route_task.dart';
import 'package:chumaki/models/wagons/wagon.dart';

class PathRoute {
  final List<City> stops;
  final List<CityRoute> allRoutes;
  final City from;

  PathRoute({required this.stops, required this.allRoutes, required this.from});

  Duration totalDuration() {
    final Queue<City> queue = Queue.from(stops);

    Duration total = Duration(seconds: 0);
    if (stops.isEmpty) {
      return total;
    }
    var start = from;

    while (queue.isNotEmpty) {
      final next = queue.removeFirst();
      final task = RouteTask(start, next, wagon: Wagon());
      total += task.duration!;
      start = next;
    }
    return total;
  }
}
