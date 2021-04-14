import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/components/stock_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/wagons_in_city.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 300.0;

class SelectedCityView extends StatelessWidget {
  final City city;

  SelectedCityView({required this.city});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Company.instance.changes,
      builder: (context, data) => Column(
        children: [
          StreamBuilder(
            stream: city.changes.stream,
            builder: (context, data) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText("${city.name}: ${city.wagons.length}"),
                Image.asset(Wagon.imagePath, width: 64),
              ],
            ),
          ),
          ...city.connectsTo().map(
            (toCity) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Connects to: ${toCity.name}"),
                  IconButton(
                    icon: Icon(Icons.not_started),
                    onPressed:
                        city.wagons.isEmpty ? null : () => routeStart(toCity),
                  ),
                ],
              );
            },
          ),
          WagonsInCity(city: city),
          TitleText("Вхідні: "),
          ...Company.instance.cityRoutes
              .where((route) =>
                  route.to.equalsTo(city) || route.from.equalsTo(city))
              .fold<List<RouteTask>>([], (previousValue, route) {
                previousValue.addAll(route.routeTasks);
                return previousValue;
              })
              .where((routeTask) => routeTask.to.equalsTo(city))
              .map<Widget>(
                  (routeTask) => RouteTaskRowProgress(routeTask, city)),
          TitleText("Вихідні: "),
          ...Company.instance.cityRoutes
              .where((route) =>
                  route.to.equalsTo(city) || route.from.equalsTo(city))
              .fold<List<RouteTask>>([], (previousValue, route) {
                previousValue.addAll(route.routeTasks);
                return previousValue;
              })
              .where((routeTask) => routeTask.from.equalsTo(city))
              .map<Widget>(
                  (routeTask) => RouteTaskRowProgress(routeTask, city)),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.black),
              ),
            ),
            child: StreamBuilder(
              stream: city.changes.stream,
              builder: (context, data) => StockView(
                city.stock.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void routeStart(City to) {
    Company.instance.startTaskFromTo(from: city, to: to);
  }
}
