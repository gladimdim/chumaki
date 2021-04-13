import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/resource.dart';
import 'package:uuid/uuid.dart';

class RouteTask extends ProgressDuration {
  final City from;
  final City to;
  DateTime? endTaskDate;
  final String id = Uuid().v4().toString();

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
    this.to,
    this.from, {
    duration = const Duration(seconds: 15),
  }) : super(duration);
}
