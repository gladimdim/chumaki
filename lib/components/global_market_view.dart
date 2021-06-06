import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/wagons/wagons_global_price_list.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
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
    var currentSell = widget.currentCity.prices
        .sellPriceForResource(selectedResource.cloneWithAmount(1));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExpandablePanel(
              title: TitleText(ChumakiLocalizations.labelWagonPricesInCities),
              content: WagonsGlobalPriceList(widget.currentCity)),
          ExpandablePanel(
            title: TitleText(ChumakiLocalizations.labelGlobalPrices),
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
                ...company.allCities
                    .where((city) => city != widget.currentCity)
                    .toList()
                    .divideBy(3)
                    .map((List<City> cityRow) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: cityRow.map<Widget>((city) {
                      var buyPrice = city.prices
                          .buyPriceForResource(selectedResource, withAmount: 1);
                      var saldo = buyPrice - currentSell;
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: BorderedAll(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: BorderedBottom(
                                    child: TitleText(
                                        ChumakiLocalizations.getForKey(
                                            city.localizedKeyName)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SmallCityAvatar(
                                      city,
                                      showName: false,
                                    ),
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
}
