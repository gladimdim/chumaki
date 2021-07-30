import 'dart:collection';
import 'dart:math';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/tasks/route_task.dart';

class CityRoute {
  final City from;
  final City to;
  final Point<double> bezierPoint;
  List<RouteTask> routeTasks = List.empty(growable: true);

  CityRoute(this.to, this.from, this.bezierPoint);

  // static List<CityRoute> allRoutes = [
  //   CityRoute(City.cherkasy, City.chigirin, Point<double>(50.0, 50.0)),
  //   CityRoute(City.pereyaslav, City.nizhin, Point<double>(0.0, 0.0)),
  //   CityRoute(City.cherkasy, City.kaniv, Point<double>(10.0, 10.0)),
  //   CityRoute(City.sich, City.chigirin, Point<double>(-675.0, 0.0)),
  //   CityRoute(City.pereyaslav, City.chigirin, Point<double>(-150.0, 155.0)),
  //   CityRoute(City.kyiv, City.nizhin, Point<double>(-50, 50)),
  //   CityRoute(City.kyiv, City.pereyaslav, Point<double>(300, 0)),
  //   CityRoute(City.kaniv, City.pereyaslav, Point<double>(100, -50)),
  //   CityRoute(City.ochakiv, City.sich, Point<double>(450, -230)),
  // ];
}

List<City> fullRoute(
    {required City from,
    required City to,
    bool allowLocked = false,
    required Company company}) {
  List<City>? result = _innerFullRoute(
      from: from,
      to: to,
      ignore: [from],
      route: [],
      allowLocked: allowLocked,
      company: company);
  if (result == null) {
    throw "Route not found";
  } else {
    return result;
  }
}

List<City>? _innerFullRoute({
  required City from,
  required City to,
  required List<City> ignore,
  required List<City> route,
  required bool allowLocked,
  required Company company,
}) {
  if (hasDirectConnection(from: from, to: to, inCompany: company) &&
      (allowLocked || to.isUnlocked())) {
    return [to];
  }

  Queue<City> neighbours = Queue.from(from
      .connectsTo(inCompany: company)
      .where((element) => (allowLocked || element.isUnlocked())));
  List<City>? bestMatch;
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
          company: company);
      if (bestMatch == null) {
        bestMatch = match;
      } else {
        if (match != null &&
            match.isNotEmpty &&
            match.length < bestMatch.length) {
          bestMatch = match;
        }
      }
    }
  }
  return bestMatch;
}

bool hasDirectConnection(
    {required City from, required City to, required Company inCompany}) {
  return from
      .connectsTo(inCompany: inCompany)
      .where((element) => element.equalsTo(to))
      .isNotEmpty;
}
