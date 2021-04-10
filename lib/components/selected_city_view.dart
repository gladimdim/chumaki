import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/task.dart';
import 'package:flutter/material.dart';

class SelectedCityView extends StatelessWidget {
  final City city;

  SelectedCityView({required this.city});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Company.instance.changes,
      builder: (context, data) => Column(
        children: [
          Text(city.name),
          ...city.connectsTo().map(
            (toCity) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Connects to: ${toCity.name}"),
                  IconButton(
                    icon: Icon(Icons.not_started),
                    onPressed: () => routeStart(toCity),
                  ),
                ],
              );
            },
          ),
          Text("In: "),
          ...Company.instance.cityRoutes
              .where(
                  (route) => route.to.equalsTo(city) || route.from.equalsTo(city))
              .fold<List<RouteTask>>([], (previousValue, route) {
            previousValue.addAll(route.routeTasks);
            return previousValue;
          }).where((routeTask) => routeTask.to.equalsTo(city)).map<Widget>((routeTask) => RouteTaskRowProgress(routeTask)),
          Text("Out: "),
          ...Company.instance.cityRoutes
              .where(
                  (route) => route.to.equalsTo(city) || route.from.equalsTo(city))
              .fold<List<RouteTask>>([], (previousValue, route) {
            previousValue.addAll(route.routeTasks);
            return previousValue;
          }).where((routeTask) => routeTask.from.equalsTo(city)).map<Widget>((routeTask) => RouteTaskRowProgress(routeTask)),

        ],
      ),
    );
  }

  void routeStart(City to) {
    Company.instance.startTaskFromTo(from: city, to: to);
  }
}
