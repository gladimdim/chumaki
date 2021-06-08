import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/bila_tserkva.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/korsun.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/lviv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/uman.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
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
  WAX,
  HONEY,
  TOBACCO,
  AMBER,
  CLOTH,
}

class Resource {
  final String localizedKey;
  final double weightPerPoint;
  final Color color;
  final RESOURCE_CATEGORY category;
  final RESOURCES type;
  late final List<City> productionCenters;
  int amount;

  Resource(this.localizedKey, this.amount,
      {this.weightPerPoint = 1,
      required this.type,
      this.color = Colors.white,
      required this.productionCenters,
      required this.category});

  String get imagePath {
    return "images/resources/${this.localizedKey}/${this.localizedKey}.png";
  }

  String get fullLocalizedKey {
    return "resources.$localizedKey";
  }

  Map<String, dynamic> toJson() {
    return {"type": resourceTypeToString(type), "amount": amount};
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
      case RESOURCES.HONEY:
        return Honey(0);
      case RESOURCES.WAX:
        return Wax(0);
      case RESOURCES.TOBACCO:
        return Tobacco(0);
      case RESOURCES.AMBER:
        return Amber(0);
      case RESOURCES.CLOTH:
        return Cloth(0);
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
      productionCenters: List.from(productionCenters),
    );
  }

  static List<Resource> allResources() {
    return RESOURCES.values.map((resType) => Resource.fromType(resType)).toList();
  }

  static List<City> productionCenter({required Resource forResource}) {
    return allResources().firstWhere((resource) => resource.sameType(forResource)).productionCenters;
  }

}

class Wood extends Resource {
  Wood(int amount)
      : super("wood", amount,
            productionCenters: [Chernigiv()],
            type: RESOURCES.WOOD,
            weightPerPoint: 0.5,
            color: Colors.brown[300]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Cannon extends Resource {
  Cannon(int amount)
      : super("cannon", amount,
            productionCenters: [Lviv()],
            type: RESOURCES.CANNON,
            weightPerPoint: 4,
            color: Colors.grey,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Charcoal extends Resource {
  Charcoal(int amount)
      : super("charcoal", amount,
            productionCenters: [Chernigiv()],
            type: RESOURCES.CHARCOAL,
            weightPerPoint: 0.2,
            color: Colors.black,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Firearm extends Resource {
  Firearm(int amount)
      : super("firearm", amount,
            productionCenters: [Lviv()],
            weightPerPoint: 0.8,
            type: RESOURCES.FIREARM,
            color: Colors.black26,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Fish extends Resource {
  Fish(int amount)
      : super("fish", amount,
            productionCenters: [Sich()],
            type: RESOURCES.FISH,
            weightPerPoint: 0.1,
            color: Colors.blueGrey,
            category: RESOURCE_CATEGORY.FOOD);
}

class Bread extends Resource {
  Bread(int amount)
      : super("bread", amount,
            productionCenters: [Vinnitsa()],
            weightPerPoint: 0.1,
            type: RESOURCES.BREAD,
            color: Colors.amber,
            category: RESOURCE_CATEGORY.FOOD);
}

class Cloth extends Resource {
  Cloth(int amount)
      : super("cloth", amount,
            productionCenters: [Nizhin()],
            weightPerPoint: 0.3,
            type: RESOURCES.CLOTH,
            color: Colors.grey[600]!,
            category: RESOURCE_CATEGORY.CLOTHS);
}

class Fur extends Resource {
  Fur(int amount)
      : super("fur", amount,
            productionCenters: [Chigirin()],
            type: RESOURCES.FUR,
            weightPerPoint: 0.3,
            color: Colors.black54,
            category: RESOURCE_CATEGORY.CLOTHS);
}

class Grains extends Resource {
  Grains(int amount)
      : super("grains", amount,
            productionCenters: [BilaTserkva()],
            type: RESOURCES.GRAINS,
            weightPerPoint: 1,
            color: Colors.yellow,
            category: RESOURCE_CATEGORY.FOOD);
}

class Horse extends Resource {
  Horse(int amount)
      : super("horse", amount,
            productionCenters: [Pereyaslav()],
            type: RESOURCES.HORSE,
            weightPerPoint: 5,
            color: Colors.deepOrangeAccent,
            category: RESOURCE_CATEGORY.MILITARY);
}

class IronOre extends Resource {
  IronOre(int amount)
      : super("ironore", amount,
            productionCenters: [Berdychiv()],
            type: RESOURCES.IRONORE,
            weightPerPoint: 1.5,
            color: Colors.orange,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class MetalParts extends Resource {
  MetalParts(int amount)
      : super("metalparts", amount,
            productionCenters: [Zhytomir()],
            type: RESOURCES.METALPARTS,
            weightPerPoint: 2,
            color: Colors.lightBlueAccent,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Silk extends Resource {
  Silk(int amount)
      : super("silk", amount,
            productionCenters: [Ochakiv()],
            type: RESOURCES.SILK,
            weightPerPoint: 0.3,
            color: Colors.yellow,
            category: RESOURCE_CATEGORY.LUXURY);
}

class Salt extends Resource {
  Salt(int amount)
      : super("salt", amount,
            productionCenters: [Ochakiv()],
            type: RESOURCES.SALT,
            weightPerPoint: 0.2,
            color: Colors.white,
            category: RESOURCE_CATEGORY.FOOD);
}

class Wool extends Resource {
  Wool(int amount)
      : super("wool", amount,
            productionCenters: [Korsun()],
            type: RESOURCES.WOOL,
            weightPerPoint: 0.2,
            color: Colors.green,
            category: RESOURCE_CATEGORY.CLOTHS);
}

class Money {
  final String localizedKey = "money";
  final double amount;

  const Money(this.amount);

  String get imagePath {
    return "images/resources/${this.localizedKey}/${this.localizedKey}.png";
  }
}

class Planks extends Resource {
  Planks(int amount)
      : super("planks", amount,
            productionCenters: [Nizhin()],
            weightPerPoint: 1,
            type: RESOURCES.PLANKS,
            color: Colors.brown[700]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Powder extends Resource {
  Powder(int amount)
      : super("powder", amount,
            productionCenters: [Sich()],
            type: RESOURCES.POWDER,
            weightPerPoint: 0.8,
            color: Colors.brown[500]!,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Stone extends Resource {
  Stone(int amount)
      : super("stone", amount,
            productionCenters: [Uman()],
            type: RESOURCES.STONE,
            weightPerPoint: 5,
            color: Colors.black45,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Gorilka extends Resource {
  Gorilka(int amount)
      : super("gorilka", amount,
            productionCenters: [Ostrog()],
            type: RESOURCES.GORILKA,
            weightPerPoint: 0.3,
            color: Colors.grey,
            category: RESOURCE_CATEGORY.FOOD);
}

class Wax extends Resource {
  Wax(int amount)
      : super("wax", amount,
            productionCenters: [Kyiv()],
            type: RESOURCES.WAX,
            weightPerPoint: 0.3,
            color: Colors.brown[400]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Honey extends Resource {
  Honey(int amount)
      : super("honey", amount,
            productionCenters: [Kaniv()],
            type: RESOURCES.HONEY,
            weightPerPoint: 0.8,
            color: Colors.brown[800]!,
            category: RESOURCE_CATEGORY.FOOD);
}

class Amber extends Resource {
  Amber(int amount)
      : super("amber", amount,
            productionCenters: [Zhytomir()],
            type: RESOURCES.AMBER,
            weightPerPoint: 1.5,
            color: Colors.brown[200]!,
            category: RESOURCE_CATEGORY.LUXURY);
}

class Tobacco extends Resource {
  Tobacco(int amount)
      : super("tobacco", amount,
      productionCenters: [Ochakiv()],
            type: RESOURCES.TOBACCO,
            weightPerPoint: 0.2,
            color: Colors.yellow[600]!,
            category: RESOURCE_CATEGORY.LUXURY);
}

String resourceCategoryToLocalizedKey(RESOURCE_CATEGORY category) {
  switch (category) {
    case RESOURCE_CATEGORY.RESOURCES:
      return "resources.resources";
    case RESOURCE_CATEGORY.CLOTHS:
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
    case RESOURCES.HONEY:
      return "honey";
    case RESOURCES.WAX:
      return "wax";
    case RESOURCES.TOBACCO:
      return "tobacco";
    case RESOURCES.AMBER:
      return "amber";
    case RESOURCES.CLOTH:
      return "cloth";
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
    case "wax":
      return RESOURCES.WAX;
    case "honey":
      return RESOURCES.HONEY;
    case "tobacco":
      return RESOURCES.TOBACCO;
    case "amber":
      return RESOURCES.AMBER;
    case "cloth":
      return RESOURCES.CLOTH;
    default:
      throw "Resource type string $type is not recognized.";
  }
}
