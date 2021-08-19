import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/uman.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Korsun extends City {
  Korsun()
      : super(
          point: Point(2550, 1920),
          unlocked: false,
          localizedKeyName: 'korsun',
          size: 2,
          unlocksCities: [Uman()],
          unlockPriceMoney: Money(400),
          manufacturings: [Distillery()],
          stock: Stock([
            Bread(40),
            Grains(30),
            Fur(20),
            Wool(40),
            Gorilka(250),
            Horse(8),
          ]),
        );
}
