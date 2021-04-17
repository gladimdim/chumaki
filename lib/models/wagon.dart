import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resource.dart';
import 'package:rxdart/rxdart.dart';

class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;
  double totalWeightCapacity;
  BehaviorSubject changes = BehaviorSubject();

  Wagon({required this.name, Stock? stock, this.totalWeightCapacity = 100.0}) {
    if (stock == null) {
      this.stock = Stock(List.empty(growable: true));
    } else {
      this.stock = stock;
    }

    this.stock.changes.listen((value) {
      changes.add(value);
    });
  }

  bool canFitNewResource(Resource res) {
      return totalWeightCapacity > currentWeight + res.totalWeight;
  }

  double get currentWeight {
    return stock.iterator.fold(0, (previousValue, resource) {
      return previousValue + resource.totalWeight;
    });
  }

  void dispose() {
    changes.close();
  }
}