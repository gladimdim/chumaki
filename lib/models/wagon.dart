import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/leaders_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
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
    return leader != null ? leader!.localizedNameKey : ChumakiLocalizations.labelCompany;
  }

  Wagon(
      {
      Stock? stock,
      this.totalWeightCapacity = 100.0,
      this.leader}) {
    if (stock == null) {
      this.stock = Stock(List.empty(growable: true));
    } else {
      this.stock = stock;
    }

    this.stock.changes.listen((value) {
      changes.add(value);
    });
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
    // TODO: REMOVE
    newLeader.experience = 980.0;
    leader = newLeader;
    changes.add(this);
  }

  void dispose() {
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
    final sold = stock.removeResource(resource);
    if (sold) {
      addExperienceToLeader(resource.amount);
    }
    return sold;
  }

  void addExperienceToLeader(int soldAmount) {
    leader?.addExperience(soldAmount);
  }
}
