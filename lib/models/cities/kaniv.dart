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
            Bread(50),
            Stone(20),
            Firearm(5),
            Powder(45),
            Grains(20),
            Fish(60),
            Planks(25),
            IronOre(50),
            Charcoal(20),
            MetalParts(10),
            Salt(20),
            Silk(10),
            Wool(60),
            Tobacco(10),
          ]),
        );
}
