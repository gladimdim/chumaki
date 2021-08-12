import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/korsun.dart';
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
          manufacturings: [],
          unlocksCities: [Pereyaslav(), Korsun()],
          availableEvents: [
            Event(
                iconPath: "images/icons/luxury/luxury.png",
                payment: Money(890),
                requirements: [
                  Gorilka(100),
                  Bread(50),
                  Silk(20),
                  Amber(20),
                  Honey(20),
                  Tobacco(10)
                ],
                localizedKey: "events.cossackStarshinaWedding",
                artPath: "images/events/vesterfeld/elite_cossacks.png"),
            Event(
                iconPath: "images/resources/wood/wood_2.png",
                payment: Money(420),
                requirements: [
                  Bread(50),
                  Wood(30),
                  Planks(30),
                ],
                localizedKey: "events.cherkasyIncreaseOfPopulation",
                artPath: "images/events/vesterfeld/cossacks_crowd.png"),
            Event(
                iconPath: "images/resources/salt/salt.png",
                payment: Money(700),
                requirements: [
                  Bread(100),
                  Grains(120),
                  Salt(40),
                ],
                localizedKey: "events.cherkasyLocust",
                artPath: "images/events/vesterfeld/poor_boy_2.png"),
            Event(
                iconPath: "images/resources/metalparts/metalparts.png",
                payment: Money(2900),
                requirements: [
                  MetalParts(40),
                  Gorilka(20),
                  Firearm(50),
                  Cannon(5),
                  Powder(40),
                  Horse(50),
                  Bread(100),
                ],
                localizedKey: "events.cherkasyWarPreps",
                artPath: "images/events/vesterfeld/field_with_horses.png"),
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
