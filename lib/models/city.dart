import 'dart:math';

import 'package:chumaki/models/route.dart';

class City {
  final Point<double> point;
  final String name;

  City({required this.point, required this.name});

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


  List<CityRoute> get routes {
    return CityRoute.allRoutes.where((route) {
      return route.to.equalsTo(this) || route.from.equalsTo(this);
    }).toList();
  }
}

class Cherkasy extends City {
  Cherkasy() : super(point: Point(2250, 2000), name: "Черкаси");
}

class Nizhin extends City {
  Nizhin() : super(point: Point(1600, 2500), name: "Ніжин");
}

class Kaniv extends City {
  Kaniv() : super(point: Point(2400, 2200), name: "Канів");
}

class Sich extends City {
  Sich(): super(point: Point(1200, 900), name: "Січ");
}

class Chigirin extends City {
  Chigirin(): super(point: Point(2000, 1750), name: "Чигирин");
}

class Pereyaslav extends City {
  Pereyaslav(): super(point: Point(2360, 2450), name: "Переяслав");
}
class Kyiv extends City {
  Kyiv(): super(point: Point(2700, 2830), name: "Київ");
}