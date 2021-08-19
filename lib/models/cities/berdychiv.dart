import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Berdychiv extends City {
  Berdychiv()
      : super(
          point: Point(3500, 2500),
          unlocked: false,
          localizedKeyName: 'berdychiv',
          unlockPriceMoney: Money(250),
          size: 2,
          unlocksCities: [Vinnitsa()],
          manufacturings: [IronMine()],
          stock: Stock([
            Bread(50),
            Grains(150),
            MetalParts(50),
            Firearm(10),
            Wool(30),
            Fish(50),
            IronOre(150),
          ]),
        );
}
