import 'package:flutter/material.dart';

enum RESOURCE_CATEGORY { MILITARY, CLOTH, RESOURCES, LUXURY, FOOD }

class Resource {
  final String localizedKey;
  final double weightPerPoint;
  final Color color;
  final RESOURCE_CATEGORY category;
  int amount;

  Resource(this.localizedKey, this.amount,
      {this.weightPerPoint = 1,
      this.color = Colors.white,
      required this.category});

  String get imagePath {
    return "images/resources/${this.localizedKey}/${this.localizedKey}.png";
  }

  bool sameType(Resource another) {
    return another.localizedKey == localizedKey;
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
      color: color,
      weightPerPoint: weightPerPoint,
      category: category,
    );
  }

  static List<Resource> get allResources {
    return [
      Wood(0),
      Cannon(0),
      Charcoal(0),
      Firearm(0),
      Fish(0),
      Bread(0),
      Fur(0),
      Grains(0),
      Horse(0),
      IronOre(0),
      MetalParts(0),
      Planks(0),
      Powder(0),
      Stone(0),
    ];
  }
}

class Wood extends Resource {
  Wood(int amount)
      : super("wood", amount,
            weightPerPoint: 0.5,
            color: Colors.brown[300]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Cannon extends Resource {
  Cannon(int amount)
      : super("cannon", amount,
            weightPerPoint: 4,
            color: Colors.grey,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Charcoal extends Resource {
  Charcoal(int amount)
      : super("charcoal", amount,
            weightPerPoint: 0.2,
            color: Colors.black,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Firearm extends Resource {
  Firearm(int amount)
      : super("firearm", amount,
            weightPerPoint: 0.8,
            color: Colors.black26,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Fish extends Resource {
  Fish(int amount)
      : super("fish", amount,
            weightPerPoint: 0.1,
            color: Colors.blueGrey,
            category: RESOURCE_CATEGORY.FOOD);
}

class Bread extends Resource {
  Bread(int amount)
      : super("bread", amount,
            weightPerPoint: 0.1,
            color: Colors.amber,
            category: RESOURCE_CATEGORY.FOOD);
}

class Fur extends Resource {
  Fur(int amount)
      : super("fur", amount,
            weightPerPoint: 0.3,
            color: Colors.black54,
            category: RESOURCE_CATEGORY.CLOTH);
}

class Grains extends Resource {
  Grains(int amount)
      : super("grains", amount,
            weightPerPoint: 1,
            color: Colors.yellow,
            category: RESOURCE_CATEGORY.FOOD);
}

class Horse extends Resource {
  Horse(int amount)
      : super("horse", amount,
            weightPerPoint: 5,
            color: Colors.deepOrangeAccent,
            category: RESOURCE_CATEGORY.MILITARY);
}

class IronOre extends Resource {
  IronOre(int amount)
      : super("ironore", amount,
            weightPerPoint: 1.5,
            color: Colors.orange,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class MetalParts extends Resource {
  MetalParts(int amount)
      : super("metalparts", amount,
            weightPerPoint: 2,
            color: Colors.lightBlueAccent,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Money extends Resource {
  Money(int amount)
      : super("money", amount, category: RESOURCE_CATEGORY.RESOURCES);
}

class Planks extends Resource {
  Planks(int amount)
      : super("planks", amount,
            weightPerPoint: 1,
            color: Colors.brown[700]!,
            category: RESOURCE_CATEGORY.RESOURCES);
}

class Powder extends Resource {
  Powder(int amount)
      : super("powder", amount,
            weightPerPoint: 0.8,
            color: Colors.brown[500]!,
            category: RESOURCE_CATEGORY.MILITARY);
}

class Stone extends Resource {
  Stone(int amount)
      : super("stone", amount,
            weightPerPoint: 5,
            color: Colors.black45,
            category: RESOURCE_CATEGORY.RESOURCES);
}

String resourceCategoryToString(RESOURCE_CATEGORY category) {
  switch (category) {
    case RESOURCE_CATEGORY.RESOURCES: return "Ресурси";
    case RESOURCE_CATEGORY.CLOTH: return "Одяг";
    case RESOURCE_CATEGORY.MILITARY: return "Військове";
    case RESOURCE_CATEGORY.FOOD: return "Їжа";
    case RESOURCE_CATEGORY.LUXURY: return "Коштовності";
  }
}
