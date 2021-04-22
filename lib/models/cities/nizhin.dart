import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';

class Nizhin extends City {
  Nizhin()
      : super(
          point: Point(1950, 2950),
          name: "Ніжин",
          size: 3,

    localizedKeyName: 'nizhin',
          prices: Price(
            [
              PriceUnit.wood.adjustToModifier(0.7),
              PriceUnit.stone.adjustToModifier(1),
              PriceUnit.planks.adjustToModifier(0.9),
              PriceUnit.firearm.adjustToModifier(1.2),
              PriceUnit.horse.adjustToModifier(1.3),
              PriceUnit.cannon.adjustToModifier(1.2),
              PriceUnit.bread.adjustToModifier(0.7),
              PriceUnit.charcoal.adjustToModifier(0.9),
              PriceUnit.fish.adjustToModifier(1.4),
              PriceUnit.fur.adjustToModifier(1.02),
              PriceUnit.grains.adjustToModifier(0.7),
              PriceUnit.ironOre.adjustToModifier(1),
              PriceUnit.metalParts.adjustToModifier(1.1),
              PriceUnit.powder.adjustToModifier(1.6),
            ],
          ),
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
            ],
          ),
        );
}
