import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Kursk extends City {
  Kursk()
      : super(
          point: Point(300, 3500),
          size: 3,
          localizedKeyName: 'kursk',
          unlocked: false,
          unlocksCities: [],
          unlockPriceMoney: Money(500),
          manufacturings: [TrappersHouse()],
          stock: Stock(
            [
              Fur(200),
              Wax(20),
              Grains(20),
              Wood(50),
              Horse(5),
              Powder(15),
              Planks(15),
              Stone(20),
              Fish(10),
              Cloth(80),
              Wool(30),
            ],
          ),
        );
}
