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
          name: "Переяслав",
          unlocked: true,
          localizedKeyName: 'pereyaslav',
          size: 2,
          unlocksCities: [Kyiv()],
          manufacturings: [Stables(), HoneyMaker()],
          stock: Stock([
            Bread(1000),
            Stone(1000),
            Cannon(3),
            Grains(1000),
            Fur(100),
            Planks(500),
            Wood(1000),
            MetalParts(100),
            Firearm(40),
            Salt(150),
            Wool(150),
            Honey(500),
            Wax(500),
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
                artPath: "images/events/vesterfeld/river_battle_2.png"),
            Event(
                iconPath: "images/resources/horse/horse_2.png",
                payment: Money(1450),
                requirements: [
                  Horse(80),
                  Firearm(40),
                  Powder(50),
                ],
                localizedKey: "events.pereyaslavBrotherhood",
                artPath: "images/events/vesterfeld/river_battle_2.png"),
            Event(
                iconPath: "images/resources/salt/salt.png",
                payment: Money(2000),
                requirements: [
                  Bread(200),
                  Grains(300),
                  Fish(400),
                  Salt(50),
                  Powder(40),
                ],
                localizedKey: "events.pereyaslavUncalmTimes",
                artPath: "images/events/vesterfeld/river_battle_2.png"),
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
