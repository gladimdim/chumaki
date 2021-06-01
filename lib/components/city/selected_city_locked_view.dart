import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class SelectedCityLockedView extends StatelessWidget {
  final City city;

  const SelectedCityLockedView(this.city);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: CITY_DETAILS_VIEW_WIDTH,
      ),
      child: Column(
        children: [
          BorderedBottom(
            child: Text(ChumakiLocalizations.labelCityIsLocked, style: Theme.of(context).textTheme.headline3,),
          ),
          Text(ChumakiLocalizations.labelUnlockAt, style: Theme.of(context).textTheme.headline5,),
          BorderedAll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: company.allCities.where((cityThatCanUnlock) {
                var realCity = company.refToCityByName(city);
                return company
                    .citiesToRealCities(cityThatCanUnlock.unlocksCities)
                    .contains(realCity);
              }).map((cityThatUnlocks) {
                return CityAvatarStacked(city: cityThatUnlocks);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BorderedAll(child: CityStockView(city: city)),
          ),
        ],
      ),
    );
  }
}
