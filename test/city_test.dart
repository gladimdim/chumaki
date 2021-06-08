import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("JSON City object", () {
    test("Can serialize/deserialize City object", () {
      var city = City(
        point: Point(15, 13),
        name: "Testing",
        stock: Stock([Bread(15), Stone(30)]),
        size: 3,
        unlocked: true,
        unlocksCities: [Cherkasy()],
        produces: [Stone(1), Bread(1)],
        localizedKeyName: "testing",
        wagons: [
          Wagon(),
          Wagon(),
        ],
      );
      var newCity = City.fromJson(city.toJson());
      expect(newCity.name, equals(city.name), reason: "City name restored");
      expect(newCity.wagons.length, equals(2), reason: "Wagons restored");
      expect(newCity.buyPriceForResource(Bread(1), [Vinnitsa(),]), equals(10),
          reason: "10 is for 1 bread restored");
      expect(newCity.buyPriceForResource(Stone(1), [Vinnitsa()]), equals(3),
          reason: "3 is for 1 stone restored");
      expect(newCity.wagons.first, isNotNull,
          reason: "Wagon is really from previous save.");
      expect(newCity.isUnlocked(), isTrue, reason: "City is unlocked");
      expect(newCity.unlocksCities, isNotEmpty,
          reason: "Unlocks city list is present");
      expect(newCity.unlocksCities[0].localizedKeyName,
          Cherkasy().localizedKeyName,
          reason: "Unlocks Cherkasy");
      expect(newCity.size, equals(3), reason: "City size restored");
    });
  });
}
