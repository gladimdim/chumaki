import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';

class Kyiv extends City {
  Kyiv()
      : super(
          point: Point(2700, 2830),
          name: "Київ",
          prices: Price([
            PriceUnit.wood.adjustToModifier(0.7),
            PriceUnit.stone.adjustToModifier(1.2),
            PriceUnit.planks.adjustToModifier(0.7),
            PriceUnit.firearm.adjustToModifier(1.2),
            PriceUnit.horse.adjustToModifier(1.7),
            PriceUnit.cannon.adjustToModifier(1.3),
            PriceUnit.bread.adjustToModifier(0.6),
            PriceUnit.charcoal.adjustToModifier(0.7),
            PriceUnit.fish.adjustToModifier(1.3),
            PriceUnit.fur.adjustToModifier(1.4),
            PriceUnit.grains.adjustToModifier(1.3),
            PriceUnit.ironOre.adjustToModifier(1.4),
            PriceUnit.metalParts.adjustToModifier(1.3),
            PriceUnit.powder.adjustToModifier(1.3),
          ]),
          stock: Stock([
            Wood(1000),
            Horse(200),
            Bread(20000),
            Stone(300),
            Firearm(700),
            Powder(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
            IronOre(300),
            Cannon(100),
            MetalParts(400),
            Fur(200),
            Fish(1000),
          ]),
        );
}
