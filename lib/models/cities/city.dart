import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
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
  late bool _unlocked;
  final double size;
  late List<Wagon> wagons;
  final List<City> unlocksCities;
  final Price prices;
  BehaviorSubject changes = BehaviorSubject();

  String get avatarImagePath {
    return "images/cities/avatars/$localizedKeyName.png";
  }

  late Money unlockPriceMoney;

  City(
      {required this.point,
      required this.name,
      required this.stock,
      required this.prices,
      required this.localizedKeyName,
      unlocked = false,
      this.size = 1,
      required this.unlocksCities,
      this.unlockPriceMoney = const Money(0),
      List<Wagon>? wagons}) {
    if (wagons == null) {
      this.wagons = List.empty(growable: true);
    } else {
      this.wagons = wagons;
    }

    _unlocked = unlocked;

    stock.changes.listen(changes.add);
  }

  static City fromName(String name) {
    switch (name) {
      case "nizhin":
        return Nizhin();
      case "kaniv":
        return Kaniv();
      case "sich":
        return Sich();
      case "cherkasy":
        return Cherkasy();
      case "chigirin":
        return Chigirin();
      case "pereyaslav":
        return Pereyaslav();
      case "kyiv":
        return Kyiv();
      case "ochakiv":
        return Ochakiv();
      default:
        throw "City with key $name is not recognized";
    }
  }
  //
  // static City nizhin = Nizhin();
  // static City kaniv = Kaniv();
  // static City sich = Sich();
  // static City cherkasy = Cherkasy();
  // static City chigirin = Chigirin();
  // static City pereyaslav = Pereyaslav();
  // static City kyiv = Kyiv();
  // static City ochakiv = Ochakiv();

  static List<City> generateNewCities() {
    return [
      Nizhin(),
      Kaniv(),
      Sich(),
      Cherkasy(),
      Chigirin(),
      Pereyaslav(),
      Kyiv(),
      Ochakiv(),
      Chernigiv(),
    ];
  }

  bool isUnlocked() {
    return _unlocked;
  }

  void unlock() {
    _unlocked = true;
    changes.add(this);
  }

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

    final canSell = fromWagon.sellResource(resource);
    if (canSell) {
      stock.addResource(resource);
      company.addMoney(price);
    }
    return canSell;
  }

  bool equalsTo(City another) {
    return another.localizedKeyName == localizedKeyName;
  }

  List<City> connectsTo({required Company inCompany}) {
    return getRoutesInCompany(inCompany).map((route) {
      return route.to.equalsTo(this) ? inCompany.refToCityByName(route.from) : inCompany.refToCityByName(route.to);
    }).toList();
  }

  List<CityRoute> getRoutesInCompany(Company company) {
    return company.cityRoutes.where((route) {
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
      "unlocked": _unlocked,
      "unlockCities": unlocksCities.map((e) => e.localizedKeyName).toList(),
    };
  }

  static City fromJson(Map<String, dynamic> input) {
    var pointJson = input["point"];
    List wagonJson = input["wagons"];
    List unlockCities = input["unlockCities"];
    return City(
      point: Point(pointJson["x"], pointJson["y"]),
      name: input["name"],
      stock: Stock.fromJson(input["stock"]),
      prices: Price.fromJson(input["prices"]),
      localizedKeyName: input["localizedKeyName"],
      wagons: wagonJson.map((e) => Wagon.fromJson(e)).toList(),
      unlocked: input["unlocked"],
      unlocksCities:
          unlockCities.map((cityName) => City.fromName(cityName)).toList(),
      size: input["size"],
    );
  }

  void addWagon(Wagon wagon) {
    wagons.add(wagon);
    changes.add(this);
  }
}
