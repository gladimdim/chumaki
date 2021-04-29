import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';

class Price {
  List<PriceUnit> prices;
  final double _buyPriceAdjust = 0.85;

  Price(this.prices);

  static Price defaultPrice = Price(RESOURCES.values
      .map<PriceUnit>(PriceUnit.defaultPriceUnitForResourceType)
      .toList());

  double sellPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices
                .firstWhere((element) => element.resourceType == res.type)
                .price *
            withAmount)
        .toStringAsFixed(1));
  }

  double buyPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices
                .firstWhere((element) => element.resourceType == res.type)
                .price *
            withAmount *
            _buyPriceAdjust)
        .toStringAsFixed(1));
  }

  Map<String, dynamic> toJson() {
    return {
      "prices": prices
          .map((e) => e.toJson()).toList(),
    };
  }

  static Price fromJson(Map<String, dynamic> json) {
    List prices = json["prices"] as List;
    List<PriceUnit> units = prices.map((priceUnitJson) => PriceUnit.fromJson(priceUnitJson)).toList();
    return Price(units);
  }
}

