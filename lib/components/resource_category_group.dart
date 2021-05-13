import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/wagons/stock_wagon_status.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/components/title_text.dart';

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
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText(
              ChumakiLocalizations.getForKey(
                  resourceCategoryToLocalizedKey(resources.first.category)),
            ),
            StockWagonStatus(wagon: wagon, category: resources.first.category),
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 14.0, left: 2, right: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(Wagon.imagePath, width: 64),
                Image.asset("images/cities/church.png", width: 64)
              ],
            ),
            ...resources.map((resource) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: CityWagonResourceExchange(
                    wagon: wagon,
                    city: city,
                    resource: resource,
                    amountTradeValue: amountTradeValue),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
