import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:flutter/material.dart';

class LeaderView extends StatelessWidget {
  final Leader leader;

  const LeaderView(this.leader);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset("images/leaders/leader1.png", width: 32),
        ),
        Column(
          children: [
            TitleText("Level"),
            Text(leader.level.toString()),
          ],
        ),
        Column(
          children: [
            TitleText("Experience"),
            LinearProgressIndicator(
              backgroundColor: Theme.of(context).backgroundColor,
              value: leader.experience,
            ),
          ],
        ),
      ],
    );
  }
}
