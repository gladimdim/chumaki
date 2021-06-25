import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/nizhin.dart';
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
          produces: [Wood(1)],
          stock: Stock(
            [
              Wood(1500),
              Horse(30),
              Fur(100),
              Wool(200),
              Gorilka(50),
              Wax(300),
              Honey(1500),
              Tobacco(800),
            ],
          ),
          wagons: [],
        );
}
