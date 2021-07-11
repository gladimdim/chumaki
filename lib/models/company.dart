import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/bila_tserkva.dart';
import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chernigiv.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/cities/gaivoron.dart';
import 'package:chumaki/models/cities/govtva.dart';
import 'package:chumaki/models/cities/kaniv.dart';
import 'package:chumaki/models/cities/korsun.dart';
import 'package:chumaki/models/cities/kursk.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/lviv.dart';
import 'package:chumaki/models/cities/myrgorod.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/ochakiv.dart';
import 'package:chumaki/models/cities/ostrog.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/pyryatin.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/stavise.dart';
import 'package:chumaki/models/cities/temryuk.dart';
import 'package:chumaki/models/cities/uman.dart';
import 'package:chumaki/models/cities/vinnitsa.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/events/event.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/tasks/route.dart';
import 'package:chumaki/models/tasks/route_task.dart';
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
  EVENT_DONE,
}

class Company {
  final List<CityRoute> cityRoutes = [
    CityRoute(Cherkasy(), Chigirin(), Point<double>(50.0, 50.0)),
    CityRoute(Pereyaslav(), Nizhin(), Point<double>(0.0, 0.0)),
    CityRoute(Cherkasy(), Kaniv(), Point<double>(10.0, 10.0)),
    CityRoute(Sich(), Chigirin(), Point<double>(-675.0, 0.0)),
    CityRoute(Sich(), Govtva(), Point<double>(-50.0, 0.0)),
    // CityRoute(Pereyaslav(), Chigirin(), Point<double>(-150.0, 155.0)),
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
    // CityRoute(Cherkasy(), BilaTserkva(), Point<double>(0, 0)),
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
    CityRoute(Pyryatin(), Nizhin(), Point<double>(0, 0)),
    CityRoute(Pyryatin(), Pereyaslav(), Point<double>(150, -100)),
    CityRoute(Myrgorod(), Pyryatin(), Point<double>(-150, -100)),
    CityRoute(Govtva(), Myrgorod(), Point<double>(150, -100)),
    CityRoute(Nizhin(), Kursk(), Point<double>(200, -500)),
    CityRoute(Sich(), Kursk(), Point<double>(250, -1900)),
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

  Future startTask({
    required City from,
    required City to,
    required Wagon withWagon,
  }) async {
    var realFrom = refToCityByName(from);
    var realTo = refToCityByName(to);
    final completeRoute = Queue.from(fullRoute(from: realFrom, to: realTo));
    _innerChanges.add(COMPANY_EVENTS.TASK_STARTED);
    for (var nextStop in completeRoute) {
      var newTask = RouteTask(realFrom, nextStop, wagon: withWagon);
      // notify from City that the trade company with the given wagon departed
      realFrom.routeTaskStarted(newTask);

      await _startIntermediateTask(newTask);
      realFrom = nextStop;
    }
    _innerChanges.add(COMPANY_EVENTS.TASK_ENDED);
  }

  Future _startIntermediateTask(RouteTask newTask) async {
    final completer = Completer();
    var cityRoute = getRouteForTask(newTask);
    // add new task to the city route (curves on the map)
    cityRoute.routeTasks.add(newTask);
    newTask.start();
    activeRouteTasks.add(newTask);
    // listen to the finish event in order to add wagon to the "to" city
    newTask.changes.listen((event) {
      if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
        processTaskDone(newTask);
        completer.complete();
      }
    });
    return completer.future;
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
    // if the task was already finished before the game reloaded
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
    return from
        .connectsTo(inCompany: this)
        .where((element) => element.equalsTo(to))
        .isNotEmpty;
  }

  List<City> fullRoute(
      {required City from, required City to, bool allowLocked = false}) {
    List<City>? result = _innerFullRoute(
        from: from,
        to: to,
        ignore: [from],
        route: [],
        allowLocked: allowLocked);
    if (result == null) {
      throw "Route not found";
    } else {
      return result;
    }
  }

  List<City>? _innerFullRoute({
    required City from,
    required City to,
    required List<City> ignore,
    required List<City> route,
    required bool allowLocked,
  }) {
    if (hasDirectConnection(from: from, to: to) &&
        (allowLocked || to.isUnlocked())) {
      return [to];
    }

    Queue<City> neighbours = Queue.from(from
        .connectsTo(inCompany: this)
        .where((element) => (allowLocked || element.isUnlocked())));
    List<City>? bestMatch;
    while (neighbours.isNotEmpty) {
      final candidate = neighbours.removeFirst();
      if (ignore.where((element) => element.equalsTo(candidate)).isNotEmpty) {
        continue;
      }
      if (hasDirectConnection(from: candidate, to: to)) {
        final List<City> newRoute = List.from(route)..addAll([candidate, to]);
        return newRoute;
      } else {
        final match = _innerFullRoute(
          from: candidate,
          to: to,
          ignore: [...ignore, candidate],
          route: [...route, candidate],
          allowLocked: allowLocked,
        );
        if (bestMatch == null) {
          bestMatch = match;
        } else {
          if (match != null &&
              match.isNotEmpty &&
              match.length < bestMatch.length) {
            bestMatch = match;
          }
        }
      }
    }
    return bestMatch;
  }

  bool cityCanUnlockMore(City city) {
    return city.unlocksCities
        .map((fakeCity) => refToCityByName(fakeCity))
        .where((unlockCity) => !unlockCity.isUnlocked())
        .isNotEmpty;
  }

  void finishEvent(Event event, {required City inCity}) {
    if (!event.isDone()) {
      return;
    }
    addMoney(event.payment.amount);
    inCity.finishActiveEvent();
    this._innerChanges.add(COMPANY_EVENTS.EVENT_DONE);
  }

  void donateResource(Resource res,
      {required Wagon fromWagon, required City toCity}) {
    if (fromWagon.stock.removeResource(res)) {
      toCity.activeEvent!.decreaseResource(res);
    }
  }
}
