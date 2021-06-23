import 'package:chumaki/components/leader/leader_avatar.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:chumaki/components/ui/bordered_top.dart';
import 'package:chumaki/components/leader/leader_view.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/wagons/wagon_dispatcher.dart';
import 'package:chumaki/components/wagons/wagon_resource_exchanger.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/wagons/buy_leader_view.dart';

class WagonDetails extends StatelessWidget {
  final Wagon wagon;
  final City city;

  WagonDetails({required this.wagon, required this.city});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: wagon.changes,
      builder: (context, snap) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BorderedBottom(
            child: BorderedTop(
              child: Center(
                child: Text(
                  ChumakiLocalizations.getForKey(wagon.fullLocalizedName),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          VerticalDivider(),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ChumakiLocalizations.labelLeader,
                  style: Theme.of(context).textTheme.headline4,
                ),
                if (wagon.leader != null) LeaderAvatar(leader: wagon.leader!),
              ],
            ),
            content: wagon.leader == null
                ? BorderedContainerWithSides(
                    borderDirections: [AxisDirection.up, AxisDirection.down],
                    child: BuyLeaderView(
                      wagon: wagon,
                    ))
                : BorderedAll(child: LeaderView(wagon.leader!)),
          ),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ChumakiLocalizations.labelSend,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Image.asset("images/icons/paths/paths.png", width: 64),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WagonDispatcher(wagon: wagon, city: city),
            ),
          ),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ChumakiLocalizations.labelTrade,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Image.asset("images/icons/money/money.png", width: 64),
              ],
            ),
            content: WagonResourceExchanger(wagon, city),
          ),
        ],
      ),
    );
  }
}
