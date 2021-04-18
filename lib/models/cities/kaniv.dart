import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';

class Kaniv extends City {
  Kaniv()
      : super(
    point: Point(2400, 2200),
    name: "Канів",
    prices: Price(
      [
        PriceUnit.wood.adjustToModifier(1.5),
        PriceUnit.stone.adjustToModifier(0.8),
        PriceUnit.planks.adjustToModifier(1.5),
        PriceUnit.firearm.adjustToModifier(1.7),
        PriceUnit.horse.adjustToModifier(0.8),
        PriceUnit.cannon.adjustToModifier(1.5),
        PriceUnit.food.adjustToModifier(1),
        PriceUnit.charcoal.adjustToModifier(1.2),
        PriceUnit.fish.adjustToModifier(0.7),
        PriceUnit.fur.adjustToModifier(0.7),
        PriceUnit.grains.adjustToModifier(1.1),
        PriceUnit.ironOre.adjustToModifier(1.5),
        PriceUnit.metalParts.adjustToModifier(1.3),
        PriceUnit.powder.adjustToModifier(0.9),
      ]
    ),
    stock: Stock([
      Food(2000),
      Stone(300),
      Firearm(500),
      Powder(1000),
      Grains(3000),
      Horse(200),
      Fish(2500),
      Planks(500),
      IronOre(50),
      Cannon(3),
      Charcoal(200),
      MetalParts(100),

      Horse(400),
    ]),
  );
}