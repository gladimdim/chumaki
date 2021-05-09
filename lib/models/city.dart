import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/price.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';

class City {
  final Point<double> point;
  final String name;
  final Stock stock;
  final String localizedKeyName;
  bool unlocked;
  final double size;
  late List<Wagon> wagons;

  final Price prices;
  BehaviorSubject changes = BehaviorSubject();

  String get avatarImagePath {
    return "images/cities/avatars/$localizedKeyName.png";
  }

  City(
      {required this.point,
      required this.name,
      required this.stock,
      required this.prices,
      required this.localizedKeyName,
      this.unlocked = false,
      this.size = 1,
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
  static City ochakiv = Ochakiv();

  static List<City> allCities = [
    nizhin,
    kaniv,
    sich,
    cherkasy,
    chigirin,
    pereyaslav,
    kyiv,
    ochakiv,
  ];

  bool sellResource(
      {required Resource resource,
      required Wagon toWagon,
      required Company company}) {
    var price =
        prices.sellPriceForResource(resource, withAmount: resource.amount);
    var hasMoney = company.hasMoney(price);
    if (!hasMoney) {
      return false;
    }
    var canSell = stock.removeResource(resource);
    if (!canSell) {
      return false;
    }
    toWagon.stock.addResource(resource);
    company.removeMoney(price);
    return true;
  }

  bool buyResource(
      {required Resource resource,
      required Wagon fromWagon,
      required Company company}) {
    var price =
        prices.buyPriceForResource(resource, withAmount: resource.amount);

    final canSell = fromWagon.stock.removeResource(resource);
    if (canSell) {
      stock.addResource(resource);
      company.addMoney(price);
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

  Map<String, Object> toJson() {
    return {
      "name": name,
      "stock": stock.toJson(),
      "point": {"x": point.x, "y": point.y},
      "localizedKeyName": localizedKeyName,
      "size": size,
      "wagons": wagons.map((wagon) => wagon.toJson()).toList(),
      "prices": prices.toJson(),
    };
  }

  static City fromJson(Map<String, dynamic> input) {
    var pointJson = input["point"];
    List wagonJson = input["wagons"];
    return City(
      point: Point(pointJson["x"], pointJson["y"]),
      name: input["name"],
      stock: Stock.fromJson(input["stock"]),
      prices: Price.fromJson(input["prices"]),
      localizedKeyName: input["localizedKeyName"],
      wagons: wagonJson.map((e) => Wagon.fromJson(e)).toList(),
    );
  }
}
