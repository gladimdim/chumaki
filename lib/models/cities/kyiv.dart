import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Kyiv extends City {
  Kyiv()
      : super(
          point: Point(2700, 2830),
          name: "Київ",
          localizedKeyName: 'kyiv',
          size: 4,
          unlocked: false,
          unlocksCities: [Nizhin(), Chernigiv(), Zhytomir()],
          unlockPriceMoney: Money(500),
          manufacturings: [WaxMaker()],
          availableEvents: [
            Event(
                iconPath: "images/resources/firearm/firearm_3.png",
                payment: Money(400),
                requirements: [Firearm(10), Silk(20)],
                localizedKey: "events.kyivShootingTournament",
                artPath: "images/events/vesterfeld/archers.png"),
            Event(
                iconPath: "images/resources/planks/planks_2.png",
                payment: Money(1500),
                requirements: [Wood(50), Planks(80), Stone(70)],
                localizedKey: "events.kyivFlood",
                artPath: "images/events/vesterfeld/ruined_tower.png"),
            Event(
                iconPath: "images/resources/bread/bread.png",
                payment: Money(1500),
                requirements: [
                  Bread(200),
                  Grains(800),
                  Gorilka(100),
                ],
                localizedKey: "events.kyivEaster",
                artPath: "images/events/vesterfeld/cooking.png"),
            Event(
                iconPath: "images/resources/firearm/firearm_2.png",
                payment: Money(3000),
                requirements: [
                  Firearm(100),
                  Horse(30),
                  Powder(100),
                ],
                localizedKey: "events.kyivPrivateCompany",
                artPath: "images/events/vesterfeld/group_of_soldiers.png"),
            Event(
                iconPath: "images/manufacturings/church/church_3.png",
                payment: Money(5000),
                requirements: [
                  Wood(80),
                  Planks(120),
                  Stone(100),
                  MetalParts(180)
                ],
                localizedKey: "events.kyivNewChurch",
                artPath: "images/events/vesterfeld/ancient_church.png"),
          ],
          stock: Stock([
            Wax(1000),
            Wood(1000),
            Horse(200),
            Bread(2000),
            Stone(300),
            Firearm(700),
            Powder(1000),
            Grains(3000),
            Planks(500),
            IronOre(300),
            Cannon(100),
            MetalParts(400),
            Fur(200),
            Fish(1000),
            Silk(200),
            Salt(100),
            Wool(200),
            Honey(300),
            Wax(300),
            Tobacco(100),
            Amber(300),
            Cloth(300),
          ]),
        );

  Money unlockPriceMoney = Money(500);
}
