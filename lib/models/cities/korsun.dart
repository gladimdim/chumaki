import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/uman.dart';
import 'package:chumaki/models/resources/resource.dart';

class Korsun extends City {
  Korsun()
      : super(
          point: Point(2550, 1920),
          name: "Корсунь",
          unlocked: false,
          localizedKeyName: 'korsun',
          size: 2,
          unlocksCities: [Uman()],
          unlockPriceMoney: Money(150),
          // manufacturings: [Gorilka(1)],
          stock: Stock([
            Bread(1300),
            Grains(1000),
            Fur(300),
            Wool(1800),
            Gorilka(300),
            Horse(200),
          ]),
        );
}
