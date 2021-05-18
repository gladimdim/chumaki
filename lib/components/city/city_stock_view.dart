import 'package:chumaki/components/stock_resource_category_group.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class CityStockView extends StatelessWidget {
  final City city;

  CityStockView({required this.city});

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: company.refToCityByName(city).changes.stream,
      builder: (context, data) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText("${ChumakiLocalizations.getForKey(city.localizedKeyName)} ${ChumakiLocalizations.labelContains}"),
            if (!city.stock.isEmpty)
              Column(
                children: groupResourcesByCategory(city.stock.iterator.toList())
                    .map<Widget>((resources) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: StockResourceCategoryGroup(
                        resources: resources, forCity: city),
                  );
                }).toList(),
              ),
            if (city.stock.isEmpty)
              Text(
                ChumakiLocalizations.labelNothing,
              ),
          ],
        );
      },
    );
  }
}
