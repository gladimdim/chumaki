import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Converters for AffectUnit", () {
    test("Can initialize", () {
      final unit = PerkUnit(
        affectsResourceCategory: RESOURCE_CATEGORY.FOOD,
      );
      final newUnit = PerkUnit.fromJson(unit.toJson());
      expect(newUnit.affectsResourceCategory, equals(RESOURCE_CATEGORY.FOOD),
          reason: "Resource Category was restored");
    });
  });
}
