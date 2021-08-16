import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Kaniv extends City {
  Kaniv()
      : super(
          point: Point(2400, 2200),
          localizedKeyName: 'kaniv',
          size: 2,
          unlocked: true,
          unlocksCities: [],
          manufacturings: [Stables(), TrappersHouse()],
          stock: Stock([
            Horse(250),
            Fur(300),
            Bread(350),
            Stone(200),
            Firearm(50),
            Powder(450),
            Grains(200),
            Fish(600),
            Planks(250),
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
