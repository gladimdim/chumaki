import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          localizedKeyName: 'sich',
          size: 4,
          unlocked: true,
          unlocksCities: [Ochakiv()],
          produces: [Powder(1), Fish(1)],
          availableEvents: [
            Event(
              localizedKey: 'events.giveFood',
              iconPath: 'images/resources/bread/bread_1.png',
              requirements: [Grains(10), Bread(10)],
              payment: Money(200),
            ),
            Event(
              localizedKey: 'events.celebrateElections',
              iconPath: 'images/resources/gorilka/gorilka.png',
              requirements: [Gorilka(50), Tobacco(30)],
              payment: Money(200),
            ),
            Event(
              localizedKey: 'events.buyCannons',
              iconPath: 'images/resources/cannon/cannon_3.png',
              requirements: [Cannon(3), Horse(10)],
              payment: Money(1200),
            ),
          ],
          stock: Stock(
            [
              Powder(1000),
              Fish(1500),
              Horse(300),
              Fur(1500),
              Salt(2000),
              Wool(100),
              Silk(300),
              Gorilka(450),
              Wax(3000),
              Honey(1500),
              Tobacco(500),
            ],
          ),
          wagons: [
            Wagon(
              stock: Stock(
                [
                  Grains(50),
                  Fish(50),
                ],
              ),
            ),
          ],
        );
}
