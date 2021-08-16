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
          unlockPriceMoney: Money(150),
          manufacturings: [Distillery()],
          stock: Stock([
            Bread(400),
            Grains(380),
            Fur(250),
            Wool(400),
            Gorilka(450),
            Horse(80),
          ]),
        );
}
