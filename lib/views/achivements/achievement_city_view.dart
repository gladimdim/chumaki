import 'package:chumaki/models/logger/achievement_city.dart';
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
      content: AchievementProgressIndicator(
        value: achievement.currentProgress / achievement.amountAchievedNeeded,
      ),
    );
  }
}
