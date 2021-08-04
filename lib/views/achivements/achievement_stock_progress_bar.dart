import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/achivements/achievement_progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AchievementStockProgressBar extends StatelessWidget {
  final Resource achievementTarget;
  final Resource stockResource;

  const AchievementStockProgressBar({
    Key? key,
    required this.achievementTarget,
    required this.stockResource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = _progressValue();
    return AchievementProgressIndicator(
      value: value,
    );
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
