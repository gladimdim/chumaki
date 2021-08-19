import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ohtirka.dart';
import 'package:chumaki/models/cities/pyryatin.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Myrgorod extends City {
  Myrgorod()
      : super(
          point: Point(1650, 2200),
          localizedKeyName: 'myrgorod',
          size: 2,
          unlocked: false,
          unlocksCities: [Pyryatin(), Ohtirka()],
          unlockPriceMoney: Money(500),
          manufacturings: [Pasture()],
          stock: Stock(
            [
              Wood(20),
              Horse(5),
              Fur(10),
              Wool(220),
              Gorilka(50),
              Amber(25),
              Firearm(5),
              Cloth(25),
            ],
          ),
          wagons: [],
        );
}
