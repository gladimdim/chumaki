import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Leader {
  final String localizedKeyName;
  late Set<AffectUnit> _affects;
  double level;
  double experience;
  final double _levelDelta = 1000;
  final levelUpBasePrice = 1000;
  Leader(this.localizedKeyName, {Set<AffectUnit>? affects, this.level = 0, this.experience = 0}) {
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
      return _affects.firstWhere((affect) =>
      affect.affectsResource == resource.type);
    } on StateError catch (_) {
      return null;
    }
  }

  bool doesAffectResource(Resource resource) {
    return affectFor(resource: resource) != null;
  }

  double affectSellValueForResource({required Resource resource, required PriceUnit priceUnit} ) {
    final affect = affectFor(resource: resource);
    final value = affect?.sellValue;
    return affectValueForResource(resource: resource, priceUnit: priceUnit, value: value);

  }
  double affectBuyValueForResource({required Resource resource, required PriceUnit priceUnit}) {
    final affect = affectFor(resource: resource);
    final value = affect?.buyValue;
    return affectValueForResource(resource: resource, priceUnit: priceUnit, value: value);
  }

  double affectValueForResource({required Resource resource, required PriceUnit priceUnit, double? value}) {
    if (value == null) {
      return priceUnit.price * resource.amount.toDouble();
    } else {
      return _adjustedPriceToAffect(priceUnit.price, resource.amount.toDouble(), value);
    }
  }

  double _adjustedPriceToAffect(double value, double amount, double price) {
    return (price * amount * value).roundToDouble();
  }
}

class AffectUnit {
  final RESOURCES affectsResource;
  final double sellValue;
  final double buyValue;

  AffectUnit({required this.affectsResource, required this.sellValue, required this.buyValue});
}