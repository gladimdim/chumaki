import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/components/money_unit.dart';
import 'package:flutter/material.dart';

import 'package:chumaki/extensions/list.dart';

class StockResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;
  final City forCity;

  StockResourceCategoryGroup({
    required this.resources,
    required this.forCity,
  });

  @override
  Widget build(BuildContext context) {
    return GroupedControl(
      title: TitleText(ChumakiLocalizations.of(context)
          .getForKey(resourceCategoryToLocalizedKey(resources.first.category))),
      borderColor: Colors.blueGrey,
      width: CITY_DETAILS_VIEW_WIDTH,
      height:
          130 * ((resources.length > 1) ? resources.length.toDouble() : 2) / 2,
      borderWidth: 3,
      titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Column(
            children:
                resources.divideBy(2).toList().map((List<Resource> reses) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: reses.map((resource) {
                  return GroupedControl(
                    title: ResourceImageView(
                      resource,
                      size: 32,
                    ),
                    titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
                    titleHeight: 25,
                    borderColor: resource.color,
                    borderWidth: 3,
                    height: 80,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Buy:"),
                              MoneyUnit(Money(forCity.prices
                                  .sellPriceForResource(
                                      resource.cloneWithAmount(1)))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sell:"),
                              MoneyUnit(Money(forCity.prices
                                  .buyPriceForResource(resource,
                                      withAmount: 1))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
