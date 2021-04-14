class Resource {
  final String localizedKey;
  int amount;
  Resource(this.localizedKey, this.amount);

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

}

class Wood extends Resource {
  Wood(int amount): super("wood", amount);
}

class Cannon extends Resource {
  Cannon(int amount): super("cannon", amount);
}

class Charcoal extends Resource {
  Charcoal(int amount): super("charcoal", amount);
}

class Firearm extends Resource {
  Firearm(int amount): super("firearm", amount);
}

class Fish extends Resource {
  Fish(int amount): super("fish", amount);
}

class Food extends Resource {
  Food(int amount): super("food", amount);
}

class Fur extends Resource {
  Fur(int amount): super("fur", amount);
}

class Grains extends Resource {
  Grains(int amount): super("grains", amount);
}

class Horse extends Resource {
  Horse(int amount): super("horse", amount);
}

class IronOre extends Resource {
  IronOre(int amount): super("ironore", amount);
}

class MetalParts extends Resource {
  MetalParts(int amount): super("metalparts", amount);
}

class Money extends Resource {
  Money(int amount): super("money", amount);
}

class Planks extends Resource {
  Planks(int amount): super("planks", amount);
}

class Powder extends Resource {
  Powder(int amount): super("powder", amount);
}

class Stone extends Resource {
  Stone(int amount): super("stone", amount);
}






