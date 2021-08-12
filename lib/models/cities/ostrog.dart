import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'lviv.dart';

class Ostrog extends City {
  Ostrog()
      : super(
            point: Point(4100, 2800),
            name: "Острог",
            localizedKeyName: 'ostrog',
            size: 2,
            unlocked: false,
            unlockPriceMoney: Money(200.0),
            unlocksCities: [Lviv()],
            manufacturings: [Distillery(), Smeltery()],
            stock: Stock(
              [
                Wood(350),
                Planks(500),
                Fur(50),
                Wool(50),
                Wax(100),
                Amber(800),
                Firearm(100),
                Bread(300),
                Horse(50),
                Gorilka(450),
                MetalParts(750),
              ],
            ),
            wagons: [],
            availableEvents: [
              Event(
                  iconPath: "images/resources/gorilka/gorilka.png",
                  payment: Money(800),
                  requirements: [Grains(250)],
                  localizedKey: "events.ostrogPeregonka",
                  artPath: "images/events/vesterfeld/soldiers_looking.png"),
              Event(
                  iconPath: "images/resources/wax/wax.png",
                  payment: Money(1250),
                  requirements: [Wax(250), Bread(200), Grains(200)],
                  localizedKey: "events.ostrogAcademy",
                  artPath: "images/events/vesterfeld/fortress_outer.png"),
              Event(
                  iconPath: "images/resources/cloth/cloth.png",
                  payment: Money(1400),
                  requirements: [Cloth(100), Silk(50), Amber(40)],
                  localizedKey: "events.ostrogBirthday",
                  artPath: "images/events/vesterfeld/elite_cossacks.png"),
              Event(
                  iconPath: "images/resources/ironore/ironore_3.png",
                  payment: Money(2000),
                  requirements: [IronOre(500),],
                  localizedKey: "events.ostrogHugeOrder",
                  artPath: "images/events/vesterfeld/cossacks_rest.png"),
              Event(
                  iconPath: "images/resources/metalparts/metalparts.png",
                  payment: Money(2400),
                  requirements: [Wood(200), Planks(200), Stone(100), MetalParts(50)],
                  localizedKey: "events.ostrogUpgradeCastle",
                  artPath: "images/events/vesterfeld/fortress_town.png"),
            ]);
}
