import 'dart:math';

import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';

class City {
  final Point<double> point;
  final String name;
  final Set<Resource> stock;
  late List<Wagon> wagons;
  BehaviorSubject changes = BehaviorSubject();

  City(
      {required this.point,
      required this.name,
      required this.stock,
      List<Wagon>? wagons}) {
    if (wagons == null) {
      this.wagons = List.empty(growable: true);
    } else {
      this.wagons = wagons;
    }
  }

  static City nizhin = Nizhin();
  static City kaniv = Kaniv();
  static City sich = Sich();
  static City cherkasy = Cherkasy();
  static City chigirin = Chigirin();
  static City pereyaslav = Pereyaslav();
  static City kyiv = Kyiv();

  static List<City> allCities = [
    nizhin,
    kaniv,
    sich,
    cherkasy,
    chigirin,
    pereyaslav,
    kyiv,
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

  void routeTaskArrived(RouteTask task) {
    wagons.add(task.wagon);
    changes.add(this);
  }

  void routeTaskStarted(RouteTask task) {
    wagons.remove(task.wagon);
    changes.add(this);
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
          stock: Set()
            ..add(Food(200))
            ..add(Wood(300))
            ..add(
              Planks(500),
            ),
        );
}

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          stock: Set()..add(Powder(1000)),
          wagons: [Wagon(name: "Татарина"), Wagon(name: "Остапа"), Wagon(name: "Дмитра")],
        );
}

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          name: "Чигирин",
          stock: Set()
            ..add(
              Firearm(300),
            ),
        );
}

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          stock: Set()
            ..add(Food(1000))
            ..add(Stone(1000))
            ..add(
              Cannon(100),
            ),
        );
}

class Kyiv extends City {
  Kyiv()
      : super(
          point: Point(2700, 2830),
          name: "Київ",
          stock: Set()
            ..add(Food(200))
            ..add(Wood(300))
            ..add(
              Planks(500),
            ),
        );
}
