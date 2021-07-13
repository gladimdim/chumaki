import 'package:chumaki/models/resources/resource.dart';

class Manufacturing {
  final String localizedKey;
  final Resource produces;
  bool built;
  final Money priceToBuild;

  Manufacturing({
    required this.localizedKey,
    required this.produces,
    this.built = false,
    required this.priceToBuild,
  });

  String get imagePath => "images/manufacturings/$localizedKey.png";

  String get iconPath => "images/manufacturings/$localizedKey.png";

  String get fullLocalizedKey => "manufacturings.$localizedKey";

  Map<String, dynamic> toJson() {
    return {
      "localizedKey": localizedKey,
      "produces": produces.toJson(),
      "built": built,
      "priceToBuild": priceToBuild.amount,
    };
  }

  static Manufacturing fromJson(Map<String, dynamic> inputJson) {
    return Manufacturing(
      priceToBuild: Money(inputJson["priceToBuild"]),
      localizedKey: inputJson["localizedKey"],
      produces: Resource.fromJson(inputJson["produces"]),
      built: inputJson["built"],
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

Manufacturing manufacturingForResource(Resource resource) {
  return Manufacturing.allManufacturings
      .firstWhere((mfg) => mfg.produces.sameType(resource));
}
