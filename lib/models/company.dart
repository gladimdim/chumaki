import 'dart:math';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/models/resources/resource.dart';

enum COMPANY_EVENTS {
  TASK_STARTED,
  TASK_ENDED,
  MONEY_ADDED,
  MONEY_REMOVED,
  CITY_UNLOCKED
}

class Company {
  final List<CityRoute> cityRoutes = [
    CityRoute(Cherkasy(), Chigirin(), Point<double>(50.0, 50.0)),
    CityRoute(Pereyaslav(), Nizhin(), Point<double>(0.0, 0.0)),
    CityRoute(Cherkasy(), Kaniv(), Point<double>(10.0, 10.0)),
    CityRoute(Sich(), Chigirin(), Point<double>(-675.0, 0.0)),
    CityRoute(Pereyaslav(), Chigirin(), Point<double>(-150.0, 155.0)),
    CityRoute(Kyiv(), Nizhin(), Point<double>(-50, 50)),
    CityRoute(Kyiv(), Pereyaslav(), Point<double>(300, 0)),
    CityRoute(Kaniv(), Pereyaslav(), Point<double>(100, -50)),
    CityRoute(Ochakiv(), Sich(), Point<double>(450, -230)),
  ];

  double _money = 500;
  late List<City> allCities;

  Company({cities}) {
    if (cities == null) {
      this.allCities = City.generateNewCities();
    } else {
      this.allCities = cities;
    }
    changes = _innerChanges.stream;
    changes.listen((event) {
      switch (event) {
        case COMPANY_EVENTS.TASK_STARTED:
          save();
          break;
        case COMPANY_EVENTS.TASK_ENDED:
          save();
          break;
        case COMPANY_EVENTS.CITY_UNLOCKED:
          save();
          break;
      }
    });
  }

  final BehaviorSubject<COMPANY_EVENTS> _innerChanges = BehaviorSubject();
  late ValueStream<COMPANY_EVENTS> changes;

  addMoney(double value) {
    _money += value;
    _innerChanges.add(COMPANY_EVENTS.MONEY_ADDED);
  }

  bool removeMoney(double value) {
    if (value <= _money) {
      _money -= value;
      _innerChanges.add(COMPANY_EVENTS.MONEY_REMOVED);
      return true;
    }
    return false;
  }

  Money getMoney() {
    return Money(double.parse(_money.toStringAsFixed(2)));
  }

  CityRoute getRouteForTask(RouteTask routeTask) {
    var from = routeTask.from;
    var to = routeTask.to;
    return cityRoutes.firstWhere((route) {
      return (route.to.equalsTo(to) && route.from.equalsTo(from)) ||
          (route.to.equalsTo(from) && route.from.equalsTo(to));
    });
  }

  CityRoute getRouteFromTo({required City from, required City to}) {
    return cityRoutes.firstWhere((route) {
      return (route.to.equalsTo(to) && route.from.equalsTo(from)) ||
          (route.to.equalsTo(from) && route.from.equalsTo(to));
    });
  }

  void startTask(
      {required City from, required City to, required Wagon withWagon}) {
    var newTask = RouteTask(from, to, wagon: withWagon);
    // notify from City that the trade company with the given wagon departed
    from.routeTaskStarted(newTask);

    var cityRoute = getRouteForTask(newTask);
    // add new task to the city route (curves on the map)
    cityRoute.routeTasks.add(newTask);
    newTask.start();
    // listen to the finish event in order to add wagon to the "to" city
    newTask.changes.listen((event) {
      if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
        // wagon arrived, remove it from the road
        cityRoute.routeTasks.remove(newTask);
        // notify the 'to' city that the new wagon arrived
        newTask.to.routeTaskArrived(newTask);
        // notify all listeners of your company that some task ended.
        _innerChanges.add(COMPANY_EVENTS.TASK_ENDED);
      }
    });
    _innerChanges.add(COMPANY_EVENTS.TASK_STARTED);
  }

  Future save() async {
    await AppPreferences.instance.saveGameToDisk(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      "money": _money,
      "allCities": allCities.map((city) => city.toJson()).toList(),
    };
  }

  static Company fromJson(Map<String, dynamic> inputJson) {
    double money = inputJson["money"] as double;
    List citiesJson = inputJson["allCities"];
    List<City> allCities = citiesJson.map((cityJson) => City.fromJson(cityJson)).toList();
    var company = Company(cities: allCities).._money = money;
    return company;
  }

  void dispose() {
    _innerChanges.close();
  }

  bool hasMoney(double price) {
    return price <= _money;
  }

  void unlockCity(City cityToUnlock) {
    final realCity = refToCityByName(cityToUnlock);
    var price = realCity.unlockPriceMoney;
    if (hasEnoughMoney(price)) {
      removeMoney(price.amount);
      realCity.unlock();
      _innerChanges.add(COMPANY_EVENTS.CITY_UNLOCKED);
    }
  }

  bool hasEnoughMoney(Money unlockPriceMoney) {
    return _money >= unlockPriceMoney.amount;
  }

  City refToCityByName(City city) {
    return allCities.firstWhere((c) => c.equalsTo(city));
  }

  bool canUnlockMoreCities(City city) {
    return city.unlocksCities.where((unlockCity) {
      var realCity = refToCityByName(unlockCity);
      return !realCity.isUnlocked();
    }).isNotEmpty;
  }
}
