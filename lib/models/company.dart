import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/models/resources/resource.dart';

enum COMPANY_EVENTS { TASK_STARTED, TASK_ENDED, MONEY_ADDED, MONEY_REMOVED }

class Company {
  final List<CityRoute> cityRoutes = CityRoute.allRoutes;
  double _money = 500;
  late List<City> allCities;

  Company({cities}) {
    if (cities == null) {
      this.allCities =  City.allCities;
    } else {
      this.allCities = City.allCities;
    }
    changes = _innerChanges.stream;
    changes.listen((event) {
      switch (event) {
        case COMPANY_EVENTS.TASK_STARTED: save(); break;
        case COMPANY_EVENTS.TASK_ENDED: save(); break;
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

  void startTask({required City from, required City to, required Wagon withWagon}) {
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
    var company = Company().._money = money;
    return company;
  }


  void dispose() {
    _innerChanges.close();
  }

  bool hasMoney(double price) {
    return price <= _money;
  }
}
