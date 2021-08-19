import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kursk.dart';
import 'package:chumaki/models/resources/resource.dart';

class Rylsk extends City {
  Rylsk()
      : super(
          point: Point(880, 3050),
          size: 3,
          localizedKeyName: 'rylsk',
          unlocked: false,
          unlocksCities: [Kursk()],
          unlockPriceMoney: Money(50),
          manufacturings: [],
          stock: Stock(
            [
              Fur(15),
              Wax(10),
              Grains(60),
              Wood(80),
              Horse(5),
              Wool(50),
            ],
          ),
        );
}
