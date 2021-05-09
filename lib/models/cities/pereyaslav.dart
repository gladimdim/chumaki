import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          unlocked: true,
          localizedKeyName: 'pereyaslav',
          size: 2,
          unlocksCities: [City.kyiv],
          prices: Price(generatePriceUnits()),
          stock: Stock([
            Bread(1000),
            Stone(1000),
            Cannon(3),
            Grains(1000),
            Fur(100),
            Planks(500),
            Wood(1000),
            MetalParts(100),
            Firearm(40),
            Salt(150),
            Wool(150),
            Honey(500),
            Wax(500),
          ]),
        );

  static List<PriceUnit> generatePriceUnits() {
    return RESOURCES.values.map<PriceUnit>((resType) {
      switch (resType) {
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.WOOD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.STONE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.PLANKS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.FIREARM:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.HORSE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.CANNON:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.7);
        case RESOURCES.CHARCOAL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.FISH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.FUR:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.GRAINS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.IRONORE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.METALPARTS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
        case RESOURCES.POWDER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
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
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.WAX:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.TOBACCO:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.AMBER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.18);
        case RESOURCES.CLOTH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
      }
    }).toList();
  }
}
