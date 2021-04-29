import 'package:chumaki/models/resources/resource_category.dart';
import 'package:flutter/material.dart';

enum RESOURCES {
  BREAD,
  CANNON,
  CHARCOAL,
  FIREARM,
  FISH,
  FUR,
  GRAINS,
  HORSE,
  IRONORE,
  METALPARTS,
  PLANKS,
  POWDER,
  SALT,
  SILK,
  STONE,
  WOOD,
  WOOL,
  GORILKA,
}

class Resource {
  final String localizedKey;
  final double weightPerPoint;
  final Color color;
  final RESOURCE_CATEGORY category;
  final RESOURCES type;
  int amount;

  Resource(this.localizedKey, this.amount,
      {this.weightPerPoint = 1,
      required this.type,
      this.color = Colors.white,
      required this.category});

  String get imagePath {
    return "images/resources/${this.localizedKey}/${this.localizedKey}.png";
  }

  Map<String, dynamic> toJson() {
    return {
      "type": resourceTypeToString(type),
      "amount": amount
    };
  }

  static Resource fromJson(Map<String, dynamic> input) {
    var type = resourceTypeFromString(input["type"]);
    var resource = Resource.fromType(type)..amount = input["amount"];
    return resource;
  }

  static Resource fromType(RESOURCES type) {
    switch (type) {
      case RESOURCES.BREAD:
        return Bread(0);
      case RESOURCES.CANNON:
        return Cannon(0);
      case RESOURCES.CHARCOAL:
        return Charcoal(0);
      case RESOURCES.FIREARM:
        return Firearm(0);
      case RESOURCES.FISH:
        return Fish(0);
      case RESOURCES.FUR:
        return Fur(0);
      case RESOURCES.GRAINS:
        return Grains(0);
      case RESOURCES.HORSE:
        return Horse(0);
      case RESOURCES.IRONORE:
        return IronOre(0);
      case RESOURCES.METALPARTS:
        return MetalParts(0);
      case RESOURCES.PLANKS:
        return Planks(0);
      case RESOURCES.POWDER:
        return Powder(0);
      case RESOURCES.STONE:
        return Stone(0);
      case RESOURCES.WOOD:
        return Wood(0);
      case RESOURCES.SALT:
        return Salt(0);
      case RESOURCES.SILK:
        return Silk(0);
      case RESOURCES.WOOL:
        return Wool(0);
      case RESOURCES.GORILKA:
        return Gorilka(0);
    }
  }

  bool sameType(Resource another) {
    return another.type == type;
  }

  @override
  bool operator ==(another) {
    if (another is! Resource) {
      return false;
    }
    return (another.localizedKey == localizedKey && another.amount == amount);
  }

  @override
  int get hashCode {
    return localizedKey.hashCode;
  }

  double get totalWeight {
    return (amount * weightPerPoint).floorToDouble();
  }

  Resource cloneWithAmount(int amount) {
    return Resource(
      localizedKey,
      amount,
      type: type,
      color: color,
      weightPerPoint: weightPerPoint,
      category: category,
    );
  }
}

class Wood extends Resource {
  Wood(int amount)
      : super("wood", amount,
            type: RESOURCES.WOOD,
            weightPerPoint: 0.5,
            color: Colors.brown[300]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Cannon extends Resource {
  Cannon(int amount)
      : super("cannon", amount,
            type: RESOURCES.CANNON,
            weightPerPoint: 4,
            color: Colors.grey,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Charcoal extends Resource {
  Charcoal(int amount)
      : super("charcoal", amount,
            type: RESOURCES.CHARCOAL,
            weightPerPoint: 0.2,
            color: Colors.black,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Firearm extends Resource {
  Firearm(int amount)
      : super("firearm", amount,
            weightPerPoint: 0.8,
            type: RESOURCES.FIREARM,
            color: Colors.black26,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Fish extends Resource {
  Fish(int amount)
      : super("fish", amount,
            type: RESOURCES.FISH,
            weightPerPoint: 0.1,
            color: Colors.blueGrey,
            category: RESOURCE_CATEGORY.FOOD);
}

class Bread extends Resource {
  Bread(int amount)
      : super("bread", amount,
            weightPerPoint: 0.1,
            type: RESOURCES.BREAD,
            color: Colors.amber,
            category: RESOURCE_CATEGORY.FOOD);
}

class Fur extends Resource {
  Fur(int amount)
      : super("fur", amount,
            type: RESOURCES.FUR,
            weightPerPoint: 0.3,
            color: Colors.black54,
            category: RESOURCE_CATEGORY.CLOTH);
}

class Grains extends Resource {
  Grains(int amount)
      : super("grains", amount,
            type: RESOURCES.GRAINS,
            weightPerPoint: 1,
            color: Colors.yellow,
            category: RESOURCE_CATEGORY.FOOD);
}

class Horse extends Resource {
  Horse(int amount)
      : super("horse", amount,
            type: RESOURCES.HORSE,
            weightPerPoint: 5,
            color: Colors.deepOrangeAccent,
            category: RESOURCE_CATEGORY.MILITARY);
}

class IronOre extends Resource {
  IronOre(int amount)
      : super("ironore", amount,
            type: RESOURCES.IRONORE,
            weightPerPoint: 1.5,
            color: Colors.orange,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class MetalParts extends Resource {
  MetalParts(int amount)
      : super("metalparts", amount,
            type: RESOURCES.METALPARTS,
            weightPerPoint: 2,
            color: Colors.lightBlueAccent,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Silk extends Resource {
  Silk(int amount)
      : super("silk", amount,
            type: RESOURCES.SILK,
            weightPerPoint: 0.3,
            color: Colors.yellow,
            category: RESOURCE_CATEGORY.LUXURY);
}

class Salt extends Resource {
  Salt(int amount)
      : super("salt", amount,
            type: RESOURCES.SALT,
            weightPerPoint: 0.2,
            color: Colors.white,
            category: RESOURCE_CATEGORY.FOOD);
}

class Wool extends Resource {
  Wool(int amount)
      : super("wool", amount,
            type: RESOURCES.WOOL,
            weightPerPoint: 0.2,
            color: Colors.green,
            category: RESOURCE_CATEGORY.CLOTH);
}

class Money {
  final String localizedKey = "money";
  double amount;

  Money(this.amount);

  String get imagePath {
    return "images/resources/${this.localizedKey}/${this.localizedKey}.png";
  }
}

class Planks extends Resource {
  Planks(int amount)
      : super("planks", amount,
            weightPerPoint: 1,
            type: RESOURCES.PLANKS,
            color: Colors.brown[700]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Powder extends Resource {
  Powder(int amount)
      : super("powder", amount,
            type: RESOURCES.POWDER,
            weightPerPoint: 0.8,
            color: Colors.brown[500]!,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Stone extends Resource {
  Stone(int amount)
      : super("stone", amount,
            type: RESOURCES.STONE,
            weightPerPoint: 5,
            color: Colors.black45,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Gorilka extends Resource {
  Gorilka(int amount)
      : super("gorilka", amount,
            type: RESOURCES.GORILKA,
            weightPerPoint: 5,
            color: Colors.black45,
            category: RESOURCE_CATEGORY.FOOD);
}

String resourceCategoryToLocalizedKey(RESOURCE_CATEGORY category) {
  switch (category) {
    case RESOURCE_CATEGORY.RESOURCES:
      return "resources.resources";
    case RESOURCE_CATEGORY.CLOTH:
      return "resources.cloths";
    case RESOURCE_CATEGORY.MILITARY:
      return "resources.military";
    case RESOURCE_CATEGORY.FOOD:
      return "resources.food";
    case RESOURCE_CATEGORY.LUXURY:
      return "resources.luxury";
  }
}

List<List<Resource>> groupResourcesByCategory(List<Resource> resources) {
  List<List<Resource>> result = resources.fold([], (result, current) {
    if (result.isEmpty) {
      return [
        [current]
      ];
    } else {
      for (var i = 0; i < result.length; i++) {
        var group = result[i];
        if (group.first.category == current.category) {
          group.add(current);
          return result;
        }
      }
      result.add([current]);
      return result;
    }
  });
  return result;
}

String resourceTypeToString(RESOURCES type) {
  switch (type) {
    case RESOURCES.BREAD:
      return "bread";
    case RESOURCES.CANNON:
      return "cannon";
    case RESOURCES.CHARCOAL:
      return "charcoal";
    case RESOURCES.FIREARM:
      return "firearm";
    case RESOURCES.FISH:
      return "fish";
    case RESOURCES.FUR:
      return "fur";
    case RESOURCES.GRAINS:
      return "grains";
    case RESOURCES.HORSE:
      return "horse";
    case RESOURCES.IRONORE:
      return "ironore";
    case RESOURCES.METALPARTS:
      return "metalparts";
    case RESOURCES.PLANKS:
      return "planks";
    case RESOURCES.POWDER:
      return "powder";
    case RESOURCES.SALT:
      return "salt";
    case RESOURCES.SILK:
      return "silk";
    case RESOURCES.STONE:
      return "stone";
    case RESOURCES.WOOD:
      return "wood";
    case RESOURCES.WOOL:
      return "wool";
    case RESOURCES.GORILKA:
      return "gorilka";
  }
}

RESOURCES resourceTypeFromString(String type) {
  switch (type) {
    case "bread":
      return RESOURCES.BREAD;
    case "cannon":
      return RESOURCES.CANNON;
    case "charcoal":
      return RESOURCES.CHARCOAL;
    case "firearm":
      return RESOURCES.FIREARM;
    case "fish":
      return RESOURCES.FISH;
    case "fur":
      return RESOURCES.FUR;
    case "grains":
      return RESOURCES.GRAINS;
    case "horse":
      return RESOURCES.HORSE;
    case "ironore":
      return RESOURCES.IRONORE;
    case "metalparts":
      return RESOURCES.METALPARTS;
    case "planks":
      return RESOURCES.PLANKS;
    case "powder":
      return RESOURCES.POWDER;
    case "salt":
      return RESOURCES.SALT;
    case "silk":
      return RESOURCES.SILK;
    case "stone":
      return RESOURCES.STONE;
    case "wood":
      return RESOURCES.WOOD;
    case "wool":
      return RESOURCES.WOOL;
    case "gorilka":
      return RESOURCES.GORILKA;
    default:
      throw "Resource type string $type is not recognized.";
  }
}
