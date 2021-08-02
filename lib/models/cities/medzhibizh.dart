import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Medzhibizh extends City {
  Medzhibizh()
      : super(
    point: Point(3950, 2300),
    name: "Меджибіж",
    localizedKeyName: 'medzhibizh',
    size: 1,
    unlocked: false,
    unlockPriceMoney: Money(150.0),
    unlocksCities: [],
    manufacturings: [],
    stock: Stock(
      [
        MetalParts(100),
        Firearm(250),
        Honey(100),
        Gorilka(250),
        Stone(600),
      ],
    ),
    wagons: [],
  );
}
