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
          name: "Пирятин",
          localizedKeyName: 'pyryatin',
          size: 2,
          unlocked: false,
          unlocksCities: [Nizhin()],
          unlockPriceMoney: Money(100),
          manufacturings: [Forest()],
          stock: Stock(
            [
              Wood(1100),
              Horse(30),
              Fur(100),
              Wool(200),
              Gorilka(50),
              Wax(300),
              Honey(100),
              Tobacco(120),
            ],
          ),
          wagons: [],
        );
}
