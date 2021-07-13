import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          unlocked: true,
          localizedKeyName: 'pereyaslav',
          size: 2,
          unlocksCities: [Kyiv()],
          manufacturings: [Stables(), HoneyMaker()],
          stock: Stock([
            Bread(1000),
            Stone(1000),
            Cannon(3),
            Grains(1000),
            Fur(100),
            Planks(500),
            Wood(1000),
            MetalParts(100),
            Firearm(40),
            Salt(150),
            Wool(150),
            Honey(500),
            Wax(500),
          ]),
        );
}
