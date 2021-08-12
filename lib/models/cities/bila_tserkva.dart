import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/resources/resource.dart';

class BilaTserkva extends City {
  BilaTserkva()
      : super(
          point: Point(2700, 2300),
          name: "Біла Церква",
          unlocked: true,
          localizedKeyName: 'bilatserkva',
          size: 2,
          unlocksCities: [Kyiv()],
          manufacturings: [],
          stock: Stock([
            Bread(400),
            Stone(100),
            Cannon(15),
            Grains(400),
            Fur(100),
            Planks(400),
            Wood(400),
            MetalParts(50),
            Firearm(40),
            Salt(150),
            Wool(150),
            Honey(300),
            Wax(300),
          ]),
        );
}
