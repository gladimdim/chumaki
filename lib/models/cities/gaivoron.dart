import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Gaivoron extends City {
  Gaivoron()
      : super(
          point: Point(3300, 1650),
          name: "Гайворон",
          unlocked: false,
          localizedKeyName: 'gaivoron',
          size: 2,
          unlocksCities: [],
          unlockPriceMoney: Money(50),
          manufacturings: [],
          stock: Stock([
            Stone(800),
            Grains(800),
            Planks(500),
            Wood(1000),
            Wax(500),
            Wood(300),
            Powder(120),
          ]),
        );
}
