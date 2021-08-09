import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/logger/achievement_city.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/achivements/achievement_card_view.dart';
import 'package:chumaki/views/achivements/achievement_progress_indicator.dart';
import 'package:flutter/material.dart';

class AchievementCityView extends StatelessWidget {
  final AchievementCity achievement;

  const AchievementCityView({Key? key, required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AchievementCardView(
      achievement: achievement,
      content: Column(
        children: [
          GameText(ChumakiLocalizations.labelRequiredToDoCityEvents),
          OutlinedText(
            "${achievement.currentProgress} / ${achievement.amountAchievedNeeded.toString()}",
            style: gameTextStyle,
          ),
          AchievementProgressIndicator(
            value:
                achievement.currentProgress / achievement.amountAchievedNeeded,
          ),
        ],
      ),
    );
  }
}
