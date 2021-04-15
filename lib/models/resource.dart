class Resource {
  final String localizedKey;
  final double weightPerPoint ;
  int amount;
  Resource(this.localizedKey, this.amount, {this.weightPerPoint = 1});

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

  Resource cloneWithAmount(int amount) {
    return Resource(localizedKey, amount);
  }

}

class Wood extends Resource {
  Wood(int amount): super("wood", amount, weightPerPoint: 0.5);
}

class Cannon extends Resource {
  Cannon(int amount): super("cannon", amount, weightPerPoint: 4);
}

class Charcoal extends Resource {
  Charcoal(int amount): super("charcoal", amount, weightPerPoint: 0.2);
}

class Firearm extends Resource {
  Firearm(int amount): super("firearm", amount, weightPerPoint: 0.8);
}

class Fish extends Resource {
  Fish(int amount): super("fish", amount, weightPerPoint: 0.1);
}

class Food extends Resource {
  Food(int amount): super("food", amount, weightPerPoint: 0.1);
}

class Fur extends Resource {
  Fur(int amount): super("fur", amount, weightPerPoint: 0.3);
}

class Grains extends Resource {
  Grains(int amount): super("grains", amount, weightPerPoint: 1);
}

class Horse extends Resource {
  Horse(int amount): super("horse", amount, weightPerPoint: 5);
}

class IronOre extends Resource {
  IronOre(int amount): super("ironore", amount, weightPerPoint: 1.5);
}

class MetalParts extends Resource {
  MetalParts(int amount): super("metalparts", amount, weightPerPoint: 2);
}

class Money extends Resource {
  Money(int amount): super("money", amount);
}

class Planks extends Resource {
  Planks(int amount): super("planks", amount, weightPerPoint: 1);
}

class Powder extends Resource {
  Powder(int amount): super("powder", amount, weightPerPoint: 0.8);
}

class Stone extends Resource {
  Stone(int amount): super("stone", amount, weightPerPoint: 5);
}






