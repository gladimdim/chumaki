import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Temryuk extends City {
  Temryuk()
      : super(
          point: Point(600, 300),
          localizedKeyName: 'temryuk',
          size: 2,
          unlocked: false,
          unlocksCities: [],
          manufacturings: [SilkMarket()],
          unlockPriceMoney: Money(500),
          stock: Stock(
            [
              Fish(350),
              Salt(100),
              Silk(230),
              Tobacco(120),
            ],
          ),
        );
}
