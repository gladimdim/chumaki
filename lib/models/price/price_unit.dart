import 'package:chumaki/models/resources/resource.dart';

class PriceUnit {
  final Resource resource;
  final double price;
  final double _buyPriceAdjust = 0.85;

  PriceUnit(this.resource, this.price);

  PriceUnit adjustToModifier(double mod) {
    return PriceUnit(this.resource, price * mod);
  }

  double buyPriceForResource({int? withAmount}) {
    if (withAmount == null) {
      withAmount = resource.amount;
    }
    return double.parse((price * withAmount).toStringAsFixed(1));
  }

  double sellPriceForResource({int? withAmount}) {
    if (withAmount == null) {
      withAmount = resource.amount;
    }
    return double.parse(
        (price * withAmount * _buyPriceAdjust).toStringAsFixed(1));
  }

  static PriceUnit defaultPriceUnitForResourceType(RESOURCES resType) {
    switch (resType) {
      case RESOURCES.BREAD:
        return PriceUnit(Resource.fromType(resType), 0.8);
      case RESOURCES.CANNON:
        return PriceUnit(Resource.fromType(resType), 100);
      case RESOURCES.CHARCOAL:
        return PriceUnit(Resource.fromType(resType), 3);
      case RESOURCES.FIREARM:
        return PriceUnit(Resource.fromType(resType), 5);
      case RESOURCES.FISH:
        return PriceUnit(Resource.fromType(resType), 2);
      case RESOURCES.FUR:
        return PriceUnit(Resource.fromType(resType), 5);
      case RESOURCES.GRAINS:
        return PriceUnit(Resource.fromType(resType), 0.8);
      case RESOURCES.HORSE:
        return PriceUnit(Resource.fromType(resType), 10);
      case RESOURCES.IRONORE:
        return PriceUnit(Resource.fromType(resType), 2);
      case RESOURCES.METALPARTS:
        return PriceUnit(Resource.fromType(resType), 4);
      case RESOURCES.PLANKS:
        return PriceUnit(Resource.fromType(resType), 4);
      case RESOURCES.POWDER:
        return PriceUnit(Resource.fromType(resType), 8);
      case RESOURCES.STONE:
        return PriceUnit(Resource.fromType(resType), 5);
      case RESOURCES.WOOD:
        return PriceUnit(Resource.fromType(resType), 2);
      case RESOURCES.SALT:
        return PriceUnit(Resource.fromType(resType), 6);
      case RESOURCES.SILK:
        return PriceUnit(Resource.fromType(resType), 10);
      case RESOURCES.WOOL:
        return PriceUnit(Resource.fromType(resType), 0.8);
      case RESOURCES.GORILKA:
        return PriceUnit(Resource.fromType(resType), 0.5);
      case RESOURCES.WAX:
        return PriceUnit(Resource.fromType(resType), 0.3);
      case RESOURCES.HONEY:
        return PriceUnit(Resource.fromType(resType), 0.4);
      case RESOURCES.TOBACCO:
        return PriceUnit(Resource.fromType(resType), 1.5);
      case RESOURCES.AMBER:
        return PriceUnit(Resource.fromType(resType), 3);
      case RESOURCES.CLOTH:
        return PriceUnit(Resource.fromType(resType), 1);
    }
  }
}
