import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Lviv extends City {
  Lviv()
      : super(
            point: Point(4900, 2400),
            name: "Львів",
            localizedKeyName: 'lviv',
            size: 6,
            unlocked: false,
            unlockPriceMoney: Money(1250.0),
            unlocksCities: [],
            manufacturings: [CannonFoundry(), Smith()],
            stock: Stock(
              [
                Wood(2500),
                Planks(2500),
                Fur(500),
                Wool(500),
                Wax(1000),
                Amber(800),
                Cannon(300),
                Firearm(500),
                Silk(500),
              ],
            ),
            wagons: [],
            availableEvents: [
              Event(
                  iconPath: "images/manufacturings/church/church_3.png",
                  payment: Money(1000),
                  requirements: [Wood(50), Planks(80), Wax(300)],
                  localizedKey: "events.lvivUniOpening",
                  artPath: "images/events/vesterfeld/big_town.png"),
              Event(
                  iconPath: "images/manufacturings/church/church_2.png",
                  payment: Money(2000),
                  requirements: [
                    Wax(50),
                    Amber(50),
                    MetalParts(20),
                    Powder(20),
                    Planks(50),
                    Wool(50),
                    Salt(50),
                    Cloth(50),
                  ],
                  localizedKey: "events.lvivStarFall",
                  artPath: "images/events/vesterfeld/city_and_hills.png"),
              Event(
                  iconPath: "images/resources/metalparts/metalparts_2.png",
                  payment: Money(3000),
                  requirements: [
                    MetalParts(100),
                    Charcoal(100),
                    IronOre(200),
                  ],
                  localizedKey: "events.lvivLostTrading",
                  artPath: "images/events/vesterfeld/fortress_town.png"),
              Event(
                  iconPath: "images/resources/planks/planks_2.png",
                  payment: Money(3900),
                  requirements: [
                    Wood(100),
                    Planks(100),
                    MetalParts(200),
                  ],
                  localizedKey: "events.lvivBigFire",
                  artPath: "images/events/vesterfeld/ruins_2.png")
            ]);
}
