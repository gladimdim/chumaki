import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/action_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/ui/resized_image.dart';
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
                ResizedImage("images/icons/money/money_2d.png", width: 55),
              ],
            ),
            content: Column(
              children: [
                Column(
                  children: RESOURCES.values.divideBy(9).map<Widget>(
                    (List<RESOURCES> resources) {
                      return Row(
                          children: resources.map((type) {
                        final resource = widget.currentCity.stock
                                .resourceInStock(Resource.fromType(type)) ??
                            Resource.fromType(type).cloneWithAmount(0);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedResource = resource;
                            });
                          },
                          child: Transform.scale(
                            scale:
                                selectedResource.sameType(resource) ? 1.5 : 1.0,
                            child: Opacity(
                              opacity: resource.amount != 0 ? 1 : 0.4,
                              child: ResourceImageView(
                                resource,
                                showAmount: true,
                              ),
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
                  return SizedBox(
                    height: 205,
                    child: Row(
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
                            child: Opacity(
                              opacity: city.isUnlocked() ? 1 : 0.5,
                              child: ActionButton(
                                onPress: () => _navigateToCity(city),
                                image: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CityAvatar(
                                      city: city,
                                      showName: false,
                                      width: 64,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: BorderedBottom(
                                        child: Column(
                                          children: [
                                            TitleText(
                                              "${ChumakiLocalizations.getForKey(
                                                city.localizedKeyName,
                                              )}",
                                            ),
                                            TitleText(
                                              "(${city.stock.resourceInStock(selectedResource)?.amount ?? "0"})",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                action: ActionText(
                                  ChumakiLocalizations.labelGoTo,
                                ),
                                subTitle: Opacity(
                                  opacity: city.isUnlocked() ? 1 : 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                                      ChumakiLocalizations
                                                          .labelPrice,
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
                                                  child: MoneyUnitView(
                                                      Money(saldo),
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
                            ),
                          ),
                        );
                      }).toList(),
                    ),
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

    canvasState.navigateToCity(to: city);
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
