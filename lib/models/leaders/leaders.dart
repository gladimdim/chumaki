import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Leader {
  final String localizedKeyName;
  late Set<AffectUnit> _affects;
  double level;
  double experience;
  final double _levelDelta = 1000;
  final levelUpBasePrice = 1000;

  static Money defaultAcquirePrice = Money(1000);

  Leader(this.localizedKeyName,
      {Set<AffectUnit>? affects, this.level = 0, this.experience = 0}) {
    if (affects == null) {
      _affects = Set();
    } else {
      _affects = affects;
    }
  }

  Set<AffectUnit> get affects {
    return Set.from(_affects);
  }

  void addAffect(AffectUnit affect) {
    _affects.add(affect);
  }

  bool levelUp() {
    if (level <= 3 && experience < (level + 1) * _levelDelta) {
      return false;
    } else {
      level++;
      return true;
    }
  }

  double get nextLevelPrice {
    return (level + 1) * levelUpBasePrice;
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

  Map<String, dynamic> toJson() {
    return {
      "localizedKeyName": localizedKeyName,
      "affects": _affects.map((e) => e.toJson()).toList(),
      "level": level,
      "experience": experience,
    };
  }

  static Leader fromJson(Map<String, dynamic> input) {
    final afs = input["affects"] as List;
    return Leader(
      input["localizedKeyName"],
      affects: afs.map((affectJson) => AffectUnit.fromJson(affectJson)).toSet(),
      level: input["level"],
      experience: input["experience"],
    );
  }
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
