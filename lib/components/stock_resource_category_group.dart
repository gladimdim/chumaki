import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/views/inherited_company.dart';
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
    final company = InheritedCompany.of(context).company;
    return ExpandablePanel(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(categoryToImagePath(resources.first.category),
                  width: 72),
              TitleText(ChumakiLocalizations.getForKey(
                  resourceCategoryToLocalizedKey(resources.first.category))),
            ],
          ),
          Row(
            children: resources
                .where((res) => forCity.stock.hasResource(res))
                .map((res) => ResourceImageView(
                      res,
                      showAmount: true,
                    ))
                .toList(),
          )
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: resources.divideBy(2).toList().map((List<Resource> reses) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: reses.map((resource) {
                return Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: BorderedAll(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            BorderedBottom(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ResourceImageView(
                                    resource,
                                    size: 64,
                                    showAmount: true,
                                  ),
                                  Text(
                                      ChumakiLocalizations.getForKey(
                                          resource.fullLocalizedKey),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${ChumakiLocalizations.labelBuy}:",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                MoneyUnitView(Money(forCity.buyPriceForResource(
                                    resource.cloneWithAmount(1),
                                    company.allCities))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${ChumakiLocalizations.labelSell}:",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                MoneyUnitView(Money(
                                    forCity.sellPriceForResource(
                                        resource, company.allCities,
                                        withAmount: 1))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
