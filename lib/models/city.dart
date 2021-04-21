import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';

class City {
  final Point<double> point;
  final String name;
  final Stock stock;
  final String imagePath;
  final double size;
  late List<Wagon> wagons;
  BehaviorSubject changes = BehaviorSubject();

  final Price prices;

  City(
      {required this.point,
      required this.name,
      required this.stock,
      required this.prices,
      this.size = 1,
      required this.imagePath,
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

  bool sellResource({required Resource resource, required Wagon toWagon}) {
    var price =
        prices.sellPriceForResource(resource, withAmount: resource.amount);
    var hasMoney = Company.instance.hasMoney(price);
    if (!hasMoney) {
      return false;
    }
    var canSell = stock.removeResource(resource);
    if (!canSell) {
      return false;
    }
    toWagon.stock.addResource(resource);
    Company.instance.removeMoney(price);
    return true;
  }

  bool buyResource({required Resource resource, required Wagon fromWagon}) {
    var price =
        prices.buyPriceForResource(resource, withAmount: resource.amount);

    final canSell = fromWagon.stock.removeResource(resource);
    if (canSell) {
      stock.addResource(resource);
      Company.instance.addMoney(price);
    }
    return canSell;
  }

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

  bool canSellResource(Resource res) {
    return stock.hasEnough(res);
  }
}
