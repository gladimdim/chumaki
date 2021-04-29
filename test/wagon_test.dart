import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Wagon object", () {
    var stock = Stock([Wool(30), Stone(55), Firearm(10)]);
    test("Can serialize/deserialize Wagon object", () {
      var wagon = Wagon(name: "Dmytro", stock: stock, totalWeightCapacity: 200);
      var newWagon = Wagon.fromJson(wagon.toJson());
      expect(newWagon.name, equals(wagon.name), reason: "Name was restored.");
    });
  });
}
