import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/resources/resource.dart';

class BilaTserkva extends City {
  BilaTserkva()
      : super(
          point: Point(2700, 2300),
          unlocked: true,
          localizedKeyName: 'bilatserkva',
          size: 2,
          unlocksCities: [Kyiv()],
          manufacturings: [],
          stock: Stock([
            Bread(20),
            Stone(10),
            Cannon(1),
            Grains(20),
            Fur(30),
            Planks(20),
            Wood(20),
            MetalParts(10),
            Firearm(40),
            Salt(10),
            Wool(10),
            Honey(20),
            Wax(20),
          ]),
        );
}
