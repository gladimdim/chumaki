import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Chernigiv extends City {
  Chernigiv()
      : super(
          point: Point(2200, 3400),
          localizedKeyName: 'chernigiv',
          size: 3,
          unlocked: false,
          unlockPriceMoney: Money(500.0),
          manufacturings: [Forest(), CharcoalMaker(), Sawmill()],
          unlocksCities: [],
          stock: Stock(
            [
              Wood(250),
              Planks(250),
              Fur(30),
              Wool(10),
              Gorilka(20),
              Wax(20),
              Honey(20),
              Charcoal(200),
              Amber(30),
            ],
          ),
          wagons: [],
        );
}
