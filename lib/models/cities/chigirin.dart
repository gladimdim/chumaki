import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          size: 2,
          name: "Чигирин",
          localizedKeyName: 'chigirin',
          unlocked: true,
          produces: [Wool(1)],
          unlocksCities: [],
          stock: Stock([
            Bread(2000),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
            IronOre(100),
            Cannon(50),
            MetalParts(200),
            Salt(300),
            Wool(100),
            Gorilka(500),
            Wax(1000),
            Honey(800),
          ]),
        );

  Money unlockPriceMoney = Money(0);
}
