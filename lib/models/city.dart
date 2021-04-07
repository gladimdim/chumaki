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
    Yagidne(),
    Sloboda(),
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
  Cherkasy() : super(point: Point(25, 325), name: "Черкаси");
}

class Nizhin extends City {
  Nizhin() : super(point: Point(100, 200), name: "Ніжин");
}

class Kaniv extends City {
  Kaniv() : super(point: Point(300, 50), name: "Канів");
}

class Sich extends City {
  Sich(): super(point: Point(200, 75), name: "Січ");
}

class Yagidne extends City {
  Yagidne(): super(point: Point(275, 225), name: "Ягідне");
}

class Sloboda extends City {
  Sloboda(): super(point: Point(140, 525), name: "Слобода");
}