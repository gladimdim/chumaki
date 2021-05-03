import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:rxdart/rxdart.dart';

class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/cart.png";
  final String localizedNameKey;
  double totalWeightCapacity;
  BehaviorSubject changes = BehaviorSubject();

  String get fullLocalizedName {
    return "${ChumakiLocalizations.labelCompany} ${ChumakiLocalizations.getForKey(localizedNameKey)}";
  }

  Wagon({required this.localizedNameKey, Stock? stock, this.totalWeightCapacity = 100.0}) {
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

  Map<String, dynamic> toJson() {
    return {
      "stock": stock.toJson(),
      "name": localizedNameKey,
      "totalWeightCapacity": totalWeightCapacity,
    };
  }

  static Wagon fromJson(Map<String, dynamic> json) {
    var stock = Stock.fromJson(json["stock"]);
    return Wagon(localizedNameKey: json["name"], stock: stock, totalWeightCapacity: json["totalWeightCapacity"]);
  }
}