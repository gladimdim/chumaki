import 'package:chumaki/components/city/buy_new_wagon_view.dart';
import 'package:chumaki/components/city/can_unlock_cities_view.dart';
import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:chumaki/extensions/list.dart';

class CityPubView extends StatefulWidget {
  final City city;

  CityPubView({required this.city});

  @override
  _CityPubViewState createState() => _CityPubViewState();
}

class _CityPubViewState extends State<CityPubView> {
  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: company.changes.where((event) =>
          event == COMPANY_EVENTS.MONEY_REMOVED ||
          event == COMPANY_EVENTS.MONEY_ADDED),
      builder: (context, snapshot) => Column(
        children: [
          BuyNewWagonView(widget.city),
          if (canUnlockMoreCities(company))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CanUnlockCitiesView(widget.city),
            ),
          ...widget.city.wagons.map((wagon) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandablePanel(
                title: TitleText(
                    "${ChumakiLocalizations.labelTotalPrice}: ${wagon.fullLocalizedName}"),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: calculateTopForWagon(wagon, company)
                      .divideBy(3)
                      .map((rowResult) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: rowResult.map((result) {
                        return Column(
                          children: [
                            SmallCityAvatar(result.item1),
                            MoneyUnitView(Money(result.item2),
                                isEnough: result.item2 > 0),
                          ],
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  List<Tuple2<City, double>> calculateTopForWagon(
      Wagon wagon, Company company) {
    var result = company.allCities.map((city) {
      return Tuple2(city, priceForFullWagonInCity(wagon, city));
    }).toList();
    result.sort((a, b) {
      return (a.item2 - b.item2) > 0 ? -1 : 1;
    });
    return result;
  }

  double priceForFullWagonInCity(Wagon wagon, City city) {
    return wagon.stock.iterator.fold(0, (previousValue, resource) {
      var price = city.prices.buyPriceForResource(resource);
      return previousValue + price;
    });
  }

  bool canUnlockMoreCities(Company company) {
    return company.canUnlockMoreCities(widget.city);
  }
}
