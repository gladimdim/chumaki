import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Kursk extends City {
  Kursk()
      : super(
          point: Point(300, 3500),
          name: "Курськ",
          size: 3,
          localizedKeyName: 'kursk',
          unlocked: false,
          unlocksCities: [],
          unlockPriceMoney: Money(500),
          produces: [Fur(1)],
          stock: Stock(
            [
              Fur(1500),
              Wax(1000),
              Grains(500),
              Wood(500),
              Horse(50),
              Powder(150),
              Planks(150),
              Stone(50),
              Fish(100),
              Cloth(200),
              Wool(100),
            ],
          ),
        );
}
