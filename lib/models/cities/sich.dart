import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';

class Sich extends City {
  Sich()
      : super(
    point: Point(1200, 900),
    name: "Січ",
    localizedKeyName: 'sich',
    size: 4,
    unlocked: true,
    unlocksCities: [Ochakiv()],
    produces: [Powder(1), Fish(1)],
    availableEvents: [Event(
      localizedTitleKey: 'events.giveFoodTitle',
      iconPath: 'images/resources/bread/bread_1.png',
      requirements: [Grains(10),],
      localizedTextKey: "events.giveFoodText",
      outcome: [
        Horse(5),
        Powder(50),
        Fish(100),
      ],
      payment: Money(100),
    ),
      Event(
        localizedTitleKey: 'events.buyCannonsTitle',
        iconPath: 'images/resources/cannon/cannon_3.png',
        requirements: [Cannon(3), Horse(10)],
        localizedTextKey: "events.buyCannonsText",
        outcome: [Fish(300), Powder(100)],
        payment: Money(200),
      ),
    ],
    stock: Stock(
      [
        Powder(1000),
        Fish(1500),
        Horse(300),
        Fur(1500),
        Salt(2000),
        Wool(100),
        Silk(300),
        Gorilka(450),
        Wax(3000),
        Honey(1500),
        Tobacco(500),
      ],
    ),
    wagons: [
      // Wagon(
      //     localizedNameKey: "company.tartar",
      //     stock: Stock([
      //       Charcoal(20),
      //       // IronOre(10),
      //     ])),
      // Wagon(
      //     localizedNameKey: "company.ostapa",
      //     stock: Stock([
      //       Powder(20),
      //       MetalParts(10),
      //     ])),
      Wagon(
        stock: Stock(
          [
            Grains(50),
            Fish(50),
          ],
        ),
      ),
    ],
  );
}
