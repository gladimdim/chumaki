import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ladyzhin extends City {
  Ladyzhin()
      : super(
    point: Point(3450, 1750),
    name: "Ладижин",
    unlocked: false,
    localizedKeyName: 'ladyzhin',
    size: 2,
    unlocksCities: [Gaivoron()],
    produces: [],
    unlockPriceMoney: Money(150),
    stock: Stock([
      Bread(500),
      Grains(800),
      MetalParts(100),
      Wax(500),
    ]),
  );
}
