import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/rylsk.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';

class Nizhin extends City {
  Nizhin()
      : super(
            point: Point(1950, 2950),
            size: 3,
            localizedKeyName: 'nizhin',
            unlocked: false,
            unlocksCities: [Rylsk()],
            unlockPriceMoney: Money(500),
            manufacturings: [Weavery()],
            stock: Stock(
              [
                Cloth(250),
                Wax(20),
                Grains(80),
                Wood(90),
                Horse(5),
                Powder(30),
                Fur(20),
                Planks(150),
                Stone(50),
                Fish(100),
                Cannon(1),
                Salt(100),
                Wool(120),
                Amber(50),
              ],
            ),
            availableEvents: [
              Event(
                  iconPath: "images/resources/silk/silk.png",
                  payment: Money(2000),
                  requirements: [
                    Silk(40),
                    Fur(50),
                    Wool(100),
                    Powder(50),
                    MetalParts(40)
                  ],
                  localizedKey: "events.nizhinPokrova",
                  artPath: "images/events/vesterfeld/city_and_hills.png"),
              Event(
                  iconPath: "images/resources/money/money.png",
                  payment: Money(2300),
                  requirements: [
                    Bread(30),
                    Horse(5),
                    Fish(50),
                    Salt(10),
                    MetalParts(10),
                    Planks(50),
                  ],
                  localizedKey: "events.nizhinTreasure",
                  artPath: "images/events/vesterfeld/cossack_and_bum.png"),
              Event(
                  iconPath: "images/resources/wood/wood_3.png",
                  payment: Money(3500),
                  requirements: [
                    Wood(100),
                    Planks(100),
                    MetalParts(40),
                  ],
                  localizedKey: "events.nizhinDryLands",
                  artPath: "images/events/vesterfeld/city_and_hills.png"),
              Event(
                  iconPath: "images/resources/cloth/cloth.png",
                  payment: Money(3200),
                  requirements: [
                    Cannon(1),
                    Powder(50),
                    Firearm(100),
                    Cloth(100),
                  ],
                  localizedKey: "events.nizhinReplaceWeapons",
                  artPath: "images/events/vesterfeld/field_fortress.png"),
            ]);

  Money unlockPriceMoney = Money(200);
}
