import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON PriceUnit object", () {
    test("Can serialize/deserialize PriceUnit object", () {
      var pu = PriceUnit(RESOURCES.STONE, 22);
      PriceUnit newPu = PriceUnit.fromJson(pu.toJson());
      expect(newPu.price, equals(pu.price), reason: "Price restored");
      expect(newPu.resourceType, equals(pu.resourceType), reason: "Resource restored");
    });
  });
}
