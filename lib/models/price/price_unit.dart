import 'package:chumaki/models/resource.dart';

class PriceUnit {
  final RESOURCES resourceType;
  final double price;

  PriceUnit(this.resourceType, this.price);

  PriceUnit adjustToModifier(double mod) {
    return PriceUnit(this.resourceType, price * mod);
  }

  static PriceUnit defaultPriceUnitForResourceType(RESOURCES resType) {
    switch (resType) {
      case RESOURCES.BREAD:
        return PriceUnit(resType, 1);
      case RESOURCES.CANNON:
        return PriceUnit(resType, 500);
      case RESOURCES.CHARCOAL:
        return PriceUnit(resType, 8);
      case RESOURCES.FIREARM:
        return PriceUnit(resType, 20);
      case RESOURCES.FISH:
        return PriceUnit(resType, 2);
      case RESOURCES.FUR:
        return PriceUnit(resType, 5);
      case RESOURCES.GRAINS:
        return PriceUnit(resType, 0.8);
      case RESOURCES.HORSE:
        return PriceUnit(resType, 50);
      case RESOURCES.IRONORE:
        return PriceUnit(resType, 5);
      case RESOURCES.METALPARTS:
        return PriceUnit(resType, 10);
      case RESOURCES.PLANKS:
        return PriceUnit(resType, 12);
      case RESOURCES.POWDER:
        return PriceUnit(resType, 8);
      case RESOURCES.STONE:
        return PriceUnit(resType, 15);
      case RESOURCES.WOOD:
        return PriceUnit(resType, 2);
      case RESOURCES.SALT:
        return PriceUnit(resType, 6);
      case RESOURCES.SILK:
        return PriceUnit(resType, 20);
      case RESOURCES.WOOL:
        return PriceUnit(resType, 0.8);
      case RESOURCES.GORILKA:
        return PriceUnit(resType, 0.5);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "resourceType": resourceTypeToString(resourceType),
    };
  }

  static PriceUnit fromJson(Map<String,dynamic> input) {
    return PriceUnit(resourceTypeFromString(input["resourceType"]), input["price"]);
  }
}
