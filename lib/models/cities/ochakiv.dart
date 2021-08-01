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
          name: "Очаків",
          localizedKeyName: 'ochakiv',
          size: 2,
          unlocked: false,
          unlocksCities: [Temryuk()],
          unlockPriceMoney: Money(50),
          manufacturings: [River(), Liman(), TobaccoMaker()],
          stock: Stock(
            [
              Powder(1000),
              Fish(1500),
              Salt(2000),
              Silk(300),
              Tobacco(2000),
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
                iconPath: "images/resources/fur/fur.png",
                payment: Money(2500),
                requirements: [
                  Fur(300),
                ],
                localizedKey: "events.ochakivIndianTravellers",
                artPath: "images/events/vesterfeld/cossack_and_sheep.png"),
            Event(
                iconPath: "images/resources/bread/bread.png",
                payment: Money(2300),
                requirements: [
                  Bread(500),
                  Grains(400),
                ],
                localizedKey: "events.ochakivTradeStimulus",
                artPath: "images/events/vesterfeld/elite_cossacks_2.png")
          ],
        );
}
