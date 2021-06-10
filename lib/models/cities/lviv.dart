import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Lviv extends City {
  Lviv()
      : super(
          point: Point(4800, 2400),
          name: "Львів",
          localizedKeyName: 'lviv',
          size: 6,
          unlocked: false,
          unlockPriceMoney: Money(1250.0),
          unlocksCities: [],
          produces: [Cannon(1), Firearm(1)],
          stock: Stock(
            [
              Wood(2500),
              Planks(2500),
              Fur(500),
              Wool(500),
              Wax(1000),
              Amber(800),
              Cannon(300),
              Firearm(500),
              Silk(500),
            ],
          ),
          wagons: [],
        );
}
