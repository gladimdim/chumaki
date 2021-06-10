import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';

class Nizhin extends City {
  Nizhin()
      : super(
          point: Point(1950, 2950),
          name: "Ніжин",
          size: 3,
          localizedKeyName: 'nizhin',
          unlocked: false,
          unlocksCities: [],
          unlockPriceMoney: Money(200),
          produces: [Cloth(1)],
          stock: Stock(
            [
              Grains(2000),
              Wood(800),
              Horse(50),
              Powder(100),
              Fur(400),
              Planks(400),
              Stone(50),
              Fish(100),
              Cannon(10),
              Salt(200),
              Wool(100),
              Amber(300),
            ],
          ),
        );

  Money unlockPriceMoney = Money(200);
}
