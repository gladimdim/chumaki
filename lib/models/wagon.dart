import 'package:chumaki/models/resource.dart';

class Wagon {
  late Set<Resource> stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;

  Wagon({required this.name, Set<Resource>? stock}) {
    if (stock == null) {
      this.stock = Set();
    } else {
      this.stock = stock;
    }
  }
}