import 'package:chumaki/models/resources/resource.dart';

class Leader {
  final String localizedKeyName;
  final Set<AffectUnit> affects;

  Leader(this.localizedKeyName, {required this.affects});

  AffectUnit? affectFor({required Resource resource}) {
    return affects.firstWhere((affect) => affect.affectsResource == resource.type);
  }

  bool doesAffectResource(Resource resource) {
    return affectFor(resource: resource) != null;
  }

  double affectSellValueForResource(Resource resource) {
    final affect = affectFor(resource: resource);
    if (affect == null) {
      return 1;
    } else {
      return affect.sellValue;
    }
  }

  double affectBuyValueForResource(Resource resource) {
    final affect = affectFor(resource: resource);
    if (affect == null) {
      return 1;
    } else {
      return affect.buyValue;
    }
  }
}

class AffectUnit {
  final RESOURCES affectsResource;
  final double sellValue;
  final double buyValue;

  AffectUnit({required this.affectsResource, required this.sellValue, required this.buyValue});
}