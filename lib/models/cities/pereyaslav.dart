import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          prices: Price([
            PriceUnit.wood.adjustToModifier(1),
            PriceUnit.stone.adjustToModifier(1.1),
            PriceUnit.planks.adjustToModifier(1.1),
            PriceUnit.firearm.adjustToModifier(1.4),
            PriceUnit.horse.adjustToModifier(1),
            PriceUnit.cannon.adjustToModifier(1.5),
            PriceUnit.food.adjustToModifier(0.8),
            PriceUnit.charcoal.adjustToModifier(1.1),
            PriceUnit.fish.adjustToModifier(0.9),
            PriceUnit.fur.adjustToModifier(0.9),
            PriceUnit.grains.adjustToModifier(0.8),
            PriceUnit.ironOre.adjustToModifier(1.5),
            PriceUnit.metalParts.adjustToModifier(1.3),
            PriceUnit.powder.adjustToModifier(1.1),
          ]),
          stock: Stock([
            Food(1000),
            Stone(1000),
            Cannon(3),
            Grains(1000),
            Fur(100),
            Planks(500),
            Wood(1000),
            MetalParts(100),
            Firearm(40),
          ]),
        );
}
