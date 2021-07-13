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
          name: "Чигирин",
          localizedKeyName: 'chigirin',
          unlocked: true,
          manufacturings: [Pasture()],
          unlocksCities: [],
          availableEvents: [
            Event(
              iconPath: "images/resources/cloth/cloth.png",
              payment: Money(400),
              requirements: [Cloth(40), Wool(40)],
              localizedKey: "events.buyClothsForCossacks",
              artPath: "images/events/vesterfeld/cossack_and_sheep.png",
            ),
          ],
          stock: Stock([
            Bread(2000),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
            IronOre(100),
            Cannon(50),
            MetalParts(200),
            Salt(300),
            Wool(1000),
            Gorilka(500),
            Wax(1000),
            Honey(800),
          ]),
        );

  Money unlockPriceMoney = Money(0);
}
