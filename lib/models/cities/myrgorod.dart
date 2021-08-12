import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/pyryatin.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Myrgorod extends City {
  Myrgorod()
      : super(
          point: Point(1650, 2200),
          name: "Миргород",
          localizedKeyName: 'myrgorod',
          size: 2,
          unlocked: false,
          unlocksCities: [Pyryatin()],
          unlockPriceMoney: Money(100),
          manufacturings: [Pasture()],
          stock: Stock(
            [
              Wood(200),
              Horse(10),
              Fur(100),
              Wool(800),
              Gorilka(50),
              Amber(50),
              Firearm(50),
              Cloth(50),
            ],
          ),
          wagons: [],
        );
}
