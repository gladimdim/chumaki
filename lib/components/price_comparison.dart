import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'title_text.dart';
import 'package:chumaki/extensions/list.dart';

class PriceComparison extends StatefulWidget {
  final City currentCity;

  PriceComparison({required this.currentCity});

  @override
  _PriceComparisonState createState() => _PriceComparisonState();
}

class _PriceComparisonState extends State<PriceComparison> {
  late Resource selectedResource;

  @override
  void initState() {
    selectedResource = widget.currentCity.stock.stock.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final company = InheritedCompany.of(context).company;
    var currentSell =
    widget.currentCity.prices.sellPriceForResource(selectedResource.cloneWithAmount(1));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
                children: RESOURCES.values.divideBy(7)
                    .map<Widget>((List<RESOURCES> resources) {
                  return Row(
                      children: resources.map((type) {
                        final resource = Resource.fromType(type);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedResource = resource;
                            });
                          },
                          child: ResourceImageView(
                            resource.cloneWithAmount(1),
                            showAmount: selectedResource.sameType(resource),
                          ),
                        );
                      }).toList());
                },).toList(),
          ),
          ...company.allCities
              .where((city) => city != widget.currentCity)
              .toList()
              .divideBy(2)
              .map((List<City> cityRow) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cityRow.map<Widget>((city) {
                var buyPrice = city.prices.buyPriceForResource(
                    selectedResource, withAmount: 1);
                var saldo = buyPrice - currentSell;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GroupedControl(
                    borderColor: Colors.blueGrey,
                    height: 80,
                    titleHeight: 25,
                    titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
                    width: 180,
                    title: TitleText(ChumakiLocalizations.getForKey(city.localizedKeyName)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22.0, left: 8.0,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Price:"),
                              MoneyUnitView(Money(buyPrice)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Profit:"),
                              MoneyUnitView(Money(saldo), isEnough: saldo > 0),
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
    );
  }
}
