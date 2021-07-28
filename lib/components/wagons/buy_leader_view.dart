import 'package:flutter/material.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/extensions/list.dart';

class BuyLeaderView extends StatelessWidget {
  final Wagon wagon;
  final List<Leader> _allLeaders = Leader.allLeaders();

  BuyLeaderView({required this.wagon});

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    final List<Wagon> wagons = company.allCities
        .where((city) => city.wagons.isNotEmpty)
        .fold<List<Wagon>>(List.empty(growable: true), (wags, city) {
      wags.addAll(city.wagons.where((wagon) => wagon.leader != null));
      return wags;
    });

    final freeLeaders = _allLeaders
        .where((leader) => wagons
            .where((wagon) =>
                wagon.leader!.localizedNameKey == leader.localizedNameKey)
            .isEmpty)
        .toList();

    return Column(
        children: freeLeaders.divideBy(4).map((leaders) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: leaders
              .map(
                (leader) => ActionButton(
                  onPress: company.hasEnoughMoney(Leader.defaultAcquirePrice)
                      ? () {
                          company.hireLeader(leader: leader, forWagon: wagon);
                        }
                      : null,
                  image: ClipOval(
                    child: Image.asset(leader.imagePath, width: 96, height: 96),
                  ),
                  subTitle: Column(
                    children: [
                      Text(ChumakiLocalizations.getForKey(
                          leader.fullLocalizedName)),
                      MoneyUnitView(Leader.defaultAcquirePrice),
                    ],
                  ),
                  action: Text(ChumakiLocalizations.labelHire),
                ),
              )
              .toList(),
        ),
      );
    }).toList());
  }
}
