import 'package:chumaki/models/resource.dart';
import 'package:rxdart/rxdart.dart';

class Stock {
  final List<Resource> stock;
  final BehaviorSubject changes = BehaviorSubject();

  Stock(this.stock);

  bool get isEmpty {
    return stock.isEmpty;
  }

  Iterable<Resource> get iterator {
    return stock;
  }

  void addResource(Resource resource) {
    var inStock = resourceInStock(resource);
    if (inStock == null) {
      stock.add(resource);
    } else {
      inStock.amount += resource.amount;
    }
    changes.add(this);
  }

  bool hasResource(Resource res) {
    return resourceInStock(res) != null;
  }

  Resource? resourceInStock(Resource res) {
    try {
      return stock.firstWhere((inStock) => inStock.sameType(res));
    } catch (e) {
      return null;
    }
  }

  bool removeResource(Resource res) {
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

  void dispose() {
    changes.close();
  }
}
