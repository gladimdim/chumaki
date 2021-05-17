import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

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
        children: [
          BorderedBottom(
            child: TitleText(ChumakiLocalizations.labelUnlockCity),
          ),
          if (citiesToUnlock.isEmpty) buildEmptyView(),
          if (citiesToUnlock.isNotEmpty) ...citiesToUnlock.map((unlockCity) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SmallCityAvatar(unlockCity),
                ),
                Expanded(
                  flex: 1,
                  child: BorderedBottom(
                    child: TextButton(
                      onPressed:
                          company.hasEnoughMoney(unlockCity.unlockPriceMoney)
                              ? () => buyCityRoute(unlockCity, company)
                              : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder(
                              stream: company.changes.where((event) =>
                                  event == COMPANY_EVENTS.MONEY_REMOVED ||
                                  event == COMPANY_EVENTS.MONEY_ADDED),
                              builder: (context, snapshot) => MoneyUnitView(
                                  unlockCity.unlockPriceMoney,
                                  isEnough: company.hasEnoughMoney(
                                      unlockCity.unlockPriceMoney))),
                          TitleText(
                            ChumakiLocalizations.labelBuy,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList()
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
