import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Nizhin extends City {
  Nizhin()
      : super(
          point: Point(1950, 2950),
          name: "Ніжин",
          size: 3,
          localizedKeyName: 'nizhin',
          unlocked: false,
          unlocksCities: [],
          prices: Price(generatePriceUnits()),
          stock: Stock(
            [
              Grains(2000),
              Wood(800),
              Horse(50),
              Powder(100),
              Fur(400),
              Planks(400),
              Stone(50),
              Fish(100),
              Cannon(10),
              Salt(200),
              Wool(100),
              Amber(300),
            ],
          ),
        );

  Money unlockPriceMoney = Money(200);

  static List<PriceUnit> generatePriceUnits() {
    return RESOURCES.values.map<PriceUnit>((resType) {
      switch (resType) {
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.WOOD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.7);
        case RESOURCES.STONE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.PLANKS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.FIREARM:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.HORSE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.CANNON:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.7);
        case RESOURCES.CHARCOAL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.FISH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.FUR:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.02);
        case RESOURCES.GRAINS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.7);
        case RESOURCES.IRONORE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.METALPARTS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.POWDER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.6);
        case RESOURCES.SALT:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
        case RESOURCES.SILK:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2.3);
        case RESOURCES.WOOL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.GORILKA:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.HONEY:
          return PriceUnit.defaultPriceUnitForResourceType(resType).adjustToModifier(1.2);
        case RESOURCES.WAX:
          return PriceUnit.defaultPriceUnitForResourceType(resType).adjustToModifier(1.2);
        case RESOURCES.TOBACCO:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.AMBER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.05);
        case RESOURCES.CLOTH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
      }
    }).toList();
  }
}
