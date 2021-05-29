import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("Initializers", () {
    test("Can initialize", () {
      final leader = Leader("test", affects: Set());
      expect(leader.localizedNameKey, equals("test"));
    });

    test("Can initialize with a list of affects", () {
      final leader = Leader("test",
          affects: Set.from([
            AffectUnit(
                affectsResource: RESOURCES.WOOD, sellValue: 1.1, buyValue: 0.9)
          ]));
      expect(leader.affects, isNotEmpty);
    });
  });

  group("Price affects logics", () {
    final leader = Leader("test",
        affects: Set.from([
          AffectUnit(
              affectsResource: RESOURCES.WOOD, sellValue: 1.1, buyValue: 0.9)
        ]));
    test("Can tell if the resource prices are affected.", () {
      expect(leader.doesAffectResource(Wood(10)), isTrue,
          reason: "Wood is affected.");
      expect(leader.doesAffectResource(Amber(10)), isFalse,
          reason: "Amber is not affected");
    });

    test("Can return affect for the given resource", () {
      final affect = leader.affectFor(resource: Wood(3));
      expect(affect, isA<AffectUnit>(), reason: "Got an affect unit for Wood.");
      expect(affect!.sellValue, equals(1.1), reason: "Sell value was returned");
      expect(affect.buyValue, equals(0.9), reason: "Sell value was returned");
    });

    test("Can add experience", () {
      final leader = Leader("test",
          experience: 950,
          affects: Set.from([
            AffectUnit(
                affectsResource: RESOURCES.WOOD, sellValue: 1.1, buyValue: 0.9)
          ]));
      leader.addExperience(51);
      expect(leader.level, equals(1), reason: "Level is now 1");
      leader.addExperience(1000);
      expect(leader.level, equals(2), reason: "Level is now 2");
      leader.addExperience(1000);
      expect(leader.level, equals(3), reason: "Level is now 3");
      leader.addExperience(1000);
      expect(leader.level, equals(3), reason: "Level is still 3 (max)");
    });

    test("Can tell new sell price for the affected resource", () {
      expect(
          leader.affectSellValueForResource(
              resource: Wood(10), priceUnit: PriceUnit(RESOURCES.WOOD, 10)),
          equals(110.0),
          reason: "Price is increased by 1.1");
    });

    test("Does not affect price for the not affected resource.", () {
      expect(
          leader.affectSellValueForResource(
              resource: Fish(10), priceUnit: PriceUnit(RESOURCES.FISH, 10)),
          equals(100.0),
          reason: "Price is not modified");
    });

    test("Can tell new sell price for the affected resource", () {
      expect(
          leader.affectBuyValueForResource(
              resource: Wood(10), priceUnit: PriceUnit(RESOURCES.WOOD, 10)),
          equals(90.0),
          reason: "Sell Price is decreased by 0.9");
    });

    test("Does not affect price for the not affected resource.", () {
      expect(
          leader.affectBuyValueForResource(
              resource: Fish(10), priceUnit: PriceUnit(RESOURCES.FISH, 10)),
          equals(100.0),
          reason: "Price is not modified");
    });
  });

  group("JSON Converters", () {
    final leader = Leader("test",
        affects: Set.from(
          [
            AffectUnit(
                affectsResource: RESOURCES.AMBER, sellValue: 5, buyValue: 1),
            AffectUnit(
                affectsResource: RESOURCES.FISH, sellValue: 3, buyValue: 2)
          ],
        ),
        experience: 2300);
    final newLeader = Leader.fromJson(leader.toJson());
    test("Can convert to and back from json", () {
      expect(newLeader.localizedNameKey, equals("test"),
          reason: "Localized key name was restored");
      expect(newLeader.affects.length, equals(leader.affects.length),
          reason: "Affects set was restored");
      expect(newLeader.affects.length, equals(2),
          reason: "Affects set was restored");
      expect(newLeader.affectFor(resource: Amber(1)), isNotNull,
          reason: "Amber affect restored");
      expect(
          newLeader.affectSellValueForResource(
              resource: Amber(2), priceUnit: PriceUnit(RESOURCES.AMBER, 5)),
          equals(50),
          reason: "Amber sell value affect restored");
      expect(
          newLeader.affectSellValueForResource(
              resource: Fish(3), priceUnit: PriceUnit(RESOURCES.FISH, 2)),
          equals(18),
          reason: "Fish sell value affect restored");
      expect(newLeader.experience, leader.experience,
          reason: "Experience was restored");
      expect(newLeader.level, equals(2),
          reason: "Level 2 as per restored experience");
    });
  });
}
