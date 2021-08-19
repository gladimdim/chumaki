import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          unlocked: true,
          localizedKeyName: 'pereyaslav',
          size: 2,
          unlocksCities: [Kyiv()],
          manufacturings: [Stables(), HoneyMaker()],
          stock: Stock([
            Horse(80),
            Bread(90),
            Stone(30),
            Grains(70),
            Fur(10),
            Planks(50),
            Wood(50),
            MetalParts(10),
            Firearm(10),
            Salt(50),
            Wool(50),
            Honey(320),
            Wax(100),
          ]),
          availableEvents: [
            Event(
                iconPath: "images/resources/ironore/ironore_3.png",
                payment: Money(600),
                requirements: [
                  Wood(30),
                  IronOre(50),
                  Planks(40),
                ],
                localizedKey: "events.pereyaslavNewFerry",
                artPath: "images/events/vesterfeld/river_battle_2.png"),
            Event(
                iconPath: "images/resources/planks/planks_3.png",
                payment: Money(800),
                requirements: [
                  Bread(30),
                  Fish(80),
                  Salt(10),
                ],
                localizedKey: "events.pereyaslavGraves",
                artPath: "images/events/vesterfeld/wandering_men.png"),
            Event(
                iconPath: "images/resources/horse/horse_2.png",
                payment: Money(1450),
                requirements: [
                  Horse(80),
                  Firearm(40),
                  Powder(50),
                ],
                localizedKey: "events.pereyaslavBrotherhood",
                artPath: "images/events/vesterfeld/pohid.png"),
            Event(
                iconPath: "images/resources/salt/salt.png",
                payment: Money(2000),
                requirements: [
                  Bread(100),
                  Grains(180),
                  Fish(400),
                  Salt(50),
                  Powder(40),
                ],
                localizedKey: "events.pereyaslavUncalmTimes",
                artPath: "images/events/vesterfeld/elite_cossacks_2.png"),
            Event(
                iconPath: "images/resources/stone/stone_2.png",
                payment: Money(2000),
                requirements: [
                  Stone(200),
                  Planks(100),
                  Wood(100),
                  IronOre(30),
                  MetalParts(50),
                ],
                localizedKey: "events.pereyaslavHospital",
                artPath: "images/events/vesterfeld/fortress.png"),
          ],
        );
}
