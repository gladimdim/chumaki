import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/achivements/achievement_city_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AchievementCity extends AchievementBase {
  final amountAchievedNeeded;
  int currentProgress;

  AchievementCity({
    localizedKey,
    iconPath,
    required this.amountAchievedNeeded,
    this.currentProgress = 0,
    achieved = false,
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
    achieved = currentProgress == amountAchievedNeeded;
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
    return AchievementCityView(
      achievement: this,
    );
  }

  static List<AchievementCity> defaultAchievements() {
    return [
      AchievementCity(
        localizedKey: "achievements.cityBeginner",
        iconPath: "images/events/vesterfeld/wandering_man.png",
        amountAchievedNeeded: 3,
      ),

      AchievementCity(
        localizedKey: "achievements.cityKnownMan",
        iconPath: "images/events/vesterfeld/wandering_men.png",
        amountAchievedNeeded: 5,
      ),
      AchievementCity(
        localizedKey: "achievements.cityBestHelper",
        iconPath: "images/events/vesterfeld/elite_cossacks.png",
        amountAchievedNeeded: 10,
      ),
      AchievementCity(
        localizedKey: "achievements.cityEpicHelperman",
        iconPath: "images/events/vesterfeld/otaman.png",
        amountAchievedNeeded: 15,
      ),
    ];
  }
}
