import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Stock object", () {

    test("Can serialize/deserialize Wagon object", () {
      var stock = Stock([Wool(30), Stone(55), Firearm(10)]);
      var newStock = Stock.fromJson(stock.toJson());
      expect(newStock.stock.length, equals(stock.stock.length), reason: "Amount of items in stock restored.");
      expect(newStock.hasResource(Wool(0)), isTrue, reason: "Wool found");
      expect(newStock.hasResource(Silk(0)), isFalse, reason: "Silk not found");
      expect(newStock.resourceInStock(Firearm(0))!.amount, equals(10), reason: "10 firearms are there");
    });
  });
}
