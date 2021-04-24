import 'package:chumaki/models/resource.dart';

class Price {
  List<PriceUnit> prices;
  final double _buyPriceAdjust = 0.8;

  Price(this.prices);

  static Price defaultPrice = Price(RESOURCES.values.map<PriceUnit>((type) =>
      PriceUnit.defaultPriceUnitForResourceType(type)).toList());


  double sellPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices
        .firstWhere((element) => element.resourceType == res.type)
        .price *
        withAmount).toStringAsFixed(1));
  }

  double buyPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices.firstWhere((element) => element.resourceType == res.type).price *
        withAmount * _buyPriceAdjust).toStringAsFixed(1));
  }
}

class PriceUnit {
  final RESOURCES resourceType;
  final double price;

  PriceUnit(this.resourceType, this.price);

  PriceUnit adjustToModifier(double mod) {
    return PriceUnit(this.resourceType, price * mod);
  }

  static PriceUnit defaultPriceUnitForResourceType(RESOURCES resType) {
    switch (resType) {
      case RESOURCES.BREAD:
        return PriceUnit(RESOURCES.BREAD, 1);
      case RESOURCES.CANNON:
        return PriceUnit(RESOURCES.CANNON, 500);
      case RESOURCES.CHARCOAL:
        return PriceUnit(RESOURCES.CHARCOAL, 8);
      case RESOURCES.FIREARM:
        return PriceUnit(RESOURCES.FIREARM, 20);
      case RESOURCES.FISH:
        return PriceUnit(RESOURCES.FISH, 2);
      case RESOURCES.FUR:
        return PriceUnit(RESOURCES.FUR, 5);
      case RESOURCES.GRAINS:
        return PriceUnit(RESOURCES.GRAINS, 0.8);
      case RESOURCES.HORSE:
        return PriceUnit(RESOURCES.HORSE, 50);
      case RESOURCES.IRONORE:
        return PriceUnit(RESOURCES.IRONORE, 5);
      case RESOURCES.METALPARTS:
        return PriceUnit(RESOURCES.METALPARTS, 10);
      case RESOURCES.PLANKS:
        return PriceUnit(RESOURCES.PLANKS, 12);
      case RESOURCES.POWDER:
        return PriceUnit(RESOURCES.POWDER, 8);
      case RESOURCES.STONE:
        return PriceUnit(RESOURCES.STONE, 15);
      case RESOURCES.WOOD:
        return PriceUnit(RESOURCES.WOOD, 2);
      case RESOURCES.SALT:
        return PriceUnit(RESOURCES.SALT, 6);
      case RESOURCES.SILK:
        return PriceUnit(RESOURCES.SILK, 20);
      case RESOURCES.WOOL:
        return PriceUnit(RESOURCES.SILK, 0.8);
    }
  }
}