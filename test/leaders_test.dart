import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("Initializers", () {
    test("Can initialize", () {
      final leader = Leader("test", affects: Set());
      expect(leader.localizedKeyName, equals("test"));
    });

    test("Can initialize with a list of affects", () {
      final leader = Leader("test", affects: Set.from([
        AffectUnit(
            affectsResource: RESOURCES.WOOD, sellValue: 1.1, buyValue: 0.9)
      ]));
      expect(leader.affects, isNotEmpty);
    });
  });

  group("Affects logics", () {
    final leader = Leader("test", affects: Set.from([
      AffectUnit(
          affectsResource: RESOURCES.WOOD, sellValue: 1.1, buyValue: 0.9)
    ]));
    test("Can tell if the resource prices are affected.", () {
      expect(leader.doesAffectResource(Wood(10)), isTrue, reason: "Wood is affected.");
      expect(leader.doesAffectResource(Amber(10)), isFalse, reason: "Amber is not affected");
    });

    test("Can return affect for the given resource", () {

      final affect = leader.affectFor(resource: Wood(3));
      expect(affect, isA<AffectUnit>(), reason: "Got an affect unit for Wood.");
      expect(affect!.sellValue, equals(1.1), reason: "Sell value was returned");
      expect(affect.buyValue, equals(0.9), reason: "Sell value was returned");
    });

    test("Can tell new sell price for the affected resource", () {
      expect(leader.affectSellValueForResource(resource: Wood(10), priceUnit: PriceUnit(RESOURCES.WOOD, 10)), equals(110), reason: "Price is increased by 1.1");
      leader.level =2 ;
      expect(leader.affectSellValueForResource(resource: Wood(10), priceUnit: PriceUnit(RESOURCES.WOOD, 10)), equals(110), reason: "Price is increased by 1.1");
    });

    test("Does not affect price for the not affected resource.", () {
      expect(leader.affectSellValueForResource(resource: Fish(10), priceUnit: PriceUnit(RESOURCES.FISH, 10)), equals(100), reason: "Price is not modified");

    });
  });
}
