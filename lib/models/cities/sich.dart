import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          localizedKeyName: 'sich',
          size: 4,
          prices: Price(Sich.generatePriceUnits()),
          stock: Stock(
            [
              Powder(1000),
              Fish(1500),
              Horse(300),
              Fur(1500),
              Salt(2000),
              Wool(100),
              Silk(300),
              Gorilka(450),
              Wax(3000),
              Honey(1500),
              Tobacco(500),
            ],
          ),
          wagons: [
            // Wagon(
            //     localizedNameKey: "company.tartar",
            //     stock: Stock([
            //       Charcoal(20),
            //       // IronOre(10),
            //     ])),
            // Wagon(
            //     localizedNameKey: "company.ostapa",
            //     stock: Stock([
            //       Powder(20),
            //       MetalParts(10),
            //     ])),
            Wagon(
              localizedNameKey: "company.gladkyi",
              stock: Stock(
                [
                  Grains(50),
                  Fish(50),
                ],
              ),
            ),
          ],
        );

  static List<PriceUnit> generatePriceUnits() {
    return RESOURCES.values.map<PriceUnit>((resType) {
      switch (resType) {
        case RESOURCES.BREAD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.8);
        case RESOURCES.WOOD:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.STONE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.7);
        case RESOURCES.PLANKS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.FIREARM:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.HORSE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.6);
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
              .adjustToModifier(0.5);
        case RESOURCES.FUR:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.6);
        case RESOURCES.GRAINS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.4);
        case RESOURCES.IRONORE:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.METALPARTS:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.POWDER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.6);
        case RESOURCES.SALT:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1);
        case RESOURCES.SILK:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(2);
        case RESOURCES.WOOL:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.3);
        case RESOURCES.GORILKA:
          return PriceUnit.defaultPriceUnitForResourceType(resType).adjustToModifier(1);
        case RESOURCES.HONEY:
          return PriceUnit.defaultPriceUnitForResourceType(resType).adjustToModifier(0.9);
        case RESOURCES.WAX:
          return PriceUnit.defaultPriceUnitForResourceType(resType).adjustToModifier(0.9);
        case RESOURCES.TOBACCO:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(0.85);
        case RESOURCES.AMBER:
          return PriceUnit.defaultPriceUnitForResourceType(resType)
              .adjustToModifier(1.5);
      }
    }).toList();
  }
}
