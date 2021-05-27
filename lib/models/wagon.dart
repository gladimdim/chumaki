import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/i18n/company_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:chumaki/models/leaders/leaders.dart';
class Wagon {
  late Stock stock;
  static final String imagePath = "images/wagon/cart.png";
  final String localizedNameKey;
  double totalWeightCapacity;
  BehaviorSubject changes = BehaviorSubject();
  Leader? leader;

  String get fullLocalizedName {
    return "${ChumakiLocalizations.getForKey(localizedNameKey)}";
  }

  Wagon({required this.localizedNameKey, Stock? stock, this.totalWeightCapacity = 100.0, this.leader}) {
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
      localizedNameKey: Wagon.getRandomLocalizedNameKey(),
      totalWeightCapacity: 100.0,
    );
  }


  void setLeader(Leader newLeader) {
    leader = newLeader;
    changes.add(this);
  }

  void dispose() {
    changes.close();
  }

  Map<String, dynamic> toJson() {
    return {
      "stock": stock.toJson(),
      "name": localizedNameKey,
      "totalWeightCapacity": totalWeightCapacity,
      "leader": leader?.toJson(),
    };
  }

  static Wagon fromJson(Map<String, dynamic> json) {
    var stock = Stock.fromJson(json["stock"]);
    var leaderJson = json["leader"];
    Leader? leader = leaderJson == null ? null : Leader.fromJson(leaderJson);
    return Wagon(localizedNameKey: json["name"], stock: stock, totalWeightCapacity: json["totalWeightCapacity"], leader: leader);
  }

  static String getRandomLocalizedNameKey() {
    return "company.${CompanyLocalizations().localizedMap["en"]!.keys.toList().takeRandom()}";
  }
}