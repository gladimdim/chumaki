
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/achivements/achivement_progress_view.dart';
import 'package:flutter/material.dart';

class AchievementStock extends AchievementBase {
  final String localizedKey;
  final Resource? boughtResource;
  final Resource? soldResource;
  final String iconPath;
  bool achieved;

  AchievementStock({
    required this.localizedKey,
    this.boughtResource,
    this.soldResource,
    required this.iconPath,
    this.achieved = false,
  }) : super(
    localizedKey: localizedKey,
    iconPath: iconPath,
    achieved: achieved,
  );

  Widget toWidget(Logger logger) {
    return AchievementStockProgressView(achievement: this, logger: logger);
  }

  bool processChange(Logger logger) {
    if (achieved) {
      return false;
    }
    final bResource = boughtResource;
    final sResource = soldResource;
    var boughtSatisfies = false;
    var soldSatisfies = false;

    if (bResource == null) {
      boughtSatisfies = true;
    } else {
      boughtSatisfies = logger.boughtStock.hasEnough(bResource);
    }

    if (sResource == null) {
      soldSatisfies = true;
    } else {
      soldSatisfies = logger.soldStock.hasEnough(sResource);
    }

    achieved = boughtSatisfies && soldSatisfies;
    return achieved;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> root = super.toJson();
    root["boughtResource"] = boughtResource?.toJson() ?? null;
    root["soldResource"] = soldResource?.toJson() ?? null;
    return root;
  }

  static AchievementStock fromJson(Map<String, dynamic> inputJson) {
    final boughtJson = inputJson["boughtResource"];
    final soldJson = inputJson["soldResource"];
    return AchievementStock(
      localizedKey: inputJson["localizedKey"],
      iconPath: inputJson["iconPath"],
      boughtResource: boughtJson == null ? null : Resource.fromJson(boughtJson),
      soldResource: soldJson == null ? null : Resource.fromJson(soldJson),
      achieved: inputJson["achieved"],
    );
  }

  static List<AchievementStock> defaultAchievements() {
    return [
      AchievementStock(
        localizedKey: "achievements.fishSeller",
        iconPath: "images/events/vesterfeld/cossack_and_bum.png",
        soldResource: Fish(5),
        boughtResource: Fish(15),
      ),
      AchievementStock(
        localizedKey: "achievements.gunBaron",
        iconPath: "images/events/vesterfeld/cannons_shooting.png",
        soldResource: Cannon(50),
      ),
      AchievementStock(
        localizedKey: "achievements.tobaccoLover",
        iconPath: "images/events/vesterfeld/ruins_2.png",
        soldResource: Tobacco(500),
        boughtResource: Tobacco(800),
      ),
      AchievementStock(
        localizedKey: "achievements.warPowder",
        iconPath: "images/events/vesterfeld/wagon_camp.png",
        soldResource: Tobacco(1500),
        boughtResource: Tobacco(1000),
      ),
      AchievementStock(
        localizedKey: "achievements.silkSeller",
        iconPath: "images/events/vesterfeld/elite_cossacks.png",
        soldResource: Silk(2200),
        boughtResource: Silk(800),
      ),
      AchievementStock(
        localizedKey: "achievements.masonBuilder",
        iconPath: "images/events/vesterfeld/ancient_church.png",
        soldResource: Stone(1000),
        boughtResource: Stone(200),
      ),
      AchievementStock(
        localizedKey: "achievements.europeFeeder",
        iconPath: "images/events/vesterfeld/town.png",
        soldResource: Bread(600),
        boughtResource: Grains(1200),
      ),
      AchievementStock(
        localizedKey: "achievements.greatBuilder",
        iconPath: "images/events/vesterfeld/big_city_2.png",
        soldResource: Planks(600),
        boughtResource: Wood(500),
      ),
      AchievementStock(
        localizedKey: "achievements.alconautics",
        iconPath: "images/events/vesterfeld/crazy_man.png",
        soldResource: Gorilka(400),
      ),
      AchievementStock(
        localizedKey: "achievements.warmWinter",
        iconPath: "images/events/vesterfeld/cossack_and_sheep.png",
        soldResource: Fur(100),
      )
    ];
  }
}