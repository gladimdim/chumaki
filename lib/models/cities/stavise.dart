import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Stavise extends City {
  Stavise()
      : super(
          point: Point(2950, 2100),
          name: "Ставище",
          unlocked: true,
          localizedKeyName: 'stavise',
          size: 2,
          unlocksCities: [],
          manufacturings: [],
          stock: Stock([
            Bread(500),
            Stone(300),
            Cannon(5),
            Grains(800),
            Planks(500),
            Wood(1000),
            IronOre(300),
            MetalParts(100),
            Wax(500),
          ]),
        );
}
