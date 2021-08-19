import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/myrgorod.dart';
import 'package:chumaki/models/cities/ohtirka.dart';
import 'package:chumaki/models/resources/resource.dart';

class Govtva extends City {
  Govtva()
      : super(
          point: Point(1550, 1900),
          localizedKeyName: 'govtva',
          size: 2,
          unlocked: false,
          unlockPriceMoney: Money(250),
          unlocksCities: [Myrgorod(), Ohtirka()],
          manufacturings: [],
          stock: Stock(
            [
              Wood(10),
              Horse(20),
              Fur(15),
              Wool(50),
              Gorilka(30),
              Wax(10),
              Honey(30),
              Tobacco(50),
              Planks(30),
            ],
          ),
          wagons: [],
        );
}
