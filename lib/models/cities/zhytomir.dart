import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Zhytomir extends City {
  Zhytomir()
      : super(
          point: Point(3300, 3000),
          localizedKeyName: 'zhytomir',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(1000.0),
          manufacturings: [Bakery(), Field(), AmberMine()],
          unlocksCities: [
            Ostrog(),
            Berdychiv(),
          ],
          stock: Stock(
            [
              Grains(400),
              Wood(45),
              Planks(50),
              Fur(25),
              Wool(50),
              Wax(10),
              Amber(110),
              Firearm(10),
              Bread(320),
              Horse(5),
              MetalParts(30),
            ],
          ),
          wagons: [],
        );
}
