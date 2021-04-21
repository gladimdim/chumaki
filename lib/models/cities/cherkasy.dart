import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';

class Cherkasy extends City {
  Cherkasy()
      : super(
          point: Point(2250, 2000),
          imagePath: "images/cities/church.png",
          name: "Черкаси",
          size: 2,
          prices: Price(
            [
              PriceUnit.wood.adjustToModifier(1),
              PriceUnit.stone.adjustToModifier(1.1),
              PriceUnit.planks.adjustToModifier(1),
              PriceUnit.firearm.adjustToModifier(1.2),
              PriceUnit.horse.adjustToModifier(1.05),
              PriceUnit.cannon.adjustToModifier(1.5),
              PriceUnit.bread.adjustToModifier(1),
              PriceUnit.charcoal.adjustToModifier(1.05),
              PriceUnit.fish.adjustToModifier(1),
              PriceUnit.fur.adjustToModifier(1.02),
              PriceUnit.grains.adjustToModifier(1.3),
              PriceUnit.ironOre.adjustToModifier(1.5),
              PriceUnit.metalParts.adjustToModifier(1.3),
              PriceUnit.powder.adjustToModifier(0.8),
            ],
          ),
          stock: Stock([
            Bread(200),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Fish(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
          ]),
          wagons: [
            Wagon(name: "Вальків", stock: Stock([Bread(10), Wood(30)])),
            Wagon(name: "Харченка", stock: Stock([Firearm(5), Stone(15)])),
            Wagon(
                name: "Підлісного",
                stock: Stock([Fur(30), Charcoal(25), Fish(15)])),
            Wagon(
                name: "Мітрась",
                stock: Stock([Horse(5), Powder(25), IronOre(20)])),
          ],
        );
}
