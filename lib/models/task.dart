import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:uuid/uuid.dart';

class RouteTask extends ProgressDuration {
  final City from;
  final City to;
  DateTime? endTaskDate;
  final String id = Uuid().v4().toString();
  Wagon wagon;

  Set<Resource> stock = Set();

  void addToStock(Resource resource) {
    var inStock = resourceInStock(resource);
    if (inStock == null) {
      stock.add(resource);
    } else {
      inStock.amount += resource.amount;
    }
  }

  Resource? resourceInStock(Resource res) {
    try {
      return stock.firstWhere((inStock) => inStock.sameType(res));
    } catch (e) {
      return null;
    }
  }

  RouteTask(
    this.from,
    this.to, {
      required this.wagon,
    duration = const Duration(seconds: 5),
  }) : super(duration);
}
