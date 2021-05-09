import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          size: 2,
          name: "Чигирин",
          localizedKeyName: 'chigirin',
          prices: Price(Chigirin.generatePriceUnits()),
          unlocked: true,
          unlocksCities: [],
          stock: Stock([
            Bread(2000),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
            IronOre(100),
            Cannon(50),
            MetalParts(200),
            Salt(300),
            Wool(100),
            Gorilka(500),
            Wax(1000),
            Honey(800),
          ]),
        );


  Money unlockPriceMoney = Money(0);

  static List<PriceUnit> generatePriceUnits() {
    return RESOURCES.values.map<PriceUnit>((resType) {
      switch (resType) {
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.WOOD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.STONE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.PLANKS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
        case RESOURCES.FIREARM:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.8);
        case RESOURCES.HORSE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.CANNON:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
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
              .adjustToModifier(1.3);
        case RESOURCES.IRONORE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.METALPARTS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.POWDER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.SALT:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.1);
        case RESOURCES.SILK:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2.1);
        case RESOURCES.WOOL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.2);
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
              .adjustToModifier(1.1);
        case RESOURCES.AMBER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.22);
        case RESOURCES.CLOTH:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
      }
    }).toList();
  }
}
