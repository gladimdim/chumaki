import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/manufacturings/manufacturing.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("Replenish stock", () {
    test("Can replenish stock from mfg", () {
      final city = Sich();
      final company = Company();
      city.stock.removeResource(Fish(670));
      city.buildManufacturing(River(), company);
      city.replenishStock();

      expect(city.stock.resourceInStock(Fish(1))!.amount, equals(130),
          reason: "100 fish from River was added.");
    });

    test("Does not replenish stock from mfg if there is enough", () {
      final city = Sich();
      final company = Company();
      city.stock.removeResource(Fish(10));
      city.buildManufacturing(River(), company);
      city.replenishStock();

      expect(city.stock.resourceInStock(Fish(1))!.amount, equals(690),
          reason: "100 fish from River was added.");
    });
  });
  group("Price checks", () {
    final cities = [Kyiv(), Nizhin(), Zhytomir()];
    test("Can tell the prices with production centers", () {
      final city = Kyiv();
      final waxPrice = city.buyPriceForResource(Wax(1), cities);
      expect(waxPrice, equals(0.3),
          reason: "Original price as Kyiv produces Wax");
      expect(city.buyPriceForResource(Cloth(1), cities), equals(1.0),
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
        stock: Stock([Bread(15), Stone(30)]),
        size: 3,
        unlocked: true,
        unlockPriceMoney: Money(42),
        unlocksCities: [Cherkasy()],
        localizedKeyName: "kyiv",
        wagons: [
          Wagon(),
          Wagon(),
        ],
      );
      var newCity = City.fromJson(city.toJson());
      expect(newCity.point, equals(Kyiv().point), reason: "Point is ignored for named cities");
      expect(newCity.stock.resourceInStock(Bread(1))!.amount, equals(15), reason: "Stock is restored from city constructor");
      expect(newCity.localizedKeyName, equals(city.localizedKeyName), reason: "City localizedKeyName restored");
      expect(newCity.wagons.length, equals(2), reason: "Wagons restored");
      expect(newCity.buyPriceForResource(Bread(1), [Vinnitsa(), Zhytomir()]),
          equals(0.8),
          reason: "0.8 city is near the bread prod center.");
      expect(newCity.buyPriceForResource(Stone(1), [Vinnitsa(), Zhytomir()]),
          equals(5.4),
          reason: "5.4 (stone (5 ~* distance * 0.01) is for 1 stone restored");
      expect(newCity.wagons.first, isNotNull,
          reason: "Wagon is really from previous save.");
      expect(newCity.isUnlocked(), isTrue, reason: "City is unlocked");
      expect(newCity.unlocksCities, isNotEmpty,
          reason: "Unlocks city list is present");
      expect(newCity.unlocksCities[0].localizedKeyName,
          Nizhin().localizedKeyName,
          reason: "Kyiv's first unlock is Nizhin. It ignores the 'wild' city properties and uses hard coded in code instead.");
      expect(newCity.size, equals(4.0), reason: "City size read from code instead of from json.");
      expect(newCity.unlockPriceMoney.amount, equals(500),
          reason: "Ignores constructor input and instead uses from fromName static method for 'kyiv' name.");
    });
  });
}
