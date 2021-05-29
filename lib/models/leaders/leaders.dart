import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/extensions/list.dart';

class Leader {
  final String localizedNameKey;
  late Set<AffectUnit> _affects;
  int get level => experience ~/ _levelDelta;
  double experience;
  final double _levelDelta = 1000;
  final levelUpBasePrice = 1000;
  late String imagePath;
  static Money defaultAcquirePrice = Money(1000);

  Leader(this.localizedNameKey,
      {Set<AffectUnit>? affects, this.experience = 0, String? imagePath}) {
    if (affects == null) {
      _affects = Set();
    } else {
      _affects = affects;
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

  Set<AffectUnit> get affects {
    return Set.from(_affects);
  }

  void addAffect(AffectUnit affect) {
    _affects.add(affect);
  }

  double get nextLevelPrice {
    return (level + 1).toDouble() * levelUpBasePrice;
  }

  AffectUnit? affectFor({required Resource resource}) {
    try {
      return _affects
          .firstWhere((affect) => affect.affectsResource == resource.type);
    } on StateError catch (_) {
      return null;
    }
  }

  bool doesAffectResource(Resource resource) {
    return affectFor(resource: resource) != null;
  }

  double affectSellValueForResource(
      {required Resource resource, required PriceUnit priceUnit}) {
    final affect = affectFor(resource: resource);
    final value = affect?.sellValue;
    return affectValueForResource(
        resource: resource, priceUnit: priceUnit, value: value);
  }

  double affectBuyValueForResource(
      {required Resource resource, required PriceUnit priceUnit}) {
    final affect = affectFor(resource: resource);
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
      "affects": _affects.map((e) => e.toJson()).toList(),
      "level": level,
      "experience": experience,
      "imagePath": imagePath,
    };
  }

  static Leader fromJson(Map<String, dynamic> input) {
    final afs = input["affects"] as List;
    return Leader(
      input["localizedKeyName"],
      affects: afs.map((affectJson) => AffectUnit.fromJson(affectJson)).toSet(),
      experience: input["experience"],
      imagePath: input["imagePath"],
    );
  }
  
  static List<Leader> allLeaders() {
    List keyNames = LeadersLocalizations().localizedMap["en"]!.keys.take(11).toList();
    List<Leader> leaders = List.empty(growable: true);
    for (var i = 0; i < 11; i++) {
      leaders.add(Leader("leaders.${keyNames[i]}", imagePath: imagePathForId(i)));
    }
    return leaders;
  }

  void addExperience(int amount) {
    experience += amount;
  }
}

String imagePathForId(int id) {
  return "images/leaders/leader$id.png";
}

class AffectUnit {
  final RESOURCES affectsResource;
  final double sellValue;
  final double buyValue;

  AffectUnit(
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

  static AffectUnit fromJson(Map<String, dynamic> input) {
    return AffectUnit(
        affectsResource: resourceTypeFromString(input["affectsResource"]),
        sellValue: input["sellValue"],
        buyValue: input["buyValue"]);
  }
}
