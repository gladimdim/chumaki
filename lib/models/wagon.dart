import 'package:chumaki/models/resource.dart';

class Wagon {
  late List<Resource> stock;
  static final String imagePath = "images/wagon/wagon.png";
  final String name;

  Wagon({required this.name, List<Resource>? stock}) {
    if (stock == null) {
      this.stock = List.empty(growable: true);
    } else {
      this.stock = stock;
    }
  }
}