import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/medzhibizh.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Vinnitsa extends City {
  Vinnitsa()
      : super(
          point: Point(3550, 2150),
          unlocked: false,
          localizedKeyName: 'vinnitsa',
          unlockPriceMoney: Money(750),
          size: 3,
          unlocksCities: [Ladyzhin(), Medzhibizh()],
          manufacturings: [Smith(), Quarry()],
          stock: Stock([
            Bread(800),
            Cannon(30),
            Grains(400),
            MetalParts(100),
            Firearm(300),
            Wool(150),
            Stone(500),
          ]),
        );
}
