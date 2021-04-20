import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/models/resource.dart';

enum COMPANY_EVENTS { TASK_STARTED, TASK_ENDED, MONEY_ADDED, MONEY_REMOVED }

class Company {
  final List<CityRoute> cityRoutes = CityRoute.allRoutes;
  static final Company instance = Company._internal();
  double _money = 500;

  Company._internal() {
    changes = _innerChanges.stream;
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

  void startTaskFromTo({required City from, required City to}) {
    if (from.wagons.isEmpty) {
      return;
    }
    var newTask = RouteTask(from, to, wagon: from.wagons.first);
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

  void dispose() {
    _innerChanges.close();
  }

  bool hasMoney(double price) {
    return price <= _money;
  }
}
