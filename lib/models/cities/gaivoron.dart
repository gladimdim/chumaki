import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Gaivoron extends City {
  Gaivoron()
      : super(
          point: Point(3300, 1650),
          unlocked: false,
          localizedKeyName: 'gaivoron',
          size: 2,
          unlocksCities: [],
          unlockPriceMoney: Money(250),
          manufacturings: [],
          stock: Stock([
            Stone(50),
            Grains(50),
            Planks(60),
            Wood(20),
            Wax(20),
            Wood(50),
            Powder(30),
          ]),
        );
}
