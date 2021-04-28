import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Price object", () {
    test("Can serialize/deserialize Price object", () {
      var price = Price([PriceUnit(RESOURCES.BREAD, 30), PriceUnit(RESOURCES.STONE, 22), PriceUnit(RESOURCES.CHARCOAL, 10)]);
      Price newPrice = Price.fromJson(price.toJson());
      expect(newPrice.sellPriceForResource(Resource.fromType(RESOURCES.STONE), withAmount: 1), equals(22), reason: "Price is correct for stone");
      expect(newPrice.prices[0].price, equals(30), reason: "Price for bread restored");
      expect(newPrice.prices[1].price, equals(22), reason: "Price for stone restored");
      expect(newPrice.prices[2].price, equals(10), reason: "Price for charcoal restored");
    });
  });
}
