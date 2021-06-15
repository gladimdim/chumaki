import 'dart:math';

import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/bila_tserkva.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/korsun.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/lviv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/stavise.dart';
import 'package:chumaki/models/cities/temryuk.dart';
import 'package:chumaki/models/cities/uman.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/price/price_unit.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/tasks/route.dart';
import 'package:chumaki/models/tasks/route_task.dart';
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
  Event? activeEvent;
  final List<Event> availableEvents;
  late final List<Resource> produces;
  BehaviorSubject changes = BehaviorSubject();

  String get avatarImagePath {
    return "images/cities/avatars/$localizedKeyName.png";
  }

  late Money unlockPriceMoney;

  City({
    required this.point,
    required this.name,
    required this.stock,
    required this.localizedKeyName,
    unlocked = false,
    this.size = 1,
    required this.unlocksCities,
    this.unlockPriceMoney = const Money(0),
    required this.produces,
    List<Wagon>? wagons,
    this.activeEvent,
    this.availableEvents = const [],
  }) {
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
      case "chernigiv":
        return Chernigiv();
      case "lviv":
        return Lviv();
      case "ostrog":
        return Ostrog();
      case "temryuk":
        return Temryuk();
      case "zhytomir":
        return Zhytomir();
      case "bilatserkva":
        return BilaTserkva();
      case "vinnitsa":
        return Vinnitsa();
      case "berdychiv":
        return Berdychiv();
      case "uman":
        return Uman();
      case "korsun":
        return Korsun();
      case "gaivoron":
        return Gaivoron();
      case "ladyzhin":
        return Ladyzhin();
      case "stavise":
        return Stavise();
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
      Lviv(),
      Ostrog(),
      Zhytomir(),
      Temryuk(),
      BilaTserkva(),
      Vinnitsa(),
      Berdychiv(),
      Uman(),
      Korsun(),
      Stavise(),
      Ladyzhin(),
      Gaivoron(),
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
    var price = buyPriceForResource(resource, company.allCities,
        withAmount: resource.amount);
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
    var price = sellPriceForResource(resource, company.allCities,
        withAmount: resource.amount);

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
      return route.to.equalsTo(this)
          ? inCompany.refToCityByName(route.from)
          : inCompany.refToCityByName(route.to);
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
    final event = activeEvent;
    final eventJson = event == null ? null : event.toJson();
    return {
      "name": name,
      "stock": stock.toJson(),
      "point": {"x": point.x, "y": point.y},
      "localizedKeyName": localizedKeyName,
      "size": size,
      "wagons": wagons.map((wagon) => wagon.toJson()).toList(),
      "unlocked": _unlocked,
      "produces": produces.map((resource) => resource.toJson()).toList(),
      "unlockCities": unlocksCities.map((e) => e.localizedKeyName).toList(),
      "activeEvent": eventJson!,
    };
  }

  static City fromJson(Map<String, dynamic> input) {
    var pointJson = input["point"];
    List wagonJson = input["wagons"];
    List unlockCities = input["unlockCities"];
    List producesJson = input["produces"];
    List availableEventsJson = input["availableEvents"];
    final eventJson = input["activeEvent"];
    return City(
      point: Point(pointJson["x"], pointJson["y"]),
      name: input["name"],
      stock: Stock.fromJson(input["stock"]),
      localizedKeyName: input["localizedKeyName"],
      wagons: wagonJson.map((e) => Wagon.fromJson(e)).toList(),
      produces: producesJson.map((e) => Resource.fromJson(e)).toList(),
      unlocked: input["unlocked"],
      unlocksCities:
          unlockCities.map((cityName) => City.fromName(cityName)).toList(),
      size: input["size"],
      activeEvent: eventJson == null ? null : Event.fromJson(eventJson),
      availableEvents:
          availableEventsJson.map((e) => Event.fromJson(e)).toList(),
    );
  }

  void addWagon(Wagon wagon) {
    wagons.add(wagon);
    changes.add(this);
  }

  double distanceTo({required City toCity}) {
    return sqrt(
        pow(point.x - toCity.point.x, 2) + pow(point.y - toCity.point.y, 2));
  }

  double sellPriceForResource(Resource resource, List<City> cities,
      {int? withAmount}) {
    withAmount = withAmount ?? resource.amount;
    double distance = max(1,
        findClosestResourceCenter(resource, cities).distanceTo(toCity: this));
    final priceUnit = PriceUnit.defaultPriceUnitForResourceType(resource.type);
    return double.parse(
        (priceUnit.sellPriceForResource(withAmount: withAmount) *
                distance *
                (distance == 1 ? 1 : 0.001))
            .toStringAsFixed(1));
  }

  double buyPriceForResource(Resource resource, List<City> cities,
      {int? withAmount}) {
    withAmount = withAmount ?? resource.amount;
    double distance;
    // in case we cannot find production center just use distance 1
    try {
      distance = max(
        1,
        findClosestResourceCenter(resource, cities).distanceTo(toCity: this),
      );
    } catch (e) {
      distance = 1;
    }
    final priceUnit = PriceUnit.defaultPriceUnitForResourceType(resource.type);

    return double.parse((priceUnit.buyPriceForResource(withAmount: withAmount) *
            distance *
            (distance == 1 ? 1 : 0.001))
        .toStringAsFixed(1));
  }

  City findClosestResourceCenter(Resource resource, List<City> cities) {
    List<City> centers = cities.where((city) {
      return city.produces.where((res) => res.sameType(resource)).isNotEmpty;
    }).toList();
    City closest = centers.fold(centers.first, (previousValue, aCity) {
      double previousDistance = previousValue.distanceTo(toCity: this);
      double newDistance = aCity.distanceTo(toCity: this);
      return previousDistance < newDistance ? previousValue : aCity;
    });
    return closest;
  }
}
