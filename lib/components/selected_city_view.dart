import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:flutter/material.dart';

class SelectedCityView extends StatelessWidget {
  final City city;

  SelectedCityView({required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ...Company.instance.tasks.where((task) => task.to.equalsTo(city)).map(
              (task) => RouteTaskRowProgress(task),
            ),
        Text("Out: "),
        ...Company.instance.tasks.where((task) => task.from.equalsTo(city)).map(
              (task) => RouteTaskRowProgress(task),
            ),

      ],
    );
  }

  void routeStart(City to) {
    Company.instance.startTaskFromTo(from: city, to: to);
  }
}
