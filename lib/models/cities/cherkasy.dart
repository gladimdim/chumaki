import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/korsun.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/resources/resource.dart';

class Cherkasy extends City {
  Cherkasy()
      : super(
          point: Point(2250, 2000),
          name: "Черкаси",
          localizedKeyName: 'cherkasy',
          size: 2,
          unlocked: true,
          produces: [],
          unlocksCities: [Pereyaslav(), Kyiv(), Korsun()],
          availableEvents: [
            Event(
                iconPath: "images/icons/luxury/luxury.png",
                payment: Money(550),
                requirements: [
                  Gorilka(100),
                  Bread(50),
                  Silk(50),
                  Amber(20),
                  Honey(20),
                  Tobacco(10)
                ],
                localizedKey: "events.cossackStarshinaWedding",
                artPath: "images/events/vesterfeld/elite_cossacks.png")
          ],
          stock: Stock([
            Bread(200),
            Stone(300),
            Firearm(500),
            Powder(1000),
            Fish(1000),
            Grains(3000),
            Horse(200),
            Planks(500),
            Salt(300),
            Wool(300),
            Gorilka(500),
          ]),
          wagons: [],
        );
}
