import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON PriceUnit object", () {
    test("Can serialize/deserialize PriceUnit object", () {
      var pu = PriceUnit(Stone(1), 22);
      expect(pu.buyPriceForResource(), equals(22), reason: "Price is correct");
      expect(pu.sellPriceForResource(), equals(22 * 0.85), reason: "Price is correct");
    });
  });
}
