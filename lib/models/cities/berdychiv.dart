import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/resources/resource.dart';

class Berdychiv extends City {
  Berdychiv()
      : super(
          point: Point(3500, 2500),
          name: "Бердичів",
          unlocked: false,
          localizedKeyName: 'berdychiv',
          unlockPriceMoney: Money(250),
          size: 2,
          unlocksCities: [Vinnitsa()],
          // produces: [IronOre(1)],
          manufacturings: [],
          stock: Stock([
            Bread(1000),
            Grains(1000),
            MetalParts(300),
            Firearm(150),
            Wool(450),
            Fish(450),
            IronOre(800),
          ]),
        );
}
