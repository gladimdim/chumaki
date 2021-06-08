import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'lviv.dart';

class Ostrog extends City {
  Ostrog()
      : super(
          point: Point(4100, 2800),
          name: "Острог",
          localizedKeyName: 'ostrog',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(200.0),
          unlocksCities: [Lviv()],
          produces: [Gorilka(1), MetalParts(1)],
          stock: Stock(
            [
              Wood(1500),
              Planks(1500),
              Fur(50),
              Wool(50),
              Wax(100),
              Amber(1800),
              Firearm(100),
              Bread(500),
              Horse(50),
              MetalParts(300),
            ],
          ),
          wagons: [],
        );
}
