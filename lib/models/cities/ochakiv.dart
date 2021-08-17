import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/temryuk.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Ochakiv extends City {
  Ochakiv()
      : super(
          point: Point(2400, 700),
          localizedKeyName: 'ochakiv',
          size: 2,
          unlocked: false,
          unlocksCities: [Temryuk()],
          unlockPriceMoney: Money(200),
          manufacturings: [
            River(),
            Liman(),
          ],
          stock: Stock(
            [
              Powder(200),
              Fish(800),
              Salt(500),
              Silk(100),
              Tobacco(350),
            ],
          ),
          availableEvents: [
            Event(
                iconPath: "images/resources/amber/amber.png",
                payment: Money(1300),
                requirements: [
                  Amber(30),
                  Wool(30),
                  Fur(30),
                  Powder(50),
                ],
                localizedKey: "events.ochakivEmbassy",
                artPath: "images/events/vesterfeld/cossacks_crowd2.png"),
            Event(
                iconPath: "images/resources/bread/bread.png",
                payment: Money(1800),
                requirements: [
                  Bread(200),
                  Grains(300),
                ],
                localizedKey: "events.ochakivTradeStimulus",
                artPath: "images/events/vesterfeld/elite_cossacks_2.png"),
            Event(
                iconPath: "images/resources/fur/fur.png",
                payment: Money(2500),
                requirements: [
                  Fur(100),
                ],
                localizedKey: "events.ochakivIndianTravellers",
                artPath: "images/events/vesterfeld/cossack_and_sheep.png"),
          ],
        );
}
