import 'dart:math';

import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/route.dart';

class City {
  final Point<double> point;
  final String name;
  final Set<Resource> stock;

  City({required this.point, required this.name, required this.stock});

  static List<City> allCities = [
    Nizhin(),
    Kaniv(),
    Sich(),
    Cherkasy(),
    Chigirin(),
    Pereyaslav(),
    Kyiv(),
  ];

  bool equalsTo(City another) {
    return another.name == name;
  }

  List<City> connectsTo() {
    return routes.map((route) {
      return route.to.equalsTo(this) ? route.from : route.to;
    }).toList();
  }

  List<CityRoute> get routes {
    return CityRoute.allRoutes.where((route) {
      return route.to.equalsTo(this) || route.from.equalsTo(this);
    }).toList();
  }
}

class Cherkasy extends City {
  Cherkasy()
      : super(
          point: Point(2250, 2000),
          name: "Черкаси",
          stock: Set()..add(Food(200))..add(Stone(300))..add(Firearm(500)),
        );
}

class Nizhin extends City {
  Nizhin()
      : super(
          point: Point(1600, 2500),
          name: "Ніжин",
          stock: Set()..add(Grains(200))..add(Wood(300))..add(Horse(500)),
        );
}

class Kaniv extends City {
  Kaniv()
      : super(
          point: Point(2400, 2200),
          name: "Канів",
          stock: Set()..add(Food(200))..add(Wood(300))..add(Planks(500)),
        );
}

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          stock: Set()..add(Wood(10)),
        );
}

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          name: "Чигирин",
          stock: Set()..add(Firearm(30)),
        );
}

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          stock: Set()..add(Food(100)),
        );
}

class Kyiv extends City {
  Kyiv()
      : super(
          point: Point(2700, 2830),
          name: "Київ",
          stock: Set()..add(Food(200))..add(Wood(300))..add(Planks(500)),
        );
}
