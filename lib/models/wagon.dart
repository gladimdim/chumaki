import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resource.dart';
import 'package:rxdart/rxdart.dart';

class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;
  BehaviorSubject changes = BehaviorSubject();

  Wagon({required this.name, Stock? stock}) {
    if (stock == null) {
      this.stock = Stock(List.empty(growable: true));
    } else {
      this.stock = stock;
    }
  }


  bool removeFromStock(Resource res) {
    var existing = stock.resourceInStock(res);
    if (existing == null) {
      return false;
    } else {
      if (existing.amount < res.amount) {
        return false;
      } else {
        existing.amount = existing.amount - res.amount;
        if (existing.amount <= 0) {
          stock.removeResource(existing);
        }
        changes.add(this);
        return true;
      }
    }
  }

  void addToStock(Resource res) {

  }
}