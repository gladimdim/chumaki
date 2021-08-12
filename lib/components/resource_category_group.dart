import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/components/wagons/stock_wagon_status.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/extensions/list.dart';

class ResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;
  final City city;
  final Wagon wagon;

  ResourceCategoryGroup({
    required this.resources,
    required this.city,
    required this.wagon,
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
                ResizedImage(categoryToImagePath(resources.first.category),
                    width: 92),
                GameText(
                  ChumakiLocalizations.getForKey(
                    resourceCategoryToLocalizedKey(resources.first.category),
                  ),
                  addStyle: Theme.of(context).textTheme.headline3,
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
                ChumakiLocalizations.labelBuy2,
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
                ChumakiLocalizations.labelSell2,
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
