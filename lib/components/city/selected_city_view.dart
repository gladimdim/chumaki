import 'package:chumaki/components/city/city_pub_view.dart';
import 'package:chumaki/components/city/city_local_market.dart';
import 'package:chumaki/components/price_comparison.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/components/ui/city_menu_item_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

const CITY_DETAILS_VIEW_WIDTH = 700.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView(this.city);

  @override
  _SelectedCityViewState createState() => _SelectedCityViewState();
}

class _SelectedCityViewState extends State<SelectedCityView> {
  late List<CityMenuItem> actions = [
    CityMenuItem(
        imagePath: "images/wagon/cart.png",
        label: ChumakiLocalizations.labelCompanies,
        content: CityPubView(city: widget.city)),
    CityMenuItem(
        imagePath: "images/resources/money/money.png",
        label: ChumakiLocalizations.labelMarket,
        content: CityLocalMarket(city: widget.city)),
    CityMenuItem(
        imagePath: "images/resources/money/money.png",
        label: ChumakiLocalizations.labelWorldMarket,
        content: PriceComparison(currentCity: widget.city))
  ];

  CityMenuItem? selectedButton;

  @override
  Widget build(BuildContext context) {
    var company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: company.changes,
      builder: (context, data) => AnimatedSize(
        alignment: Alignment.topLeft,
        duration: Duration(milliseconds: 400),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: selectedButton == null ? 176 : CITY_DETAILS_VIEW_WIDTH),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedBottom(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: CITY_DETAILS_VIEW_WIDTH / 4,
                      minHeight: 200,
                      maxHeight: 800),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: actions.map((action) {
                        return Expanded(
                          flex: 1,
                          child: CityMenuItemView(
                            menuItem: action,
                            onPress: () => handleMenuItemPress(action),
                          ),
                        );
                      }).toList()),
                ),
              ),
              Expanded(
                flex: 1,
                child: AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: getContent(),
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: selectedButton != null
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 800),
                ),
              ),
              // ...[
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
              // ],
            ],
          ),
        ),
      ),
    );
  }

  handleMenuItemPress(CityMenuItem action) {
    actions.forEach((element) {
      element.isSelected = false;
    });

    if (selectedButton == action) {
      selectedButton = null;
    } else {
      selectedButton = action;
      action.isSelected = true;
    }
    setState(() {});
  }

  Widget getContent() {
    var button = selectedButton;
    return button != null
        ? button.content
        : Container(
            width: 0,
            height: 0,
          );
  }
}
