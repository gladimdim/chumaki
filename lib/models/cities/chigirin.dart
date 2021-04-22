import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          size: 2,
          name: "Чигирин",

    localizedKeyName: 'chigirin',
          prices: Price([
            PriceUnit.wood.adjustToModifier(1.2),
            PriceUnit.stone.adjustToModifier(0.8),
            PriceUnit.planks.adjustToModifier(1.2),
            PriceUnit.firearm.adjustToModifier(1.8),
            PriceUnit.horse.adjustToModifier(0.7),
            PriceUnit.cannon.adjustToModifier(1.5),
            PriceUnit.bread.adjustToModifier(1),
            PriceUnit.charcoal.adjustToModifier(1.1),
            PriceUnit.fish.adjustToModifier(0.9),
            PriceUnit.fur.adjustToModifier(0.9),
            PriceUnit.grains.adjustToModifier(1.3),
            PriceUnit.ironOre.adjustToModifier(2),
            PriceUnit.metalParts.adjustToModifier(2),
            PriceUnit.powder.adjustToModifier(1.1),
          ]),
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
          ]),
        );
}
