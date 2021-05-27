import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:flutter/material.dart';

class LeaderView extends StatelessWidget {
  final Leader leader;

  const LeaderView(this.leader);

  @override
  Widget build(BuildContext context) {
    final experience = leader.experience % 1000;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Image.asset("images/leaders/leader1.png", width: 64),
        ),
        Column(
          children: [
            TitleText(ChumakiLocalizations.labelLevel),
            Text(leader.level.toString()),
          ],
        ),
        Column(
          children: [
            TitleText(ChumakiLocalizations.labelExperience),
            SizedBox(
              width: 200,
              height: 30,
              child: BorderedAll(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: experience / 1000 * 200,
                        height: 30,
                        color: Colors.yellow,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("$experience/1000"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
