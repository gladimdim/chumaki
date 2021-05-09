import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class SelectedCityLockedView extends StatelessWidget {
  final City city;

  const SelectedCityLockedView(this.city);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return Column(
      children: [
        BorderedBottom(
          child: TitleText("This city is locked"),
        ),
        TitleText("You can unlock it at:"),
        Column(
          children: company.allCities.where((cityThatCanUnlock) {
            var realCity = company.refToCityByName(city);
            return company
                .citiesToRealCities(cityThatCanUnlock.unlocksCities)
                .contains(realCity);
          }).map((cityThatUnlocks) {
            return SmallCityAvatar(cityThatUnlocks);
          }).toList(),
        ),
        CityStockView(city: city),
      ],
    );
  }
}
