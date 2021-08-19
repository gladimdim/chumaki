import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Pyryatin extends City {
  Pyryatin()
      : super(
          point: Point(1900, 2450),
          localizedKeyName: 'pyryatin',
          size: 2,
          unlocked: false,
          unlocksCities: [Nizhin()],
          unlockPriceMoney: Money(150),
          manufacturings: [Forest()],
          stock: Stock(
            [
              Wood(320),
              Horse(3),
              Fur(10),
              Wool(20),
              Gorilka(10),
              Wax(30),
              Honey(10),
              Tobacco(20),
            ],
          ),
          wagons: [],
        );
}
