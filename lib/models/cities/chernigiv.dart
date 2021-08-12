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
              Wood(500),
              Planks(500),
              Fur(500),
              Wool(100),
              Gorilka(450),
              Wax(200),
              Honey(200),
              Charcoal(500),
              Amber(100),
            ],
          ),
          wagons: [],
        );
}
