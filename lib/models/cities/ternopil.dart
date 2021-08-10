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
      name: "Тернопіль",
      localizedKeyName: 'ternopil',
      size: 2,
      unlocked: false,
      unlockPriceMoney: Money(150.0),
      unlocksCities: [Lviv()],
      manufacturings: [Smith()],
      stock: Stock(
        [
          MetalParts(800),
          Firearm(200),
          Honey(100),
          Tobacco(50),
          Charcoal(100),
          Bread(200),
        ],
      ),
      wagons: [],
   );
}
