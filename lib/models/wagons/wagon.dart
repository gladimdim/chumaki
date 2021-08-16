import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:chumaki/models/leaders/leaders.dart';

class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/cart.png";
  double totalWeightCapacity;
  BehaviorSubject changes = BehaviorSubject();
  Leader? leader;

  String get fullLocalizedName {
    return hasLeader()
        ? leader!.localizedNameKey
        : ChumakiLocalizations.labelCompany;
  }

  String getImagePath() {
    return hasLeader() ? leader!.imagePath : imagePath;
  }

  Wagon({Stock? stock, this.totalWeightCapacity = 100.0, this.leader}) {
    this.stock = stock ?? Stock(List.empty(growable: true));

    this.stock.changes.listen((value) {
      changes.add(value);
    });

    subscribeLeaderChanges();
  }

  void subscribeLeaderChanges() {
    leader?.changes
        .where((event) => event == LEADER_CHANGES.CATEGORY_UNLOCKED)
        .listen((event) {
      changes.add(this);
    });
  }

  bool hasLeader() {
    return leader != null;
  }

  bool canFitNewResource(Resource res) {
    return totalWeightCapacity > currentWeight + res.totalWeight;
  }

  double get currentWeight {
    return stock.iterator.fold(0, (previousValue, resource) {
      return previousValue + resource.totalWeight;
    });
  }

  static Wagon generateRandomWagon() {
    return Wagon(
      stock: Stock([]),
      totalWeightCapacity: 100.0,
    );
  }

  void setLeader(Leader newLeader) {
    leader = newLeader;
    subscribeLeaderChanges();
    changes.add(this);
  }

  void dispose() {
    leader?.dispose();
    changes.close();
  }

  Map<String, dynamic> toJson() {
    return {
      "stock": stock.toJson(),
      "totalWeightCapacity": totalWeightCapacity,
      "leader": leader?.toJson(),
    };
  }

  static Wagon fromJson(Map<String, dynamic> json) {
    var stock = Stock.fromJson(json["stock"]);
    var leaderJson = json["leader"];
    Leader? leader = leaderJson == null ? null : Leader.fromJson(leaderJson);
    return Wagon(
        stock: stock,
        totalWeightCapacity: json["totalWeightCapacity"],
        leader: leader);
  }

  static String getRandomLocalizedNameKey() {
    return "leaders.${LeadersLocalizations().localizedMap["en"]!.keys.toList().takeRandom()}";
  }

  bool sellResource(Resource resource) {
    int amount = resource.amount;
    final sold = stock.removeResource(resource);
    if (sold) {
      addExperienceToLeader(amount);
    }
    return sold;
  }

  void addExperienceToLeader(int soldAmount) {
    leader?.addExperience(soldAmount);
  }

  bool categoryUnlocked(RESOURCE_CATEGORY cat) {
    if (leader == null) {
      return DEFAULT_CATEGORIES.contains(cat);
    } else {
      return DEFAULT_CATEGORIES.contains(cat) ||
          leader!.hasPerkForCategory(cat);
    }
  }
}
