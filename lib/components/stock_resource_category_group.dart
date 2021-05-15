import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/components/money_unit_view.dart';
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
    return ExpandablePanel(
      title: TitleText(ChumakiLocalizations.getForKey(
          resourceCategoryToLocalizedKey(resources.first.category))),
      content: SingleChildScrollView(
        child: Column(
          children:
              resources.divideBy(2).toList().map((List<Resource> reses) {
            return Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
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
                              Text("${ChumakiLocalizations.labelBuy}:"),
                              MoneyUnitView(Money(forCity.prices
                                  .sellPriceForResource(
                                      resource.cloneWithAmount(1)))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${ChumakiLocalizations.labelSell}:"),
                              MoneyUnitView(Money(forCity.prices
                                  .buyPriceForResource(resource,
                                      withAmount: 1))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
