import 'dart:math';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:uuid/uuid.dart';

class RouteTask extends ProgressDuration {
  final City from;
  final City to;
  static Duration durationPerPoint = Duration(milliseconds: 10);
  DateTime? endTaskDate;
  final String id = Uuid().v4().toString();
  Wagon wagon;

  Set<Resource> stock = Set();

  RouteTask(
    this.from,
    this.to, {
    required this.wagon,
  }) : super.empty() {
    duration = RouteTask.durationBetweenCities(from: from, to: to);
  }

  static Duration durationBetweenCities(
      {required City from, required City to}) {
    var a = from.point;
    var b = to.point;
    var distance = sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));

    return Duration(
      milliseconds:
          distance.toInt() * RouteTask.durationPerPoint.inMilliseconds,
    );
  }
}
