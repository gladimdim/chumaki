import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/resources/resource.dart';

class Vinnitsa extends City {
  Vinnitsa()
      : super(
          point: Point(3550, 2150),
          name: "Вінниця",
          unlocked: false,
          localizedKeyName: 'vinnitsa',
          unlockPriceMoney: Money(150),
          size: 3,
          unlocksCities: [Ladyzhin()],
          produces: [Firearm(1), Stone(1)],
          stock: Stock([
            Bread(1000),
            Cannon(30),
            Grains(1000),
            MetalParts(100),
            Firearm(100),
            Wool(150),
          ]),
        );
}
