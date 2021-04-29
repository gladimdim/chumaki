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
      var city = City(point: Point(15, 13), name: "Testing", stock: Stock([Bread(15), Stone(30)]), prices: Price([PriceUnit(RESOURCES.BREAD, 10), PriceUnit(RESOURCES.STONE, 3)]), localizedKeyName: "testing");
      var newCity = City.fromJson(city.toJson());
      expect(newCity.name, equals(city.name), reason: "City name restored");
    });
  });
}
