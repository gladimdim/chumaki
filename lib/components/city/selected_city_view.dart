import 'package:chumaki/components/city/buy_new_wagon_view.dart';
import 'package:chumaki/components/city/city_pub_view.dart';
import 'package:chumaki/components/city/city_local_market.dart';
import 'package:chumaki/components/price_comparison.dart';
import 'package:chumaki/components/route_task_row_progress.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:chumaki/components/ui/selectable_button.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/task.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 700.0;

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
      builder: (context, data) => ConstrainedBox(
        constraints: BoxConstraints(maxWidth: CITY_DETAILS_VIEW_WIDTH),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorderedBottom(
              child: BorderedContainerWithSide(
                borderDirection: AxisDirection.right,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: CITY_DETAILS_VIEW_WIDTH/ 4, minHeight: 200, maxHeight: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: advisorSelected,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/wagon/cart.png",
                                  width: 128,
                                ),
                                TitleText(
                                    ChumakiLocalizations.labelBuyNewWagon),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: localMarketSelected,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/resources/money/money.png",
                                    width: 128,
                                  ),
                                  TitleText(ChumakiLocalizations.labelMarket),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: worldMarketSelected,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/resources/money/money.png",
                                    width: 128,
                                  ),
                                  TitleText(
                                      ChumakiLocalizations.labelWorldMarket),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (showAdvisor) Expanded(flex: 1, child: CityPubView(city: widget.city)),
            if (showWorldMarket) Expanded(flex: 1, child: PriceComparison(currentCity: widget.city)),
            if (showLocalMarket) ...[
              Expanded(flex: 1, child: CityLocalMarket(city: widget.city)),
              // TitleText("Incoming companies: "),
              // ...company.cityRoutes
              //     .where((route) =>
              //         route.to.equalsTo(widget.city) ||
              //         route.from.equalsTo(widget.city))
              //     .fold<List<RouteTask>>([], (previousValue, route) {
              //       previousValue.addAll(route.routeTasks);
              //       return previousValue;
              //     })
              //     .where((routeTask) => routeTask.to.equalsTo(widget.city))
              //     .map<Widget>((routeTask) =>
              //         RouteTaskRowProgress(routeTask, widget.city)),
              // TitleText("Outgoing companies: "),
              // ...company.cityRoutes
              //     .where((route) =>
              //         route.to.equalsTo(widget.city) ||
              //         route.from.equalsTo(widget.city))
              //     .fold<List<RouteTask>>([], (previousValue, route) {
              //       previousValue.addAll(route.routeTasks);
              //       return previousValue;
              //     })
              //     .where((routeTask) => routeTask.from.equalsTo(widget.city))
              //     .map<Widget>((routeTask) =>
              //         RouteTaskRowProgress(routeTask, widget.city)),
            ],
          ],
        ),
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
