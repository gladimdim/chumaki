import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ternopil.dart';
import 'package:chumaki/models/resources/resource.dart';

class Medzhibizh extends City {
  Medzhibizh()
      : super(
          point: Point(3950, 2300),
          localizedKeyName: 'medzhibizh',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(250.0),
          unlocksCities: [Ternopil()],
          manufacturings: [],
          stock: Stock(
            [
              MetalParts(30),
              Firearm(10),
              Honey(25),
              Gorilka(30),
              Stone(40),
            ],
          ),
          wagons: [],
        );
}
