import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Kaniv extends City {
  Kaniv()
      : super(
          point: Point(2400, 2200),
          name: "Канів",
          localizedKeyName: 'kaniv',
          size: 2,
          unlocked: true,
          unlocksCities: [],
          // manufacturings: [Horse(1), Fur(1)],
          stock: Stock([
            Horse(500),
            Fur(500),
            Bread(2000),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Grains(3000),
            Horse(200),
            Fish(2500),
            Planks(500),
            IronOre(50),
            Cannon(3),
            Charcoal(200),
            MetalParts(100),
            Salt(200),
            Silk(50),
            Wool(100),
            Tobacco(100),
          ]),
        );
}
