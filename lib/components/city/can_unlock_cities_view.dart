import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class CanUnlockCitiesView extends StatelessWidget {
  final City city;

  const CanUnlockCitiesView(this.city);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BorderedBottom(
          child: TitleText("Buy routes to these cities: "),
        ),
        ...city.unlocksCities
            .where((unlockCity) => !unlockCity.isUnlocked())
            .map((unlockCity) {
          return Row(
            children: [
              SmallCityAvatar(unlockCity),
              MoneyUnitView(unlockCity.unlockPriceMoney),
            ],
          );
        }).toList()
      ],
    );
  }
}
