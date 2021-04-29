import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("JSON City object", () {
    test("Can serialize/deserialize City object", () {
      var city = City(
        point: Point(15, 13),
        name: "Testing",
        stock: Stock([Bread(15), Stone(30)]),
        prices: Price(
            [PriceUnit(RESOURCES.BREAD, 10), PriceUnit(RESOURCES.STONE, 3)]),
        localizedKeyName: "testing",
        wagons: [Wagon(name: "First"), Wagon(name: "Second"),],);
      var newCity = City.fromJson(city.toJson());
      expect(newCity.name, equals(city.name), reason: "City name restored");
      expect(newCity.wagons.length, equals(2), reason: "Wagons restored");
      expect(newCity.prices.prices.length, equals(2), reason: "Prices restored.");
      expect(newCity.prices.sellPriceForResource(Bread(1)), equals(10), reason: "10 is for 1 bread restored");
      expect(newCity.prices.sellPriceForResource(Stone(1)), equals(3), reason: "3 is for 1 stone restored");
      expect(newCity.wagons.first.name, equals("First"), reason: "Wagon is really from previous save.");
    });
  });
}