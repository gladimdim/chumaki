import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ternopil.dart';
import 'package:chumaki/models/resources/resource.dart';

class Medzhibizh extends City {
  Medzhibizh()
      : super(
    point: Point(3950, 2300),
    name: "Меджибіж",
    localizedKeyName: 'medzhibizh',
    size: 2,
    unlocked: false,
    unlockPriceMoney: Money(150.0),
    unlocksCities: [Ternopil()],
    manufacturings: [],
    stock: Stock(
      [
        MetalParts(100),
        Firearm(100),
        Honey(100),
        Gorilka(180),
        Stone(180),
      ],
    ),
    wagons: [],
  );
}
