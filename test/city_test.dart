import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("Price checks", () {
    final cities = [Kyiv(), Nizhin(), Zhytomir()];
    test("Can tell the prices with production centers", () {
      final city = Kyiv();
      final waxPrice = city.buyPriceForResource(Wax(1), cities);
      expect(waxPrice, equals(0.3),
          reason: "Original price as Kyiv produces Wax");
      expect(city.buyPriceForResource(Cloth(1), cities), equals(0.8),
          reason:
              "Cloth is produced in Nizhin so the price was adjusted Price(1) * DistanceCorrection(0.8)");
      expect(city.sellPriceForResource(Cloth(1), cities), equals(0.6),
          reason: "Sell price is adjsuted by some coefficient.");
    });

    test("Can tell the prices with adjustment to amount", () {
      final city = Kyiv();
      final waxPrice = city.buyPriceForResource(Wax(10), cities);
      expect(waxPrice, equals(3),
          reason:
              "Original price as Kyiv produces Wax multiplied by amount 10");
      expect(city.buyPriceForResource(Cloth(10), cities), equals(7.6),
          reason:
              "Cloth is produced in Nizhin so the price was adjusted Price(1) * DistanceCorrection(0.8) * Amount(10)");
      expect(city.sellPriceForResource(Cloth(10), cities), equals(6.5),
          reason:
              "Cloth is produced in Nizhin so the price was adjusted Price(1) * DistanceCorrection(0.8) * Amount(10)");
    });
  });
  group("JSON City object", () {
    test("Can serialize/deserialize City object", () {
      var city = City(
        point: Point(15, 13),
        name: "Testing",
        stock: Stock([Bread(15), Stone(30)]),
        size: 3,
        unlocked: true,
        unlockPriceMoney: Money(42),
        unlocksCities: [Cherkasy()],
        // manufacturings: [Stone(1), Bread(1)],
        localizedKeyName: "testing",
        wagons: [
          Wagon(),
          Wagon(),
        ],
      );
      var newCity = City.fromJson(city.toJson());
      expect(newCity.name, equals(city.name), reason: "City name restored");
      expect(newCity.wagons.length, equals(2), reason: "Wagons restored");
      expect(newCity.buyPriceForResource(Bread(1), [Vinnitsa(), Zhytomir()]),
          equals(3.6),
          reason: "3.6 (bread 0.8 ~* 4) is for 1 bread restored");
      expect(newCity.buyPriceForResource(Stone(1), [Vinnitsa(), Zhytomir()]),
          equals(20.7),
          reason: "20.7 (stone (5 ~* 4) is for 1 stone restored");
      expect(newCity.wagons.first, isNotNull,
          reason: "Wagon is really from previous save.");
      expect(newCity.isUnlocked(), isTrue, reason: "City is unlocked");
      expect(newCity.unlocksCities, isNotEmpty,
          reason: "Unlocks city list is present");
      expect(newCity.unlocksCities[0].localizedKeyName,
          Cherkasy().localizedKeyName,
          reason: "Unlocks Cherkasy");
      expect(newCity.size, equals(3), reason: "City size restored");
      expect(newCity.unlockPriceMoney.amount, equals(42),
          reason: "42 money required for unlocking");
    });
  });
}
