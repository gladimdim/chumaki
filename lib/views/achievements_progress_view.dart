import 'package:chumaki/models/logger/logger.dart';
import 'package:flutter/material.dart';

class AchievementsProgressView extends StatelessWidget {
  final Logger logger;

  const AchievementsProgressView({Key? key, required this.logger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...logger.stockAchievements.map((ach) => ach.toWidget(logger)).toList(),
      ...logger.cityAchievements.map((ach) => ach.toWidget(logger)).toList(),
    ]);
  }
}
