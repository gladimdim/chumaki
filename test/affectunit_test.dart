import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Converters for AffectUnit", () {
    test("Can initialize", () {
      final unit = PerkUnit(affectsResource: RESOURCES.WOOD, sellValue: 1.5, buyValue: 0.5);
      final newUnit = PerkUnit.fromJson(unit.toJson());
      expect(newUnit.affectsResource, equals(RESOURCES.WOOD), reason: "Resource was restored");
      expect(newUnit.sellValue, equals(1.5), reason: "Sell value restored");
      expect(newUnit.buyValue, equals(0.5), reason: "Buy value restored");

    });


  });
}
