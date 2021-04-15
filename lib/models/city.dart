import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';

class City {
  final Point<double> point;
  final String name;
  final Stock stock;
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

    stock.changes.listen(changes.add);
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
          stock: Stock([Food(200), Stone(300), Firearm(500)]),
          wagons: [
            Wagon(name: "Вальків", stock: Stock([Food(10), Wood(30)])),
            Wagon(name: "Харченка", stock: Stock([Firearm(5), Stone(15)])),
            Wagon(
                name: "Підлісного",
                stock: Stock([Fur(30), Charcoal(25), Fish(15)])),
            Wagon(
                name: "Мітрась",
                stock: Stock([Horse(3), Powder(25), IronOre(20)])),
          ],
        );
}

class Nizhin extends City {
  Nizhin()
      : super(
          point: Point(1600, 2500),
          name: "Ніжин",
          stock: Stock([Grains(200), Wood(300), Horse(500)]),
        );
}

class Kaniv extends City {
  Kaniv()
      : super(
          point: Point(2400, 2200),
          name: "Канів",
          stock: Stock([
            Food(200),
            Wood(300),
            Planks(500),
          ]),
        );
}

class Sich extends City {
  Sich()
      : super(
          point: Point(1200, 900),
          name: "Січ",
          stock: Stock(
            [Powder(1000)],
          ),
          wagons: [
            Wagon(name: "Татарина"),
            Wagon(name: "Остапа"),
            Wagon(name: "Дмитра")
          ],
        );
}

class Chigirin extends City {
  Chigirin()
      : super(
          point: Point(2000, 1750),
          name: "Чигирин",
          stock: Stock([Firearm(300)]),
        );
}

class Pereyaslav extends City {
  Pereyaslav()
      : super(
          point: Point(2360, 2450),
          name: "Переяслав",
          stock: Stock([
            Food(1000),
            Stone(1000),
            Cannon(100),
          ]),
        );
}

class Kyiv extends City {
  Kyiv()
      : super(
          point: Point(2700, 2830),
          name: "Київ",
          stock: Stock([
            Food(200),
            Wood(300),
            Planks(500),
          ]),
        );
}
