import 'dart:math';

import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/extensions/list.dart';

class Leader {
  final String localizedNameKey;
  late Set<PerkUnit> _perks;

  int get level => experience ~/ levelDelta;
  double experience;
  final double levelDelta = 1000;
  static final levelUpBasePrice = 1000;
  late String imagePath;
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

  void addPerk(PerkUnit perk) {
    _perks.add(perk);
  }

  double get nextLevelPrice {
    return (level + 1).toDouble() * levelUpBasePrice;
  }

  PerkUnit? perkFor({required Resource resource}) {
    try {
      return _perks
          .firstWhere((perk) => perk.affectsResource == resource.type);
    } on StateError catch (_) {
      return null;
    }
  }

  bool doesAffectResource(Resource resource) {
    return perkFor(resource: resource) != null;
  }

  double affectSellValueForResource(
      {required Resource resource, required PriceUnit priceUnit}) {
    final affect = perkFor(resource: resource);
    final value = affect?.sellValue;
    return affectValueForResource(
        resource: resource, priceUnit: priceUnit, value: value);
  }

  double affectBuyValueForResource(
      {required Resource resource, required PriceUnit priceUnit}) {
    final affect = perkFor(resource: resource);
    final value = affect?.buyValue;
    return affectValueForResource(
        resource: resource, priceUnit: priceUnit, value: value);
  }

  double affectValueForResource(
      {required Resource resource,
      required PriceUnit priceUnit,
      double? value}) {
    if (value == null) {
      return priceUnit.price * resource.amount.toDouble();
    } else {
      return _adjustedPriceToAffect(
          value, resource.amount.toDouble(), priceUnit.price);
    }
  }

  double _adjustedPriceToAffect(double value, double amount, double price) {
    return (price * amount * value).roundToDouble();
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
          .add(Leader("leaders.${keyNames[i]}", imagePath: imagePathForId(i)));
    }
    return leaders;
  }

  void addExperience(int amount) {
    // TODO: REMOVE
    var oldLevel = level;
    if (level < 3) {
      experience += amount;
    }
    var newLevel = level;
    if (newLevel != oldLevel) {
      _perks.add(PerkUnit(
          affectsResource: RESOURCES.GORILKA, sellValue: 1.1, buyValue: 0.9));
    }
  }
}

String imagePathForId(int id) {
  return "images/leaders/leader$id.png";
}

class PerkUnit {
  final RESOURCES affectsResource;
  final double sellValue;
  final double buyValue;

  PerkUnit(
      {required this.affectsResource,
      required this.sellValue,
      required this.buyValue});

  Map<String, dynamic> toJson() {
    return {
      "sellValue": sellValue,
      "buyValue": buyValue,
      "affectsResource": resourceTypeToString(affectsResource),
    };
  }

  static PerkUnit fromJson(Map<String, dynamic> input) {
    return PerkUnit(
        affectsResource: resourceTypeFromString(input["affectsResource"]),
        sellValue: input["sellValue"],
        buyValue: input["buyValue"]);
  }
}
