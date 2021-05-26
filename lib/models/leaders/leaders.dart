import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';

class Leader {
  final String localizedKeyName;
  final Set<AffectUnit> affects;
  double level;
  double experience;
  final double _levelDelta = 1000;
  final double _levelIncreaseAffect = 0.15;
  final levelUpBasePrice = 1000;
  Leader(this.localizedKeyName, {required this.affects, this.level = 0, this.experience = 0});


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
      return affects.firstWhere((affect) =>
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
    if (affect == null) {
      return priceUnit.price * resource.amount;
    } else {
      final priceWithoutLevel = priceUnit.price * affect.sellValue * resource.amount;
      return adjustToLevel(priceWithoutLevel);
    }
  }

  double adjustToLevel(double value) {
    return _levelIncreaseAffect * level * value + value;
  }

  double affectBuyValueForResource(Resource resource) {
    final affect = affectFor(resource: resource);
    if (affect == null) {
      return 1;
    } else {
      return affect.buyValue + affect.sellValue * level / 100;
    }
  }
}

class AffectUnit {
  final RESOURCES affectsResource;
  final double sellValue;
  final double buyValue;

  AffectUnit({required this.affectsResource, required this.sellValue, required this.buyValue});
}