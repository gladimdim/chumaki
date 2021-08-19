import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ladyzhin extends City {
  Ladyzhin()
      : super(
          point: Point(3450, 1750),
          unlocked: false,
          localizedKeyName: 'ladyzhin',
          size: 2,
          unlocksCities: [Gaivoron()],
          manufacturings: [],
          unlockPriceMoney: Money(250),
          stock: Stock([
            Bread(40),
            Grains(30),
            MetalParts(10),
            Wax(10),
          ]),
        );
}
