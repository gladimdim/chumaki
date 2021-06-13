import 'dart:async';
import 'dart:collection';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/routes/route_task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';

class PathRoute {
  Queue<City> routeStops;
  final BehaviorSubject changes = BehaviorSubject();
  final City from;
  final City to;
  final Wagon wagon;
  PathRoute({required this.routeStops});

  void startNextTask() {
    if (routeStops.isNotEmpty) {
      final next = routeStops.removeFirst();
      var newTask = RouteTask(from, nextStop, wagon: wagon);
      // notify from City that the trade company with the given wagon departed
      from.routeTaskStarted(newTask);
      await _startIntermediateTask(newTask);
      from = nextStop;
    }
  }

  Future _startIntermediateTask(RouteTask newTask) async {
    final completer = Completer();
    var cityRoute = getRouteForTask(newTask);
    // add new task to the city route (curves on the map)
    cityRoute.routeTasks.add(newTask);
    newTask.start();
    activeRouteTasks.add(newTask);
    // listen to the finish event in order to add wagon to the "to" city
    newTask.changes.listen((event) {
      if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
        processTaskDone(newTask);
        completer.complete();
      }
    });
    _innerChanges.add(COMPANY_EVENTS.TASK_STARTED);
    return completer.future;
  }
}