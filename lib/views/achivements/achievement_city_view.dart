import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement_city.dart';
import 'package:flutter/material.dart';

class AchievementCityView extends StatelessWidget {
  final AchievementCity achievement;

  const AchievementCityView({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(ChumakiLocalizations.getForKey(achievement.localizedKey)),
      ],
    );
  }
}
