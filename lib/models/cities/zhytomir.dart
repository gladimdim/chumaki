import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/resources/resource.dart';

class Zhytomir extends City {
  Zhytomir()
      : super(
          point: Point(3300, 3000),
          name: "Житомир",
          localizedKeyName: 'zhytomir',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(200.0),
          // manufacturings: [Bread(1), Grains(1), Amber(1)],
          unlocksCities: [
            Ostrog(),
            Berdychiv(),
          ],
          stock: Stock(
            [
              Grains(1000),
              Wood(1500),
              Planks(1500),
              Fur(50),
              Wool(50),
              Wax(100),
              Amber(1800),
              Firearm(100),
              Bread(1000),
              Horse(50),
              MetalParts(300),
            ],
          ),
          wagons: [],
        );
}
