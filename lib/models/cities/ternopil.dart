import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/lviv.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ternopil extends City {
  Ternopil()
      : super(
          point: Point(4550, 2400),
          localizedKeyName: 'ternopil',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(500.0),
          unlocksCities: [Lviv()],
          manufacturings: [Smith()],
          stock: Stock(
            [
              MetalParts(80),
              Firearm(105),
              Honey(10),
              Tobacco(5),
              Charcoal(30),
              Bread(90),
            ],
          ),
          wagons: [],
        );
}
