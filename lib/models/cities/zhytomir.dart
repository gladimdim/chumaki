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
              Grains(1000),
              Wood(450),
              Planks(500),
              Fur(50),
              Wool(50),
              Wax(100),
              Amber(900),
              Firearm(100),
              Bread(800),
              Horse(50),
              MetalParts(300),
            ],
          ),
          wagons: [],
        );
}
