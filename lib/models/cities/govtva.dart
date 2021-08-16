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
          unlocked: true,
          unlocksCities: [Myrgorod(), Ohtirka()],
          manufacturings: [],
          stock: Stock(
            [
              Wood(50),
              Horse(40),
              Fur(75),
              Wool(50),
              Gorilka(150),
              Wax(150),
              Honey(200),
              Tobacco(80),
              Planks(50),
            ],
          ),
          wagons: [],
        );
}
