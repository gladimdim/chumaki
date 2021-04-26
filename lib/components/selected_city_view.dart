import 'package:chumaki/components/advisor_for_city.dart';
import 'package:chumaki/components/price_comparison.dart';
import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/components/stock_resource_category_group.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/selectable_button.dart';
import 'package:chumaki/components/wagons_in_city.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/views/inherited_company.dart';
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
  bool showAdvisor = false;
  bool showWorldMarket = false;

  @override
  Widget build(BuildContext context) {
    var company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: company.changes,
      builder: (context, data) => Column(
        children: [
          StreamBuilder(
            stream: widget.city.changes.stream,
            builder: (context, data) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectableButton(
                  selected: showLocalMarket,
                  onPressed: localMarketSelected,
                  child: TitleText(
                      "Market"),
                ),
                SelectableButton(
                    selected: showAdvisor,
                    onPressed: advisorSelected,
                    child: TitleText("Advisor")),
                SelectableButton(
                    selected: showWorldMarket,
                    onPressed: worldMarketSelected,
                    child: TitleText("World Market")),
              ],
            ),
          ),
          if (showAdvisor) AdvisorForCity(city: widget.city),
          if (showWorldMarket) PriceComparison(currentCity: widget.city),
          if (showLocalMarket) ...[
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
            TitleText("Incoming companies: "),
            ...company.cityRoutes
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
            TitleText("Outgoing companies: "),
            ...company.cityRoutes
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

  void worldMarketSelected() {
    setFlags(false, false, true);
  }

  void localMarketSelected() {
    setFlags(true, false, false);
  }

  void advisorSelected() {
    setFlags(false, true, false);
  }

  setFlags(bool first, bool second, bool third) {
    setState(() {
      showLocalMarket = first;
      showAdvisor = second;
      showWorldMarket = third;
    });
  }
}
