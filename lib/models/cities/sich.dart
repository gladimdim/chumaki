import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          prices: Price([
            PriceUnit.wood.adjustToModifier(1.4),
            PriceUnit.stone.adjustToModifier(0.7),
            PriceUnit.planks.adjustToModifier(1.4),
            PriceUnit.firearm.adjustToModifier(2),
            PriceUnit.horse.adjustToModifier(0.6),
            PriceUnit.cannon.adjustToModifier(1.5),
            PriceUnit.food.adjustToModifier(0.8),
            PriceUnit.charcoal.adjustToModifier(1.1),
            PriceUnit.fish.adjustToModifier(0.5),
            PriceUnit.fur.adjustToModifier(0.6),
            PriceUnit.grains.adjustToModifier(1.4),
            PriceUnit.ironOre.adjustToModifier(2),
            PriceUnit.metalParts.adjustToModifier(2),
            PriceUnit.powder.adjustToModifier(0.6),
          ]),
          stock: Stock(
            [
              Powder(1000),
              Fish(1500),
              Horse(300),
              Fur(1500),
            ],
          ),
          wagons: [
            Wagon(
                name: "Татарина",
                stock: Stock([
                  Charcoal(20),
                  IronOre(10),
                ])),
            Wagon(
                name: "Остапа",
                stock: Stock([
                  Powder(20),
                  MetalParts(10),
                ])),
            Wagon(
              name: "Дмитра",
              stock: Stock(
                [
                  Grains(100),
                  Fish(250),
                ],
              ),
            ),
          ],
        );
}
