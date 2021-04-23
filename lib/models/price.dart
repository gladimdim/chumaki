import 'package:chumaki/models/resource.dart';

class Price {
  List<PriceUnit> prices;
  final double _buyPriceAdjust = 0.8;
  Price(this.prices);

  static Price defaultPrice = Price(List.from(Price.sellPrices));

  static List<PriceUnit> sellPrices =
      Resource.allResources.map<PriceUnit>((res) {
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
    if (res is Bread) {
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
    return PriceUnit(res, price);
  }).toList();

  double sellPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices.firstWhere((element) => element.resource.sameType(res)).price *
            withAmount).toStringAsFixed(1));
  }

  double buyPriceForResource(Resource res, {int? withAmount}) {
    if (withAmount == null) {
      withAmount = res.amount;
    }
    return double.parse((prices.firstWhere((element) => element.resource.sameType(res)).price *
        withAmount * _buyPriceAdjust).toStringAsFixed(1));
  }
}

class PriceUnit {
  final Resource resource;
  final double price;
  PriceUnit(this.resource, this.price);

  PriceUnit adjustToModifier(double mod) {
    return PriceUnit(this.resource, price * mod);
  }

  static PriceUnit get bread {
    return PriceUnit(Bread(0), 1);
  }

  static PriceUnit get cannon {
    return PriceUnit(Cannon(0), 500);
  }

  static PriceUnit get charcoal {
    return PriceUnit(Charcoal(0), 8);
  }

  static PriceUnit get firearm {
    return PriceUnit(Firearm(0), 20);
  }

  static PriceUnit get fish {
    return PriceUnit(Fish(0), 2);
  }

  static PriceUnit get fur {
    return PriceUnit(Fur(0), 5);
  }

  static PriceUnit get grains {
    return PriceUnit(Grains(0), 0.8);
  }

  static PriceUnit get horse {
    return PriceUnit(Horse(0), 50);
  }

  static PriceUnit get ironOre {
    return PriceUnit(IronOre(0), 5);
  }

  static PriceUnit get metalParts {
    return PriceUnit(MetalParts(0), 10);
  }

  static PriceUnit get planks {
    return PriceUnit(Planks(0), 12);
  }

  static PriceUnit get powder {
    return PriceUnit(Powder(0), 8);
  }

  static PriceUnit get stone {
    return PriceUnit(Stone(0), 15);
  }

  static PriceUnit get wood {
    return PriceUnit(Wood(0), 2);
  }

}