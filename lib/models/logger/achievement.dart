import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';

class Achievement {
  final String localizedKey;
  final Resource? boughtResource;
  final Resource? soldResource;
  final String iconPath;
  bool achieved;

  Achievement({
    required this.localizedKey,
    this.boughtResource,
    this.soldResource,
    required this.iconPath,
    this.achieved = false,
  });

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
    return {
      "localizedKey": localizedKey,
      "boughtResource": boughtResource?.toJson() ?? null,
      "soldResource": soldResource?.toJson() ?? null,
      "iconPath": iconPath,
      "achieved": achieved,
    };
  }

  static Achievement fromJson(Map<String, dynamic> inputJson) {
    final boughtJson = inputJson["boughtResource"];
    final soldJson = inputJson["soldResource"];
    return Achievement(
      localizedKey: inputJson["localizedKey"],
      iconPath: inputJson["iconPath"],
      boughtResource: boughtJson == null ? null : Resource.fromJson(boughtJson),
      soldResource: soldJson == null ? null : Resource.fromJson(soldJson),
      achieved: inputJson["achieved"],
    );
  }

  static List<Achievement> defaultAchievements() {
    return [
      Achievement(
        localizedKey: "achievements.fishSeller",
        iconPath: "images/events/vesterfeld/town.png",
        soldResource: Fish(5),
        boughtResource: Fish(15),
      ),
      Achievement(
        localizedKey: "achievements.gunBaron",
        iconPath: "images/events/vesterfeld/cannons_shooting.png",
        soldResource: Cannon(50),
      ),
      Achievement(
        localizedKey: "achievements.tobaccoLover",
        iconPath: "images/events/vesterfeld/ruins_2.png",
        soldResource: Tobacco(500),
        boughtResource: Tobacco(800),
      )
    ];
  }
}
