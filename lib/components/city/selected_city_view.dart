import 'dart:async';

import 'package:chumaki/components/city/can_unlock_cities_view.dart';
import 'package:chumaki/components/city/city_wagons_view.dart';
import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/global_market_view.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/components/ui/city_menu_item_view.dart';
import 'package:chumaki/components/wagons/wagon_details.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 780.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView(this.city);

  @override
  _SelectedCityViewState createState() => _SelectedCityViewState();
}

class _SelectedCityViewState extends State<SelectedCityView> {
  late List<CityMenuItem> actions;
  Widget? detailsContent;

  @override
  void initState() {
    super.initState();
    actions = getStandardButtons();
    actions.addAll(getWagonButtons());
    widget.city.changes.listen((event) => updateActions());
  }

  void updateActions() {
    final newActions = getStandardButtons()..addAll(getWagonButtons());
    setState(() {
      if (newActions.length != actions.length) {
        selectedButton = null;
      }
      actions = newActions;
    });
  }

  List<CityMenuItem> getStandardButtons() => [
        CityMenuItem(
            imagePath: "images/wagon/wheel.png",
            label: ChumakiLocalizations.labelCompanies,
            content: CityWagonsView(city: widget.city)),
        CityMenuItem(
            imagePath: "images/icons/market/market.png",
            label: ChumakiLocalizations.labelMarket,
            content: CityStockView(city: widget.city)),
        CityMenuItem(
            imagePath: "images/icons/market/market2.png",
            label: ChumakiLocalizations.labelWorldMarket,
            content: GlobalMarketView(currentCity: widget.city)),
        CityMenuItem(
            imagePath: "images/cities/church.png",
            label: ChumakiLocalizations.labelMenuBuyNewRoutes,
            content: CanUnlockCitiesView(widget.city)),
      ];

  List<CityMenuItem> getWagonButtons() {
    return widget.city.wagons
        .map(
          (wagon) => CityMenuItem(
              imagePath: "images/wagon/wagon.png",
              label: "${wagon.fullLocalizedName}",
              content: WagonDetails(
                wagon: wagon,
                city: widget.city,
              )),
        )
        .toList();
  }

  CityMenuItem? selectedButton;

  @override
  void didUpdateWidget(SelectedCityView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.city.wagons.length != widget.city.wagons.length) {
      updateActions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.city.changes,
      builder: (context, data) => AnimatedSize(
        alignment: Alignment.topLeft,
        duration: Duration(milliseconds: 400),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: selectedButton == null ? 195 : CITY_DETAILS_VIEW_WIDTH),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: CITY_DETAILS_VIEW_WIDTH / 4,
                  minHeight: 150,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: actions.map((action) {
                      return CityMenuItemView(
                        menuItem: action,
                        onPress: () => handleMenuItemPress(action),
                      );
                    }).toList()),
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
