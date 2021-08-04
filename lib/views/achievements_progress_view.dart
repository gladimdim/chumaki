import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/achivements/achievement_progress_indicator.dart';
import 'package:flutter/material.dart';

class AchievementsProgressView extends StatelessWidget {
  final Logger logger;

  const AchievementsProgressView({Key? key, required this.logger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: logger.stockAchievements.map((ach) => ach.toWidget(logger)).toList(),
    );
  }
}

class AchievementProgressBar extends StatelessWidget {
  final Resource achievementTarget;
  final Resource stockResource;

  const AchievementProgressBar({
    Key? key,
    required this.achievementTarget,
    required this.stockResource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = _progressValue();
    return AchievementProgressIndicator(
      value: value,
      color: _colorForValue(value),
    );
  }

  Color _colorForValue(double value) {
    if (value < 0.3) {
      return mediumGrey;
    }
    if (value > 0.3 && value < 0.75) {
      return Colors.yellow;
    }
    return darkGrey;
  }

  double _progressValue() {
    final full = achievementTarget.amount;
    final progress = stockResource.amount / full;
    if (progress > 1) {
      return 1;
    }
    return progress;
  }
}
