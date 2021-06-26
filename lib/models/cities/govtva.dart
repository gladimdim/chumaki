import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/myrgorod.dart';
import 'package:chumaki/models/resources/resource.dart';

class Govtva extends City {
  Govtva()
      : super(
    point: Point(1600, 1900),
    name: "Говтва",
    localizedKeyName: 'govtva',
    size: 2,
    unlocked: true,
    unlocksCities: [Myrgorod()],
    produces: [],
    stock: Stock(
      [
        Wood(50),
        Horse(100),
        Fur(150),
        Wool(100),
        Gorilka(150),
        Wax(200),
        Honey(400),
        Tobacco(80),
        Planks(50),
      ],
    ),
    wagons: [],
  );
}
