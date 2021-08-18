import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ohtirka extends City {
  Ohtirka()
      : super(
    point: Point(1150, 2250),
    localizedKeyName: 'ohtirka',
    size: 1.5,
    unlocked: false,
    unlockPriceMoney: Money(500),
    unlocksCities: [],
    manufacturings: [TobaccoMaker()],
    stock: Stock(
      [
        Wood(50),
        Horse(100),
        Fur(150),
        Wool(100),
        Gorilka(150),
        Wax(200),
        Honey(400),
        Tobacco(800),
        Planks(50),
      ],
    ),
    wagons: [],
  );
}
