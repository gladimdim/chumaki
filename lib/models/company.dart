import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/progress_duration.dart';
import 'package:chumaki/models/route.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:rxdart/rxdart.dart';

enum COMPANY_EVENTS { TASK_STARTED }

class Company {
  List<RouteTask> tasks = List.empty(growable: true);
  final List<CityRoute> cityRoutes = CityRoute.allRoutes;
  static final Company instance = Company._internal();
  Company._internal() {
    changes = _innerChanges.stream;
  }

  final BehaviorSubject<COMPANY_EVENTS> _innerChanges = BehaviorSubject();
  late ValueStream<COMPANY_EVENTS> changes;


  startTask(RouteTask routeTask) {
    print("starting task: ${routeTask.id}");
    tasks.add(routeTask);
    routeTask.start();
    routeTask.changes.listen((event) {
      if (event == PROGRESS_DURACTION_EVENTS.FINISHED) {
        tasks.remove(routeTask);
      }
    });
    _innerChanges.add(COMPANY_EVENTS.TASK_STARTED);
  }

  CityRoute getRouteForTask(RouteTask routeTask) {
    var from = routeTask.from;
    var to = routeTask.to;
    return cityRoutes.firstWhere((route) {
      return (route.to.equalsTo(to) && route.from.equalsTo(from)) || (route.to.equalsTo(from) && route.from.equalsTo(to));
    });
  }

  void startTaskFromTo({required City from, required City to}) {
    print("from: ${from.name} to: ${to.name}");
    var newTask = RouteTask(to, from);
    startTask(newTask);
  }

  void dispose() {
    _innerChanges.close();
  }
}