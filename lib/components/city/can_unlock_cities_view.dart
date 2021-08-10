import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/action_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/extensions/list.dart';

class CanUnlockCitiesView extends StatelessWidget {
  final City city;

  const CanUnlockCitiesView(this.city);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    final citiesToUnlock = city.unlocksCities
        .map((fakeCity) => company.refToCityByName(fakeCity))
        .where((unlockCity) => !unlockCity.isUnlocked());
    return StreamBuilder(
      stream: company.changes,
      builder: (context, snapshot) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderedBottom(
            child: TitleText(ChumakiLocalizations.labelUnlockCity),
          ),
          if (citiesToUnlock.isEmpty) buildEmptyView(),
          if (citiesToUnlock.isNotEmpty)
            ...citiesToUnlock.toList().divideBy(4).map(
              (unlockCities) {
                return Row(
                  children: unlockCities
                      .map(
                        (unlockCity) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionButton(
                            onPress: company
                                    .hasEnoughMoney(unlockCity.unlockPriceMoney)
                                ? () => buyCityRoute(unlockCity, company)
                                : null,
                            image: CityAvatarStacked(
                              city: unlockCity,
                              width: 128,
                            ),
                            action: ActionText(ChumakiLocalizations.labelBuy),
                            subTitle: StreamBuilder(
                                stream: company.changes.where((event) =>
                                    event == COMPANY_EVENTS.MONEY_REMOVED ||
                                    event == COMPANY_EVENTS.MONEY_ADDED),
                                builder: (context, snapshot) => MoneyUnitView(
                                    unlockCity.unlockPriceMoney,
                                    isEnough: company.hasEnoughMoney(
                                        unlockCity.unlockPriceMoney))),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ).toList()
        ],
      ),
    );
  }

  Widget buildEmptyView() {
    return Center(child: TitleText(ChumakiLocalizations.textAllRoutesBought));
  }

  void buyCityRoute(City cityToUnlock, Company company) {
    company.unlockCity(cityToUnlock);
  }
}
