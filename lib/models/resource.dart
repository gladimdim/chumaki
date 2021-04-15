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
  Wood(int amount): super("wood", amount, weightPerPoint: 3);
}

class Cannon extends Resource {
  Cannon(int amount): super("cannon", amount, weightPerPoint: 40);
}

class Charcoal extends Resource {
  Charcoal(int amount): super("charcoal", amount, weightPerPoint: 0.5);
}

class Firearm extends Resource {
  Firearm(int amount): super("firearm", amount, weightPerPoint: 2.0);
}

class Fish extends Resource {
  Fish(int amount): super("fish", amount, weightPerPoint: 0.3);
}

class Food extends Resource {
  Food(int amount): super("food", amount, weightPerPoint: 1);
}

class Fur extends Resource {
  Fur(int amount): super("fur", amount, weightPerPoint: 2);
}

class Grains extends Resource {
  Grains(int amount): super("grains", amount, weightPerPoint: 3);
}

class Horse extends Resource {
  Horse(int amount): super("horse", amount, weightPerPoint: 50);
}

class IronOre extends Resource {
  IronOre(int amount): super("ironore", amount, weightPerPoint: 10);
}

class MetalParts extends Resource {
  MetalParts(int amount): super("metalparts", amount, weightPerPoint: 15);
}

class Money extends Resource {
  Money(int amount): super("money", amount);
}

class Planks extends Resource {
  Planks(int amount): super("planks", amount, weightPerPoint: 3);
}

class Powder extends Resource {
  Powder(int amount): super("powder", amount, weightPerPoint: 0.5);
}

class Stone extends Resource {
  Stone(int amount): super("stone", amount, weightPerPoint: 15);
}






