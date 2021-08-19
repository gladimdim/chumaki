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
            Bread(40),
            Stone(20),
            Firearm(5),
            Powder(30),
            Grains(30),
            Horse(5),
            Planks(20),
            IronOre(30),
            Cannon(1),
            MetalParts(20),
            Salt(10),
            Wool(200),
            Gorilka(20),
            Wax(30),
            Honey(10),
          ]),
        );
}
