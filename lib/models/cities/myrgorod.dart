import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/pyryatin.dart';
import 'package:chumaki/models/resources/resource.dart';

class Myrgorod extends City {
  Myrgorod()
      : super(
    point: Point(1700, 2250),
    name: "Миргород",
    localizedKeyName: 'myrgorod',
    size: 2,
    unlocked: false,
    unlocksCities: [Pyryatin()],
    unlockPriceMoney: Money(100),
    produces: [Wool(1)],
    stock: Stock(
      [
        Wood(500),
        Horse(10),
        Fur(100),
        Wool(2000),
        Gorilka(50),
        Amber(50),
        Firearm(50),
        Cloth(50),
      ],
    ),
    wagons: [],
  );
}
