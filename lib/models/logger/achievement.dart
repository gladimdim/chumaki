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

  void processChange(Logger logger) {
    if (achieved) {
      return;
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
      )
    ];
  }
}
