import 'package:chumaki/components/advisor_for_city.dart';
import 'package:chumaki/components/city/city_local_market.dart';
import 'package:chumaki/components/price_comparison.dart';
import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/selectable_button.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 400.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView(this.city);

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
            builder: (context, data) => BorderedBottom(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectableButton(
                    selected: showLocalMarket,
                    onPressed: localMarketSelected,
                    child: TitleText(
                        ChumakiLocalizations.labelMarket),
                  ),
                  SelectableButton(
                      selected: showAdvisor,
                      onPressed: advisorSelected,
                      child: TitleText(ChumakiLocalizations.labelPub)),
                  SelectableButton(
                      selected: showWorldMarket,
                      onPressed: worldMarketSelected,
                      child: TitleText(ChumakiLocalizations.labelWorldMarket)),
                ],
              ),
            ),
          ),
          if (showAdvisor) AdvisorForCity(city: widget.city),
          if (showWorldMarket) PriceComparison(currentCity: widget.city),
          if (showLocalMarket) ...[
            CityLocalMarket(city: widget.city),
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
