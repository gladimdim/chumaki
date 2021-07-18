import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kursk.dart';
import 'package:chumaki/models/resources/resource.dart';

class Rylsk extends City {
  Rylsk()
      : super(
          point: Point(880, 3050),
          name: "Рильськ",
          size: 3,
          localizedKeyName: 'rylsk',
          unlocked: false,
          unlocksCities: [Kursk()],
          unlockPriceMoney: Money(50),
          manufacturings: [],
          stock: Stock(
            [
              Fur(800),
              Wax(100),
              Grains(200),
              Wood(200),
              Horse(10),
              Wool(50),
            ],
          ),
        );
}
