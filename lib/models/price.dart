import 'package:chumaki/models/resource.dart';
import 'package:tuple/tuple.dart';

class Price {
  List<Tuple2<Resource, double>> prices;
  Price(this.prices);

  static Price defaultPrice = Price(List.from(Price.sellPrices));

  static List<Tuple2<Resource, double>> sellPrices =
      Resource.allResources.map<Tuple2<Resource, double>>((res) {
    double price = 1;
    if (res is Wood) {
      price = 1;
    }
    if (res is Stone) {
      price = 25;
    }
    if (res is Planks) {
      price = 2;
    }
    if (res is Firearm) {
      price = 80;
    }
    if (res is Horse) {
      price = 120;
    }
    if (res is Cannon) {
      price = 500;
    }
    if (res is Food) {
      price = 1;
    }

    if (res is Charcoal) {
      price = 8;
    }
    if (res is Fish) {
      price = 2;
    }

    if (res is Fur) {
      price = 7;
    }

    if (res is Grains) {
      price = 1;
    }

    if (res is IronOre) {
      price = 3;
    }

    if (res is MetalParts) {
      price = 12;
    }

    if (res is Powder) {
      price = 4;
    }
    return Tuple2(res, price);
  }).toList();

  double priceForResource(Resource res, {int withAmount = 1}) {
    return (prices.firstWhere((element) => element.item1.sameType(res)).item2 *
            withAmount);
  }
}
