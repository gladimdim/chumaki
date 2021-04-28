import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Price object", () {
    test("Can serialize/deserialize Price object", () {
      var price = Price([PriceUnit(RESOURCES.BREAD, 30), PriceUnit(RESOURCES.STONE, 22), PriceUnit(RESOURCES.CHARCOAL, 10)]);
      Price newPrice = Price.fromJson(price.toJson());
      expect(newPrice.buyPriceForResource(Resource.fromType(RESOURCES.STONE)), equals(22), reason: "Price for stone restored");
    });
  });
}
