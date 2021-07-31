import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Uman extends City {
  Uman()
      : super(
          point: Point(3050, 1750),
          name: "Умань",
          unlocked: false,
          localizedKeyName: 'uman',
          size: 3,
          unlocksCities: [Gaivoron()],
          manufacturings: [Distillery()],
          unlockPriceMoney: Money(300),
          stock: Stock([
            Bread(1300),
            Stone(1000),
            Cannon(5),
            Grains(1000),
            Fur(100),
            Wool(800),
            Gorilka(600),
            Horse(100),
          ]),
          availableEvents: [
            Event(
                iconPath: "images/resources/wax/wax.png",
                payment: Money(1400),
                requirements: [Wax(800), Honey(300)],
                localizedKey: "events.umanWaxProblem",
                artPath: "images/events/vesterfeld/poor_boy_2.png"),
            Event(
                iconPath: "images/resources/planks/planks.png",
                payment: Money(2800),
                requirements: [Wood(200), Planks(130), Stone(100), Powder(40)],
                localizedKey: "events.umanFortified",
                artPath: "images/events/vesterfeld/fortress_outer.png"),
            Event(
                iconPath: "images/resources/horse/horse_2.png",
                payment: Money(5200),
                requirements: [
                  Cannon(3),
                  Firearm(100),
                  Horse(100),
                  Powder(200)
                ],
                localizedKey: "events.umanRealAllies",
                artPath: "images/events/vesterfeld/cannons_shooting.png"),
            Event(
                iconPath: "images/icons/military/military.png",
                payment: Money(10000),
                requirements: [
                  Bread(1000),
                  Cannon(3),
                  Grains(1000),
                  Firearm(50),
                  Horse(200),
                  Powder(200),
                  Fish(600),
                  Salt(100),
                ],
                localizedKey: "events.umanMoldovaQuestion",
                artPath: "images/events/vesterfeld/otaman.png")
          ],
        );
}
