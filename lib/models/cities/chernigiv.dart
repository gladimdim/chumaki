import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Chernigiv extends City {
  Chernigiv()
      : super(
          point: Point(2200, 3400),
          name: "Чернігів",
          localizedKeyName: 'chernigiv',
          size: 3,
          unlocked: false,
          unlockPriceMoney: Money(250.0),
          manufacturings: [Forest(), CharcoalMaker(), Sawmill()],
          unlocksCities: [],
          stock: Stock(
            [
              Wood(1500),
              Planks(1500),
              Fur(500),
              Wool(100),
              Gorilka(450),
              Wax(1000),
              Honey(500),
              Charcoal(800),
              Amber(800),
            ],
          ),
          wagons: [],
        );
}
