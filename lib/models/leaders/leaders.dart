import 'dart:math';

import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:rxdart/rxdart.dart';

class Leader {
  final String localizedNameKey;
  late Set<PerkUnit> _perks;

  int get level => experience ~/ levelDelta;
  double experience;
  final double levelDelta = 1000;
  static final levelUpBasePrice = 1000;
  late String imagePath;
  final BehaviorSubject _innerChanges = BehaviorSubject();
  late ValueStream changes;
  final int maxLevel = 3;
  static Money defaultAcquirePrice = Money(levelUpBasePrice.toDouble());

  Leader(this.localizedNameKey,
      {Set<PerkUnit>? affects, this.experience = 0, String? imagePath}) {
    if (affects == null) {
      _perks = Set();
    } else {
      _perks = affects;
    }

    if (imagePath == null) {
      this.imagePath = getRandomImage();
    } else {
      this.imagePath = imagePath;
    }

    changes = _innerChanges.stream;
  }

  static String getRandomImage() {
    final numbers = List.generate(11, (index) => index);
    return "images/leaders/leader${numbers.takeRandom()}.png";
  }

  int get availablePerks {
    return max(0, level - _perks.length);
  }

  Set<PerkUnit> get perks {
    return Set.from(_perks);
  }

  bool hasReachedMaxLevel() {
    return level >= maxLevel;
  }

  void addPerk(PerkUnit perk) {
    _perks.add(perk);
    _innerChanges.add(this);
  }

  double get nextLevelPrice {
    return (level + 1).toDouble() * levelUpBasePrice;
  }

  PerkUnit? perkFor({required RESOURCE_CATEGORY cat}) {
    try {
      return _perks.firstWhere((perk) => perk.affectsResourceCategory == cat);
    } on StateError catch (_) {
      return null;
    }
  }

  bool hasPerkForCategory(RESOURCE_CATEGORY cat) {
    return perkFor(cat: cat) != null;
  }

  String get fullLocalizedName {
    return "${ChumakiLocalizations.getForKey(localizedNameKey)}";
  }

  Map<String, dynamic> toJson() {
    return {
      "localizedKeyName": localizedNameKey,
      "affects": _perks.map((e) => e.toJson()).toList(),
      "level": level,
      "experience": experience,
      "imagePath": imagePath,
    };
  }

  static Leader fromJson(Map<String, dynamic> input) {
    final afs = input["affects"] as List;
    return Leader(
      input["localizedKeyName"],
      affects: afs.map((affectJson) => PerkUnit.fromJson(affectJson)).toSet(),
      experience: input["experience"],
      imagePath: input["imagePath"],
    );
  }

  static List<Leader> allLeaders() {
    List keyNames =
        LeadersLocalizations().localizedMap["en"]!.keys.take(11).toList();
    List<Leader> leaders = List.empty(growable: true);
    for (var i = 0; i < 11; i++) {
      leaders
          .add(Leader("leaders.${keyNames[i]}", imagePath: imagePathForId(i), experience: 2995));
    }
    return leaders;
  }

  void addExperience(int amount) {
    if (level < 3) {
      experience += amount;
    }
    _innerChanges.add(this);
  }
}

String imagePathForId(int id) {
  return "images/leaders/leader$id.png";
}

class PerkUnit {
  final RESOURCE_CATEGORY affectsResourceCategory;

  PerkUnit({
    required this.affectsResourceCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      "affectsResourceCategory":
          resourceCategoryToString(affectsResourceCategory),
    };
  }

  String toImagePath() {
    return categoryToImagePath(affectsResourceCategory);
  }

  static PerkUnit fromJson(Map<String, dynamic> input) {
    return PerkUnit(
        affectsResourceCategory:
            resourceCategoryFromString(input["affectsResourceCategory"]),
    );
  }
}
