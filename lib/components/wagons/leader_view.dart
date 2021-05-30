import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/components/ui/bouncing_text.dart';
import 'package:chumaki/components/ui/perk_unit_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:flutter/material.dart';

class LeaderView extends StatelessWidget {
  final Leader leader;
  final double _progressWidth = 200;

  const LeaderView(this.leader);

  @override
  Widget build(BuildContext context) {
    final experience = leader.experience % 1000;
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(leader.imagePath, width: 64),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TitleText(ChumakiLocalizations.labelLevel),
                BouncingOutlinedText(
                  leader.level.toString(),
                  size: 24,
                  fontColor: Theme.of(context).primaryColor,
                  outlineColor: Theme.of(context).backgroundColor,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText("${ChumakiLocalizations.labelAvailablePerks}: "),
                    BouncingOutlinedText(leader.availablePerks.toString(),
                        size: 24),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: leader.perks
                        .map((perk) => PerkUnitView(perk))
                        .toList()),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TitleText(ChumakiLocalizations.labelExperience),
                SizedBox(
                  width: _progressWidth,
                  height: 30,
                  child: BorderedAll(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width:
                                experience / leader.levelDelta * _progressWidth,
                            height: 30,
                            color: Colors.yellow,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: BouncingOutlinedText(
                            "$experience/1000",
                            fontColor: Colors.yellow,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
