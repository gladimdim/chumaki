import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/wagons/stock_wagon_status.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/extensions/list.dart';

class ResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;
  final City city;
  final Wagon wagon;
  final int amountTradeValue;

  ResourceCategoryGroup({
    required this.resources,
    required this.city,
    required this.wagon,
    required this.amountTradeValue,
  });

  Widget build(BuildContext context) {
    return ExpandablePanel(
      isUnlocked: _isCategoryUnlocked(),
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(categoryToImagePath(resources.first.category), width: 92),
                Text(
                  ChumakiLocalizations.getForKey(
                    resourceCategoryToLocalizedKey(resources.first.category),
                  ),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            StockWagonStatus(wagon: wagon, category: resources.first.category),
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ChumakiLocalizations.labelBuy,
                style: Theme.of(context).textTheme.headline4,
              ),
              ...resources.divideBy(2).map((List<Resource> resources) {
                return Row(
                  children: resources.map((resource) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: CityWagonResourceExchange(
                        wagon: wagon,
                        city: city,
                        resource: resource,
                        amountTradeValue: amountTradeValue,
                        mode: EXCHANGE_MOD.BUY,
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ChumakiLocalizations.labelSell,
                style: Theme.of(context).textTheme.headline4,
              ),
              ...resources.divideBy(2).map((List<Resource> resources) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: resources.map((resource) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: CityWagonResourceExchange(
                        wagon: wagon,
                        city: city,
                        resource: resource,
                        amountTradeValue: amountTradeValue,
                        mode: EXCHANGE_MOD.SELL,
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ],
          )
        ],
      ),
    );
  }

  bool _isCategoryUnlocked() {
    final cat = resources.first.category;
    final leader = wagon.leader;
    if (leader == null) {
      return DEFAULT_CATEGORIES.contains(cat);
    } else {
      return leader.hasPerkForCategory(cat) || DEFAULT_CATEGORIES.contains(cat);
    }
  }
}
