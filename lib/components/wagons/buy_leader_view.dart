import 'package:flutter/material.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
class BuyLeaderView extends StatelessWidget {
  final Wagon wagon;
  BuyLeaderView({required this.wagon});
  final Leader _leader = Leader("Dmytro");

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return ActionButton(
      onPress: () {
        company.hireLeader(leader: _leader, forWagon: wagon);
      },
      image: ClipOval(
        child: Image.asset("images/leaders/leader1.png"),
      ),
      subTitle: MoneyUnitView(Leader.defaultAcquirePrice),
      action: Text(ChumakiLocalizations.labelHire),
    );
  }
}
