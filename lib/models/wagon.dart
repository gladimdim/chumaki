import 'package:chumaki/models/resource.dart';
import 'package:rxdart/rxdart.dart';

class Wagon {
  late List<Resource> stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;
  BehaviorSubject changes = BehaviorSubject();

  Wagon({required this.name, List<Resource>? stock}) {
    if (stock == null) {
      this.stock = List.empty(growable: true);
    } else {
      this.stock = stock;
    }
  }

  bool removeFromStock(Resource res) {
    var existing = stock.where((element) => element.sameType(res));
    if (existing.isEmpty) {
      return false;
    } else {
      var currentRes = existing.first;
      if (currentRes.amount < res.amount) {
        return false;
      } else {
        currentRes.amount = currentRes.amount - res.amount;
        if (currentRes.amount <= 0) {
          stock.remove(currentRes);
        }
        changes.add(this);
        return true;
      }
    }
  }
}