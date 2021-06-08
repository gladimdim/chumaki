import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/korsun.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/resources/resource.dart';

class Cherkasy extends City {
  Cherkasy()
      : super(
          point: Point(2250, 2000),
          name: "Черкаси",
          localizedKeyName: 'cherkasy',
          size: 2,
          unlocked: true,
          produces: [],
          unlocksCities: [Pereyaslav(), Kyiv(), Korsun()],
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
          wagons: [
            // Wagon(localizedNameKey: "company.valko", stock: Stock([Bread(10), Wood(30)])),
            // Wagon(localizedNameKey: "company.kharchenko", stock: Stock([Firearm(5), Stone(15)])),
            // Wagon(
            //     localizedNameKey: "company.pidlisnyi",
            //     stock: Stock([Fur(30), Charcoal(25), Fish(15)])),
            // Wagon(
            //     localizedNameKey: "company.mitras",
            //     stock: Stock([Horse(5), Powder(25), IronOre(20)])),
          ],
        );
}
