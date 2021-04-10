import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:uuid/uuid.dart';
class RouteTask extends ProgressDuration {
  final City from;
  final City to;
  DateTime? endTaskDate;
  final String id = Uuid().v4().toString();

  RouteTask(
    this.to,
    this.from, {
    duration = const Duration(seconds: 15),
  }): super(duration);
}
