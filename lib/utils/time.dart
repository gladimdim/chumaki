import 'package:intl/intl.dart';

String readableDuration(Duration duration) {
  var format = DateFormat("mm:ss");
  var date = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  date = date.add(duration);
  return format.format(date);
}
