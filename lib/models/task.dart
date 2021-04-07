import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';

class RouteTask extends ProgressDuration {
  final City from;
  final City to;
  DateTime? endTaskDate;

  RouteTask(
    this.to,
    this.from, {
    duration = const Duration(seconds: 5),
  }): super(duration);
}
