import 'dart:math';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/bila_tserkva.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/city.dart';
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
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/models/resources/resource.dart';

import 'leaders/leaders.dart';

enum COMPANY_EVENTS {
  TASK_STARTED,
  TASK_ENDED,
  MONEY_ADDED,
  MONEY_REMOVED,
  CITY_UNLOCKED,
  WAGON_BOUGHT,
  LEADER_HIRED,
}

class Company {
  final List<CityRoute> cityRoutes = [
    CityRoute(Cherkasy(), Chigirin(), Point<double>(50.0, 50.0)),
    CityRoute(Pereyaslav(), Nizhin(), Point<double>(0.0, 0.0)),
    CityRoute(Cherkasy(), Kaniv(), Point<double>(10.0, 10.0)),
    CityRoute(Sich(), Chigirin(), Point<double>(-675.0, 0.0)),
    CityRoute(Pereyaslav(), Chigirin(), Point<double>(-150.0, 155.0)),
    CityRoute(Kyiv(), Nizhin(), Point<double>(150, -300)),
    CityRoute(Kyiv(), Pereyaslav(), Point<double>(300, 0)),
    CityRoute(Kaniv(), Pereyaslav(), Point<double>(100, -50)),
    CityRoute(Ochakiv(), Sich(), Point<double>(450, -230)),
    CityRoute(Chernigiv(), Nizhin(), Point<double>(-100, 250)),
    CityRoute(Chernigiv(), Kyiv(), Point<double>(-280, 0)),
    CityRoute(Zhytomir(), Ostrog(), Point<double>(-300, 200)),
    CityRoute(Kyiv(), Zhytomir(), Point<double>(-500, 200)),
    CityRoute(Ostrog(), Lviv(), Point<double>(-300, 500)),
    CityRoute(Temryuk(), Ochakiv(), Point<double>(-300, -300)),
    CityRoute(Kaniv(), BilaTserkva(), Point<double>(-100, -100)),
    CityRoute(Cherkasy(), BilaTserkva(), Point<double>(0, 0)),
    CityRoute(Kyiv(), BilaTserkva(), Point<double>(200, 200)),
    CityRoute(Zhytomir(), Berdychiv(), Point<double>(-150, 50)),
    CityRoute(Berdychiv(), Vinnitsa(), Point<double>(100, 200)),
    CityRoute(Cherkasy(), Korsun(), Point<double>(-40, 50)),
    CityRoute(Korsun(), Uman(), Point<double>(100, 200)),
    CityRoute(BilaTserkva(), Stavise(), Point<double>(-150, 200)),
    CityRoute(Stavise(), Vinnitsa(), Point<double>(-150, 200)),
    CityRoute(Stavise(), Uman(), Point<double>(50, 100)),
    CityRoute(Uman(), Gaivoron(), Point<double>(-50, 50)),
    CityRoute(Vinnitsa(), Ladyzhin(), Point<double>(150, 100)),
    CityRoute(Ladyzhin(), Gaivoron(), Point<double>(150, 100)),
  ];

  late double _money;
  late List<City> allCities;
  List<RouteTask> activeRouteTasks = List.empty(growable: true);

  Company({cities, double? money}) {
    if (cities == null) {
      this.allCities = City.generateNewCities();
    } else {
      this.allCities = cities;
    }

    _money = money ?? 3000;
    changes = _innerChanges.stream;
    changes.listen((event) {
      switch (event) {
        case COMPANY_EVENTS.TASK_STARTED:
        case COMPANY_EVENTS.TASK_ENDED:
        case COMPANY_EVENTS.CITY_UNLOCKED:
        case COMPANY_EVENTS.WAGON_BOUGHT:
        case COMPANY_EVENTS.LEADER_HIRED:
          save();
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
    return getRouteFromTo(from: from, to: to);
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
    activeRouteTasks.add(newTask);
    // listen to the finish event in order to add wagon to the "to" city
    newTask.changes.listen((event) {
      if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
        processTaskDone(newTask);
      }
    });
    _innerChanges.add(COMPANY_EVENTS.TASK_STARTED);
  }

  void reconnectRestoredTask(RouteTask restoredTask) {
    // replace to/from to the references to real cities
    // instead of city instances restored from JSON
    restoredTask.to = refToCityByName(restoredTask.to);
    restoredTask.from = refToCityByName(restoredTask.from);
    if (restoredTask.isFinished) {
      processTaskDone(restoredTask);
    } else {
      var cityRoute = getRouteForTask(restoredTask);
      // add new task to the city route (curves on the map)
      cityRoute.routeTasks.add(restoredTask);
      restoredTask.changes.listen((event) {
        if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
          processTaskDone(restoredTask);
        }
      });
    }
  }

  void processTaskDone(RouteTask task) {
    final cityRoute = getRouteForTask(task);
    activeRouteTasks.remove(task);
    // wagon arrived, remove it from the road
    cityRoute.routeTasks.remove(task);
    // notify the 'to' city that the new wagon arrived
    task.to.routeTaskArrived(task);
    // notify all listeners of your company that some task ended.
    _innerChanges.add(COMPANY_EVENTS.TASK_ENDED);
  }

  Future save() async {
    await AppPreferences.instance.saveGameToDisk(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      "money": _money,
      "allCities": allCities.map((city) => city.toJson()).toList(),
      "activeRouteTasks":
          activeRouteTasks.map((routeTask) => routeTask.toJson()).toList(),
    };
  }

  static Company fromJson(Map<String, dynamic> inputJson) {
    double money = inputJson["money"] as double;
    List citiesJson = inputJson["allCities"];
    List<City> allCities =
        citiesJson.map((cityJson) => City.fromJson(cityJson)).toList();
    List activeRouteTasksJson = inputJson["activeRouteTasks"];
    List<RouteTask> activeRouteTasks = activeRouteTasksJson
        .map((routeJson) => RouteTask.fromJson(routeJson))
        .toList();
    var company = Company(cities: allCities).._money = money;

    // we need to reconnect to streams from restored tasks
    // in order to get the event when task is finished
    // if the task was already finished before the game relaoded
    // we just process the task like it was done.
    company.activeRouteTasks = activeRouteTasks;
    company.activeRouteTasks.forEach((task) {
      company.reconnectRestoredTask(task);
    });
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

  List<City> citiesToRealCities(List<City> cities) {
    return cities.map((e) => refToCityByName(e)).toList();
  }

  void buyWagon(Wagon wagon, {required City forCity, required Money price}) {
    if (getMoney().amount >= price.amount) {
      removeMoney(price.amount);
      forCity.addWagon(wagon);
      _innerChanges.add(COMPANY_EVENTS.WAGON_BOUGHT);
    }
  }

  void hireLeader({required Leader leader, required Wagon forWagon}) {
    forWagon.setLeader(leader);
    removeMoney(Leader.defaultAcquirePrice.amount);
    _innerChanges.add(COMPANY_EVENTS.LEADER_HIRED);
  }

  bool hasDirectConnection({required City from, required City to}) {
    return from.connectsTo(inCompany: this).where((element) => element.equalsTo(to)).isNotEmpty;
  }

  List<City> fullRoute({required City from, required City to}) {
    if (hasDirectConnection(from: from, to: to)) {
      return [to];
    }
    throw UnimplementedError();
  }
}
