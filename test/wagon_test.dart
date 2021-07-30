import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Wagon object", () {
    var stock = Stock([Wool(30), Stone(55), Firearm(10)]);
    test("Can serialize/deserialize Wagon object", () {
      var wagon = Wagon(stock: stock, totalWeightCapacity: 200);
      var newWagon = Wagon.fromJson(wagon.toJson());
      expect(newWagon.stock.stock.length, equals(3),
          reason: "3 items in stock restored");
      expect(newWagon.totalWeightCapacity, wagon.totalWeightCapacity,
          reason: "Weight capacity restored.");
    });
  });
}
