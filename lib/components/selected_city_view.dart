import 'package:chumaki/components/price_comparison.dart';
import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/components/stock_resource_category_group.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/wagons_in_city.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 400.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView({required this.city});

  @override
  _SelectedCityViewState createState() => _SelectedCityViewState();
}

class _SelectedCityViewState extends State<SelectedCityView> {
  bool showLocalMarket = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Company.instance.changes,
      builder: (context, data) => Column(
        children: [
          StreamBuilder(
            stream: widget.city.changes.stream,
            builder: (context, data) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TitleText("${widget.city.name}: ${widget.city.wagons.length}"),
                Image.asset(Wagon.imagePath, width: 64),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2,),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          showLocalMarket = !showLocalMarket;
                        });
                      },
                      child: TitleText(showLocalMarket
                          ? "Світовий ринок"
                          : "Ринок ${widget.city.name}")),
                ),
              ],
            ),
          ),

          if (!showLocalMarket) PriceComparison(currentCity: widget.city),
          if (showLocalMarket) ...[
            ...widget.city.connectsTo().map(
              (toCity) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(toCity.name),
                    IconButton(
                      icon: Icon(Icons.not_started),
                      onPressed: widget.city.wagons.isEmpty
                          ? null
                          : () => routeStart(toCity),
                    ),
                  ],
                );
              },
            ),
            WagonsInCity(city: widget.city),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: StreamBuilder(
                  stream: widget.city.changes.stream,
                  builder: (context, data) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleText("Містить"),
                        if (!widget.city.stock.isEmpty)
                          Column(
                            children: groupResourcesByCategory(
                                    widget.city.stock.iterator.toList())
                                .map<Widget>((resources) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: StockResourceCategoryGroup(
                                    resources: resources, forCity: widget.city),
                              );
                            }).toList(),
                          ),
                        if (widget.city.stock.isEmpty) Text("Нічого"),
                      ],
                    );
                  }),
            ),
            TitleText("Вхідні: "),
            ...Company.instance.cityRoutes
                .where((route) =>
                    route.to.equalsTo(widget.city) ||
                    route.from.equalsTo(widget.city))
                .fold<List<RouteTask>>([], (previousValue, route) {
                  previousValue.addAll(route.routeTasks);
                  return previousValue;
                })
                .where((routeTask) => routeTask.to.equalsTo(widget.city))
                .map<Widget>((routeTask) =>
                    RouteTaskRowProgress(routeTask, widget.city)),
            TitleText("Вихідні: "),
            ...Company.instance.cityRoutes
                .where((route) =>
                    route.to.equalsTo(widget.city) ||
                    route.from.equalsTo(widget.city))
                .fold<List<RouteTask>>([], (previousValue, route) {
                  previousValue.addAll(route.routeTasks);
                  return previousValue;
                })
                .where((routeTask) => routeTask.from.equalsTo(widget.city))
                .map<Widget>((routeTask) =>
                    RouteTaskRowProgress(routeTask, widget.city)),
          ],
        ],
      ),
    );
  }

  void routeStart(City to) {
    Company.instance.startTaskFromTo(from: widget.city, to: to);
  }
}
