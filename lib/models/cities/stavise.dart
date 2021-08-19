import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Stavise extends City {
  Stavise()
      : super(
          point: Point(2950, 2100),
          unlocked: true,
          localizedKeyName: 'stavise',
          size: 2,
          unlocksCities: [],
          manufacturings: [],
          stock: Stock([
            Bread(100),
            Stone(30),
            Grains(80),
            Planks(50),
            Wood(30),
            IronOre(15),
            MetalParts(10),
            Wax(30),
          ]),
        );
}
