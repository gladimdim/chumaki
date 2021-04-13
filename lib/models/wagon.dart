import 'package:chumaki/models/resource.dart';

class Wagon {
  late Set<Resource> stock;
  static final String imagePath = "images/wagon/wagon.png";

  Wagon({Set<Resource>? stock}) {
    if (stock == null) {
      this.stock = Set();
    } else {
      this.stock = stock;
    }
  }
}