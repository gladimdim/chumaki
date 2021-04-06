import 'dart:math';

import 'package:tuple/tuple.dart';

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
  Yagidne(): super(point: Point(180, 225), name: "Ягідне");
}

class Sloboda extends City {
  Sloboda(): super(point: Point(140, 525), name: "Слобода");
}

Map<Tuple2<City, City>, Point<double>> routes = {
  Tuple2(Nizhin(), Sich()): Point<double>(80.0, 20.0),
  Tuple2(Nizhin(), Sloboda()): Point<double>(80.0, 40.0),
  Tuple2(Cherkasy(), Sloboda()): Point<double>(-80.0, 40.0),
  Tuple2(Cherkasy(), Yagidne()): Point<double>(150.0, 150.0),
  Tuple2(Cherkasy(), Kaniv()): Point<double>(250.0, 250.0),
};
