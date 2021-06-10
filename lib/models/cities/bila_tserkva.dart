import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class BilaTserkva extends City {
  BilaTserkva()
      : super(
          point: Point(2700, 2300),
          name: "Біла Церква",
          unlocked: true,
          localizedKeyName: 'bilatserkva',
          size: 2,
          unlocksCities: [],
          produces: [],
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
