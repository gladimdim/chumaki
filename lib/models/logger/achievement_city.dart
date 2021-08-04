import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/achivements/achievement_city_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AchievementCity extends AchievementBase {
  final String localizedKey;
  final String iconPath;
  final amountAchievedNeeded;
  bool achieved;
  int currentProgress;
  AchievementCity({
    required this.localizedKey,
    required this.iconPath,
    required this.amountAchievedNeeded,
    this.currentProgress = 0,
    this.achieved = false,
  }) : super(
    localizedKey: localizedKey,
    iconPath: iconPath,
    achieved: achieved,
  );

  bool processChange(Logger logger) {
    if (achieved) {
      return false;
    }
    currentProgress++;
    achieved = currentProgress == achieved;
    return achieved;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> root = super.toJson();
    root["amountAchievedNeeded"] = amountAchievedNeeded;
    root["currentProgress"] = currentProgress;
    return root;
  }

  static AchievementCity fromJson(Map<String, dynamic> inputJson) {
    return AchievementCity(
      localizedKey: inputJson["localizedKey"],
      iconPath: inputJson["iconPath"],
      currentProgress: inputJson["currentProgress"],
      amountAchievedNeeded: inputJson["amountAchievedNeeded"],
      achieved: inputJson["achieved"],
    );
  }

  @override
  Widget toWidget(Logger logger) {
    return AchievementCityView(achievement: this,);
  }

  static List<AchievementCity> defaultAchievements() {
    return [];
  }
}