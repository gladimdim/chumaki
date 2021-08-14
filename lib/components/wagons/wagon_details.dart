import 'package:chumaki/components/leader/leader_avatar.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:chumaki/components/ui/bordered_top.dart';
import 'package:chumaki/components/leader/leader_view.dart';
import 'package:chumaki/components/ui/expandable_panel.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/inline_help.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/components/wagons/wagon_dispatcher.dart';
import 'package:chumaki/components/wagons/wagon_resource_exchanger.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagons/wagon.dart';
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
                child: GameText(
                  ChumakiLocalizations.getForKey(wagon.fullLocalizedName),
                  addStyle: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameText(
                  ChumakiLocalizations.labelLeader,
                  addStyle: Theme.of(context).textTheme.headline3,
                ),
                LeaderAvatar(leader: wagon.leader),
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
                GameText(
                  ChumakiLocalizations.labelTrade,
                  addStyle: Theme.of(context).textTheme.headline3,
                ),
                ResizedImage("images/icons/money/money.png", width: 64),
              ],
            ),
            content: WagonResourceExchanger(wagon, city),
          ),
          ExpandablePanel(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GameText(
                  ChumakiLocalizations.labelSend,
                  addStyle: Theme.of(context).textTheme.headline3,
                ),
                ResizedImage("images/icons/paths/paths.png", width: 64),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WagonDispatcher(wagon: wagon, city: city),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InlineHelp(
                "${ChumakiLocalizations.labelHelpTextWagons}\n ${ChumakiLocalizations.labelHelpTextMarket}"),
          ),
        ],
      ),
    );
  }
}
