import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/sound/sound_manager.dart';

class Logger {
  Logger({
    required this.boughtStock,
    this.boughtWagons = 0,
    required this.soldStock,
    required this.achievements,
  }) {
    this.soldStock.changes.listen(_updateStockAchievements);

    this.boughtStock.changes.listen(_updateStockAchievements);
  }

  final Stock boughtStock;
  final Stock soldStock;
  final List<Achievement> achievements;
  int boughtWagons;

  void _updateStockAchievements(StockEvent event) {
    if (event.item1 == STOCK_EVENTS.ADDED) {
      _processSoldStock();
    }
  }

  void _processSoldStock() {
    achievements.forEach((Achievement achievement) {
      if (achievement.processChange(this)) {
        SoundManager.instance.playLeaderLevelUp();
      }
    });
  }

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());

    company.allCities.forEach((city) {
      city.stock.changes.listen(cityStockListener);
    });
  }

  void cityStockListener(StockEvent event) {
    switch (event.item1) {
      case STOCK_EVENTS.ADDED:
        addSoldStock(event.item2);
        break;

      case STOCK_EVENTS.REMOVED:
        addBoughtResource(event.item2);
        break;
    }
  }

  void wagonListener() {
    boughtWagons++;
  }

  void addBoughtResource(Resource resource) {
    boughtStock.addResource(resource);
  }

  void addSoldStock(Resource resource) {
    soldStock.addResource(resource);
  }

  Map<String, dynamic> toJson() {
    return {
      "boughtStock": boughtStock.toJson(),
      "ownedWagons": boughtWagons,
      "soldStock": soldStock.toJson(),
      "achievements": achievements.map((ach) => ach.toJson()).toList(),
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    final achJson = inputJson["achievements"] as List;
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"],
      soldStock: Stock.fromJson(inputJson["soldStock"]),
      achievements: achJson.map((json) => Achievement.fromJson(json)).toList(),
    );
  }
}
