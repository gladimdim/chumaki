import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Uman extends City {
  Uman()
      : super(
          point: Point(3050, 1750),
          name: "Умань",
          unlocked: false,
          localizedKeyName: 'uman',
          size: 3,
          unlocksCities: [Gaivoron()],
          manufacturings: [Distillery()],
          unlockPriceMoney: Money(300),
          stock: Stock([
            Bread(1300),
            Stone(1000),
            Cannon(5),
            Grains(1000),
            Fur(100),
            Wool(800),
            Gorilka(600),
            Horse(100),
          ]),
        );
}
