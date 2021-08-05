import 'dart:collection';
import 'dart:math';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/tasks/route_task.dart';
import 'package:chumaki/models/wagons/wagon.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;
  List<RouteTask> routeTasks = List.empty(growable: true);

  CityRoute(this.to, this.from, this.bezierPoint);
}

List<City> fullRoute(
    {required City from,
    required City to,
    bool allowLocked = false,
    SHORTEST_ROUTE algoChoice = SHORTEST_ROUTE.LESS_TIME,
    required Company company}) {
  List<City>? result = _innerFullRoute(
      from: from,
      to: to,
      ignore: [from],
      route: [],
      allowLocked: allowLocked,
      algoChoice: algoChoice,
      company: company);
  if (result == null) {
    throw "Route not found";
  } else {
    return result;
  }
}

enum SHORTEST_ROUTE { FEWER_STOPS, LESS_TIME }

List<City>? _innerFullRoute({
  required City from,
  required City to,
  required List<City> ignore,
  required List<City> route,
  required bool allowLocked,
  required Company company,
  required SHORTEST_ROUTE algoChoice,
}) {
  if (hasDirectConnection(from: from, to: to, inCompany: company) &&
      (allowLocked || to.isUnlocked())) {
    return [to];
  }

  Queue<City> neighbours = Queue.from(from
      .connectsTo(inCompany: company)
      .where((element) => (allowLocked || element.isUnlocked())));
  List<City>? bestMatch;
  final comparator =
      algoChoice == SHORTEST_ROUTE.FEWER_STOPS ? hasFewerStops : isShorterRoute;
  while (neighbours.isNotEmpty) {
    final candidate = neighbours.removeFirst();
    if (ignore.where((element) => element.equalsTo(candidate)).isNotEmpty) {
      continue;
    }
    if (hasDirectConnection(from: candidate, to: to, inCompany: company)) {
      final List<City> newRoute = List.from(route)..addAll([candidate, to]);
      return newRoute;
    } else {
      final match = _innerFullRoute(
          from: candidate,
          to: to,
          ignore: [...ignore, candidate],
          route: [...route, candidate],
          allowLocked: allowLocked,
          algoChoice: algoChoice,
          company: company);
      if (bestMatch == null) {
        bestMatch = match;
      } else {
        if (match != null && match.isNotEmpty && comparator(bestMatch, match)) {
          bestMatch = match;
        }
      }
    }
  }
  return bestMatch;
}

bool isShorterRoute(List<City> route, List<City> thanRoute) {
  final Duration firstDuration = fullRouteDuration(cityStops: route);
  final Duration secondDuration = fullRouteDuration(cityStops: thanRoute);

  return firstDuration > secondDuration;
}

bool hasFewerStops(List<City> route, List<City> thanRoute) {
  return route.length > thanRoute.length;
}

Duration fullRouteDuration({required List<City> cityStops}) {
  final fakeWagon = Wagon();
  Duration duration = Duration(seconds: 0);
  final Queue<City> stops = Queue.from(cityStops);
  if (stops.isEmpty) {
    return duration;
  }
  var first = stops.removeFirst();
  var last;
  while (stops.isNotEmpty) {
    last = stops.removeFirst();
    duration = duration + RouteTask(first, last, wagon: fakeWagon).duration!;
    first = last;
  }
  return duration;
}

bool hasDirectConnection(
    {required City from, required City to, required Company inCompany}) {
  return from
      .connectsTo(inCompany: inCompany)
      .where((element) => element.equalsTo(to))
      .isNotEmpty;
}
