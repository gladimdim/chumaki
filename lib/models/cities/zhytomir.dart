import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Zhytomir extends City {
  Zhytomir()
      : super(
    point: Point(3300, 3000),
    name: "Житомир",
    localizedKeyName: 'zhytomir',
    size: 2,
    unlocked: false,
    unlockPriceMoney: Money(200.0),
    unlocksCities: [Ostrog(), Berdychiv()],
    prices: Price(Zhytomir.generatePriceUnits()),
    stock: Stock(
      [
        Wood(1500),
        Planks(1500),
        Fur(50),
        Wool(50),
        Wax(100),
        Amber(1800),
        Firearm(100),
        Bread(500),
        Horse(50),
        MetalParts(300),
      ],
    ),
    wagons: [],
  );

  static List<PriceUnit> generatePriceUnits() {
    return RESOURCES.values.map<PriceUnit>((resType) {
      switch (resType) {
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.05);
        case RESOURCES.WOOD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.STONE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.PLANKS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.FIREARM:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.05);
        case RESOURCES.HORSE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.CANNON:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.CHARCOAL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.9);
        case RESOURCES.FISH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.6);
        case RESOURCES.FUR:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
        case RESOURCES.GRAINS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.IRONORE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.METALPARTS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.POWDER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.SALT:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.9);
        case RESOURCES.SILK:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.8);
        case RESOURCES.WOOL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.GORILKA:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.25);
        case RESOURCES.HONEY:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.WAX:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
        case RESOURCES.TOBACCO:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.6);
        case RESOURCES.AMBER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.75);
        case RESOURCES.CLOTH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.05);
      }
    }).toList();
  }
}
