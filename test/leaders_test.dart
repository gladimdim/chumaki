import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/resources/resource_category.dart';
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
            PerkUnit(
                affectsResourceCategory: RESOURCE_CATEGORY.MILITARY,)
          ]));
      expect(leader.perks, isNotEmpty);
    });
  });

  group("Price affects logics", () {
    final leader = Leader("test",
        affects: Set.from([
          PerkUnit(
              affectsResourceCategory: RESOURCE_CATEGORY.MILITARY, )
        ]));
    test("Can tell if the resource prices are affected.", () {
      expect(leader.hasPerkForCategory(RESOURCE_CATEGORY.MILITARY), isTrue,
          reason: "Military is affected.");
      expect(leader.hasPerkForCategory(RESOURCE_CATEGORY.LUXURY), isFalse,
          reason: "Luxury is not affected");
    });

    test("Can return affect for the given resource", () {
      final affect = leader.perkFor(cat: RESOURCE_CATEGORY.MILITARY);
      expect(affect, isA<PerkUnit>(), reason: "Got a unit for Military.");
    });

    test("Can add experience", () {
      final leader = Leader("test",
          experience: 450,
          affects: Set.from([
            PerkUnit(
                affectsResourceCategory: RESOURCE_CATEGORY.MILITARY,)
          ]));
      leader.addExperience(51);
      expect(leader.level, equals(1), reason: "Level is now 1");
      leader.addExperience(500);
      expect(leader.level, equals(2), reason: "Level is now 2");
      leader.addExperience(500);
      expect(leader.level, equals(3), reason: "Level is now 3");
      leader.addExperience(500);
      expect(leader.level, equals(3), reason: "Level is still 3 (max)");
    });
  });

  group("JSON Converters", () {
    final leader = Leader("test",
        affects: Set.from(
          [
            PerkUnit(
                affectsResourceCategory: RESOURCE_CATEGORY.MILITARY,),
            PerkUnit(
                affectsResourceCategory: RESOURCE_CATEGORY.LUXURY,)
          ],
        ),
        experience: 1002);
    final newLeader = Leader.fromJson(leader.toJson());
    test("Can convert to and back from json", () {
      expect(newLeader.localizedNameKey, equals("test"),
          reason: "Localized key name was restored");
      expect(newLeader.perks.length, equals(leader.perks.length),
          reason: "Affects set was restored");
      expect(newLeader.perks.length, equals(2),
          reason: "Affects set was restored");
      expect(newLeader.perkFor(cat: RESOURCE_CATEGORY.MILITARY), isNotNull,
          reason: "Military affect restored");

      expect(newLeader.experience, leader.experience,
          reason: "Experience was restored");
      expect(newLeader.level, equals(2),
          reason: "Level 2 as per restored experience");
    });
  });
}
