import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Temryuk extends City {
  Temryuk()
      : super(
          point: Point(600, 300),
          name: "Темрюк",
          localizedKeyName: 'temryuk',
          size: 2,
          unlocked: false,
          unlocksCities: [],
          manufacturings: [SilkMarket()],
          unlockPriceMoney: Money(50),
          stock: Stock(
            [
              Fish(3500),
              Salt(2000),
              Silk(500),
              Tobacco(300),
            ],
          ),
        );
}
