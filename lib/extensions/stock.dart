import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

enum STOCK_EVENTS { ADDED, REMOVED }

typedef StockEvent = Tuple2<STOCK_EVENTS, Resource>;

class Stock {
  final List<Resource> stock;
  final BehaviorSubject<StockEvent> changes = BehaviorSubject();

  Stock(this.stock);

  bool get isEmpty {
    return stock.isEmpty;
  }

  Iterable<Resource> get iterator {
    return stock;
  }

  List<Resource> resourceForCategory(RESOURCE_CATEGORY category) {
    return stock.where((res) => res.category == category).toList();
  }

  void addResource(Resource resource) {
    var inStock = resourceInStock(resource);
    if (inStock == null) {
      stock.add(resource);
    } else {
      inStock.amount += resource.amount;
    }
    changes.add(Tuple2(STOCK_EVENTS.ADDED, resource.clone()));
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

  bool hasEnough(Resource resource) {
    var existing = resourceInStock(resource);
    if (existing == null) {
      return false;
    } else {
      return existing.amount >= resource.amount;
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
        changes.add(Tuple2(STOCK_EVENTS.REMOVED, res.clone()));
        return true;
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "stock": stock.map((e) => e.toJson()).toList(),
    };
  }

  static Stock fromJson(Map<String, dynamic> json) {
    List resourcesJson = json["stock"] as List;
    return Stock(resourcesJson.map((e) => Resource.fromJson(e)).toList());
  }

  void dispose() {
    changes.close();
  }
}
