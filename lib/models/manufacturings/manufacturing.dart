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

Manufacturing manufacturingForResource(Resource resource) {
  return Manufacturing.allManufacturings
      .firstWhere((mfg) => mfg.produces.sameType(resource));
}
