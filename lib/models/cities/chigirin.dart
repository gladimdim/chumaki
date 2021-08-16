import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          size: 2,
          localizedKeyName: 'chigirin',
          unlocked: true,
          manufacturings: [Pasture()],
          unlocksCities: [],
          availableEvents: [
            Event(
              iconPath: "images/resources/cloth/cloth.png",
              payment: Money(700),
              requirements: [Cloth(40), Wool(40)],
              localizedKey: "events.buyClothsForCossacks",
              artPath: "images/events/vesterfeld/cossack_and_sheep.png",
            ),
          ],
          stock: Stock([
            Bread(400),
            Stone(200),
            Firearm(50),
            Powder(300),
            Grains(300),
            Horse(100),
            Planks(100),
            IronOre(30),
            Cannon(10),
            MetalParts(50),
            Salt(100),
            Wool(600),
            Gorilka(200),
            Wax(300),
            Honey(100),
          ]),
        );

  Money unlockPriceMoney = Money(0);
}
