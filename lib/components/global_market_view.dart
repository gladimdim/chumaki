import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/wagons/wagons_global_price_list.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'title_text.dart';
import 'package:chumaki/extensions/list.dart';

class GlobalMarketView extends StatefulWidget {
  final City currentCity;

  GlobalMarketView({required this.currentCity});

  @override
  _GlobalMarketViewState createState() => _GlobalMarketViewState();
}

class _GlobalMarketViewState extends State<GlobalMarketView> {
  late Resource selectedResource;

  @override
  void initState() {
    selectedResource = widget.currentCity.stock.stock.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    var currentResourceSellPrice = widget.currentCity.buyPriceForResource(
        selectedResource.cloneWithAmount(1), company.allCities);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExpandablePanel(
              title: TitleText(ChumakiLocalizations.labelWagonPricesInCities),
              content: WagonsGlobalPriceList(widget.currentCity)),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(ChumakiLocalizations.labelGlobalPrices),
                Image.asset("images/icons/money/money_2d.png", width: 55),
              ],
            ),
            content: Column(
              children: [
                Column(
                  children: RESOURCES.values.divideBy(9).map<Widget>(
                    (List<RESOURCES> resources) {
                      return Row(
                          children: resources.map((type) {
                        final resource = Resource.fromType(type);
                        final contains =
                            widget.currentCity.stock.hasResource(resource);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedResource = resource;
                            });
                          },
                          child: Opacity(
                            opacity: contains ? 1 : 0.4,
                            child: ResourceImageView(
                              resource.cloneWithAmount(1),
                              showAmount: selectedResource.sameType(resource),
                            ),
                          ),
                        );
                      }).toList());
                    },
                  ).toList(),
                ),
                ...allCitiesSortedByProfit(company, currentResourceSellPrice)
                    .divideBy(3)
                    .map((List<City> cityRow) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: cityRow.map<Widget>((city) {
                      var buyPrice = city.sellPriceForResource(
                          selectedResource, company.allCities,
                          withAmount: 1);
                      var saldo = buyPrice - currentResourceSellPrice;
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ActionButton(
                            onPress: () => _navigateToCity(city),
                            image: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallCityAvatar(
                                  city,
                                  showName: false,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: BorderedBottom(
                                    child: TitleText(
                                      "${ChumakiLocalizations.getForKey(
                                        city.localizedKeyName,
                                      )} (${city.stock.resourceInStock(selectedResource)?.amount ?? "0"})",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            action: Text(
                              ChumakiLocalizations.labelGoTo,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            subTitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                ChumakiLocalizations.labelPrice,
                                                textAlign: TextAlign.end,
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: MoneyUnitView(
                                                  Money(buyPrice))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                ChumakiLocalizations
                                                    .labelProfit,
                                                textAlign: TextAlign.end,
                                              )),
                                          Expanded(
                                            flex: 3,
                                            child: MoneyUnitView(Money(saldo),
                                                isEnough: saldo > 0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCity(City city) {
    final canvasState = globalViewerKey.currentState;
    if (canvasState == null) {
      return;
    }

    canvasState.navigateFromToCity(to: city);
  }

  List<City> allCitiesSortedByProfit(Company company, double currentSellPrice) {
    List<City> cities =
        company.allCities.where((city) => city != widget.currentCity).toList();

    cities.sort((
      cityA,
      cityB,
    ) {
      var buyPriceA = cityA.sellPriceForResource(
          selectedResource, company.allCities,
          withAmount: 1);
      var saldoA = buyPriceA - currentSellPrice;
      var buyPriceB = cityB.sellPriceForResource(
          selectedResource, company.allCities,
          withAmount: 1);
      var saldoB = buyPriceB - currentSellPrice;

      if (saldoA > saldoB) {
        return -1;
      } else if (saldoA < saldoB) {
        return 1;
      } else {
        return 0;
      }
    });
    return cities;
  }
}
