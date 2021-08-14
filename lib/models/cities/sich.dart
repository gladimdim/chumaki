import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:chumaki/extensions/list.dart';

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          localizedKeyName: 'sich',
          size: 4,
          unlocked: true,
          unlocksCities: [Ochakiv()],
          manufacturings: [PowderCellar(), River()],
          activeEvent: Event(
            localizedKey: 'events.giveFood',
            iconPath: 'images/resources/bread/bread_1.png',
            requirements: [
              Grains(50),
            ],
            payment: Money(200),
            artPath: "images/events/vesterfeld/cossack_and_bum.png",
          ),
          availableEvents: [
            Event(
              localizedKey: 'events.giveFood',
              iconPath: 'images/resources/bread/bread_1.png',
              requirements: [Grains(200), Bread(100)],
              payment: Money(500),
              artPath: "images/events/vesterfeld/cossack_and_bum.png",
            ),
            Event(
              localizedKey: 'events.celebrateElections',
              iconPath: 'images/resources/gorilka/gorilka.png',
              requirements: [Gorilka(50), Tobacco(80)],
              payment: Money(800),
              artPath: "images/events/vesterfeld/elite_cossacks.png",
            ),
            Event(
              localizedKey: 'events.buyCannons',
              iconPath: 'images/resources/cannon/cannon_3.png',
              requirements: [Cannon(8), Horse(50)],
              payment: Money(2800),
              artPath: "images/events/vesterfeld/cannons_shooting.png",
            ),
          ],
          stock: Stock(
            [
              Powder(600),
              Fish(700),
              Horse(300),
              Fur(120),
              Salt(250),
              Wool(100),
              Silk(300),
              Gorilka(250),
              Wax(400),
              Honey(150),
              Tobacco(500),
            ],
          ),
          wagons: [
            Wagon(
              leader: Leader.allLeaders().takeRandom(),
              stock: Stock(
                [
                  Grains(20),
                  Fish(50),
                  Bread(80),
                  Wood(50),
                ],
              ),
            ),
          ],
        );
}
