import 'package:chumaki/models/resources/resource.dart';

class Manufacturing {
  final String localizedKey;
  final Resource produces;
  bool built;
  final Money priceToBuild;
  int level;
  final int maxLevel = 3;

  Manufacturing({
    required this.localizedKey,
    required this.produces,
    this.built = false,
    required this.priceToBuild,
    this.level = 1,
  });

  String get imagePath =>
      "images/manufacturings/$localizedKey/${localizedKey}_$level.png";

  String get iconPath => "images/manufacturings/$localizedKey.png";

  String get fullLocalizedKey => "manufacturings.$localizedKey";

  Map<String, dynamic> toJson() {
    return {
      "localizedKey": localizedKey,
      "produces": produces.toJson(),
      "built": built,
      "priceToBuild": priceToBuild.amount,
      "level": level,
    };
  }

  static Manufacturing fromJson(Map<String, dynamic> inputJson) {
    return Manufacturing(
      priceToBuild: Money(inputJson["priceToBuild"]),
      localizedKey: inputJson["localizedKey"],
      produces: Resource.fromJson(inputJson["produces"]),
      built: inputJson["built"],
      level: inputJson["level"],
    );
  }

  static List<Manufacturing> get allManufacturings => [
        Manufacturing(
          localizedKey: "river",
          produces: Fish(100),
          priceToBuild: Money(200),
        ),
        Manufacturing(
          localizedKey: "powder_cellar",
          produces: Powder(20),
          priceToBuild: Money(1000),
        ),
      ];

  bool canUpgrade() {
    return built && level < maxLevel;
  }

  void upgrade() {
    if (canUpgrade()) {
      level++;
    }
  }

  Resource replenishResource() {
    return produces.cloneWithAmount(
      (produces.amount + (level - 1) * 0.5 * produces.amount).toInt(),
    );
  }

  bool sameAs(Manufacturing mfg) {
    return mfg.localizedKey == localizedKey;
  }
}

class PowderCellar extends Manufacturing {
  PowderCellar()
      : super(
          localizedKey: "powder_cellar",
          produces: Powder(20),
          priceToBuild: Money(1000),
        );
}

class River extends Manufacturing {
  River()
      : super(
          localizedKey: "river",
          produces: Fish(100),
          priceToBuild: Money(200),
        );
}

class IronMine extends Manufacturing {
  IronMine()
      : super(
          localizedKey: "iron_mine",
          produces: IronOre(100),
          priceToBuild: Money(200),
        );
}

class CharcoalMaker extends Manufacturing {
  CharcoalMaker()
      : super(
          localizedKey: "charcoal_maker",
          produces: Charcoal(300),
          priceToBuild: Money(200),
        );
}

class Forest extends Manufacturing {
  Forest()
      : super(
          localizedKey: "forest",
          produces: Wood(300),
          priceToBuild: Money(200),
        );
}

class Sawmill extends Manufacturing {
  Sawmill()
      : super(
          localizedKey: "sawmill",
          produces: Planks(300),
          priceToBuild: Money(200),
        );
}

class Pasture extends Manufacturing {
  Pasture()
      : super(
          localizedKey: "pasture",
          produces: Wool(1300),
          priceToBuild: Money(50),
        );
}

class Stables extends Manufacturing {
  Stables()
      : super(
          localizedKey: "stables",
          produces: Horse(30),
          priceToBuild: Money(1500),
        );
}

class TrappersHouse extends Manufacturing {
  TrappersHouse()
      : super(
          localizedKey: "trappers_house",
          produces: Fur(100),
          priceToBuild: Money(250),
        );
}

class Distillery extends Manufacturing {
  Distillery()
      : super(
          localizedKey: "distillery",
          produces: Gorilka(1000),
          priceToBuild: Money(500),
        );
}

class WaxMaker extends Manufacturing {
  WaxMaker()
      : super(
          localizedKey: "wax_maker",
          produces: Wax(800),
          priceToBuild: Money(300),
        );
}

class CannonFoundry extends Manufacturing {
  CannonFoundry()
      : super(
          localizedKey: "cannon_foundry",
          produces: Cannon(10),
          priceToBuild: Money(5000),
        );
}

class Smith extends Manufacturing {
  Smith()
      : super(
          localizedKey: "smith",
          produces: Firearm(10),
          priceToBuild: Money(1000),
        );
}

class Weavery extends Manufacturing {
  Weavery()
      : super(
          localizedKey: "weavery",
          produces: Cloth(300),
          priceToBuild: Money(750),
        );
}

class Liman extends Manufacturing {
  Liman()
      : super(
          localizedKey: "liman",
          produces: Salt(300),
          priceToBuild: Money(150),
        );
}

class TobaccoMaker extends Manufacturing {
  TobaccoMaker()
      : super(
          localizedKey: "tobacco_maker",
          produces: Tobacco(300),
          priceToBuild: Money(150),
        );
}

class Smeltery extends Manufacturing {
  Smeltery()
      : super(
          localizedKey: "smeltery",
          produces: MetalParts(100),
          priceToBuild: Money(500),
        );
}

class HoneyMaker extends Manufacturing {
  HoneyMaker()
      : super(
          localizedKey: "honey_maker",
          produces: Honey(100),
          priceToBuild: Money(300),
        );
}

class SilkMarket extends Manufacturing {
  SilkMarket()
      : super(
          localizedKey: "silk_market",
          produces: Silk(100),
          priceToBuild: Money(1300),
        );

  String get imagePath =>
      "images/manufacturings/marketplace/marketplace_$level.png";

  String get iconPath => "images/manufacturings/$localizedKey.png";
}

class Quarry extends Manufacturing {
  Quarry()
      : super(
          localizedKey: "quarry",
          produces: Stone(100),
          priceToBuild: Money(900),
        );
}

class Bakery extends Manufacturing {
  Bakery()
      : super(
          localizedKey: "bakery",
          produces: Bread(1000),
          priceToBuild: Money(300),
        );
}

class Field extends Manufacturing {
  Field()
      : super(
          localizedKey: "field",
          produces: Grains(1000),
          priceToBuild: Money(50),
        );
}

class AmberMine extends Manufacturing {
  AmberMine()
      : super(
          localizedKey: "amber_mine",
          produces: Amber(100),
          priceToBuild: Money(900),
        );
}

Manufacturing manufacturingForResource(Resource resource) {
  return Manufacturing.allManufacturings
      .firstWhere((mfg) => mfg.produces.sameType(resource));
}
