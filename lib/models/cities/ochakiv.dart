import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/temryuk.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ochakiv extends City {
  Ochakiv()
      : super(
          point: Point(2400, 700),
          name: "Очаків",
          localizedKeyName: 'ochakiv',
          size: 2,
          unlocked: false,
          unlocksCities: [Temryuk()],
          unlockPriceMoney: Money(50),
          produces: [Fish(1), Salt(1), Tobacco(1)],
          stock: Stock(
            [
              Powder(1000),
              Fish(1500),
              Salt(2000),
              Silk(300),
              Tobacco(2000),
            ],
          ),
        );
}
