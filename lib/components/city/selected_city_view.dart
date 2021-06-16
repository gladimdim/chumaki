
import 'package:chumaki/components/city/can_unlock_cities_view.dart';
import 'package:chumaki/components/city/city_wagons_view.dart';
import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/global_market_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/components/ui/city_menu_item_view.dart';
import 'package:chumaki/components/wagons/wagon_details.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 780.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView(this.city);

  @override
  _SelectedCityViewState createState() => _SelectedCityViewState();
}

class _SelectedCityViewState extends State<SelectedCityView> {
  CityMenuItem? selectedItem;
  Widget? detailsContent;

  CityMenuItem? selectedButton;

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
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
                    children: [
                      CityMenuItem(
                          image: Image.asset(
                            "images/wagon/wheel.png",
                            width: 128,
                          ),
                          label: TitleText(ChumakiLocalizations.labelCompanies),
                          content: CityWagonsView(city: widget.city)),
                      CityMenuItem(
                          image: Image.asset(
                            "images/icons/market/market.png",
                            width: 128,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleText(ChumakiLocalizations.labelMarket),
                              ...widget.city.produces
                                  .map((resource) => ResourceImageView(
                                        resource,
                                        size: 32,
                                      ))
                                  .toList(),
                            ],
                          ),
                          content: CityStockView(city: widget.city)),
                      CityMenuItem(
                          image: Image.asset(
                            "images/icons/market/market2.png",
                            width: 128,
                          ),
                          label:
                              TitleText(ChumakiLocalizations.labelWorldMarket),
                          content: GlobalMarketView(currentCity: widget.city)),
                      if (company.cityCanUnlockMore(widget.city)) CityMenuItem(
                          image: Image.asset(
                            "images/cities/church.png",
                            width: 128,
                          ),
                          label: TitleText(
                              ChumakiLocalizations.labelMenuBuyNewRoutes),
                          content: CanUnlockCitiesView(widget.city)),
                      ...widget.city.wagons.map(
                        (wagon) => CityMenuItem(
                            image: StreamBuilder(
                              stream: wagon.changes,
                              builder: (context, _) => Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipOval(
                                      child: Image.asset(wagon.getImagePath(),
                                          width: 128),
                                    ),
                                  ),
                                  wagon.leader == null
                                      ? Container()
                                      : StreamBuilder(
                                          stream: wagon.leader!.changes,
                                          builder: (context, _) => Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Row(
                                              children: wagon.leader!.perks
                                                  .map(
                                                    (perk) => Image.asset(
                                                      categoryToImagePath(perk
                                                          .affectsResourceCategory),
                                                      width: 32,
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            label: StreamBuilder(
                                stream: wagon.changes,
                                builder: (context, snap) => TitleText(
                                    ChumakiLocalizations.getForKey(
                                        wagon.fullLocalizedName))),
                            content: WagonDetails(
                              wagon: wagon,
                              city: widget.city,
                            )),
                      )
                    ].map((action) {

                      return CityMenuItemView(
                        isSelected: selectedButton == action,
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
    if (selectedButton == action) {
      selectedButton = null;
    } else {
      selectedButton = action;
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
