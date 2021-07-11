import 'dart:math';

import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:uuid/uuid.dart';

class RouteTask extends ProgressDuration {
  City from;
  City to;
  static Duration durationPerPoint = Duration(milliseconds: 10);
  final String id = Uuid().v4().toString();
  Wagon wagon;

  RouteTask(
    this.from,
    this.to, {
    required this.wagon,
  }) : super.empty() {
    duration = RouteTask.durationBetweenCities(from: from, to: to);
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["from"] = from.toJson();
    map["to"] = to.toJson();
    map["id"] = id;
    map["wagon"] = wagon.toJson();
    return map;
  }

  static RouteTask fromJson(Map<String, dynamic> input) {
    var progress = ProgressDuration.fromJson(input);
    var task = RouteTask(
        City.fromJson(input["from"]), City.fromJson(input["to"]),
        wagon: Wagon.fromJson(input["wagon"]));
    task.changes = progress.changes;
    task.isFinished = progress.isFinished;
    task.finishAt = progress.finishAt;
    task.duration = progress.duration;
    task.isStarted = progress.isStarted;
    return task;
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
