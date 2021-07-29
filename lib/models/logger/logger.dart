import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:rxdart/rxdart.dart';

enum LOGGER_EVENTS { ACHEIVEMENT_UNLOCKED }

class Logger {
  Logger({
    required this.boughtStock,
    this.boughtWagons = 0,
    this.leadersHired = 0,
    this.unreadCount = 0,
    required this.soldStock,
    required this.achievements,
  }) {
    this.soldStock.changes.listen(_updateStockAchievements);
    this.boughtStock.changes.listen(_updateStockAchievements);
    changes = _innerChanges.stream;
  }

  final BehaviorSubject<LOGGER_EVENTS> _innerChanges = BehaviorSubject();
  late final ValueStream<LOGGER_EVENTS> changes;

  final Stock boughtStock;
  final Stock soldStock;
  final List<Achievement> achievements;
  int boughtWagons;
  int leadersHired;
  int unreadCount;

  void _updateStockAchievements(StockEvent event) {
    if (event.item1 == STOCK_EVENTS.ADDED) {
      _processSoldStock();
    }
  }

  void _processSoldStock() {
    achievements.forEach((Achievement achievement) {
      if (achievement.processChange(this)) {
        achievementUnlock();
      }
    });
  }

  void achievementUnlock() {
    SoundManager.instance.playLeaderLevelUp();
    unreadCount++;
    _innerChanges.add(LOGGER_EVENTS.ACHEIVEMENT_UNLOCKED);
  }

  void resetUnreadCount() {
    unreadCount = 0;
  }

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());

    company.changes
        .where((event) => event == COMPANY_EVENTS.LEADER_HIRED)
        .listen((_) => {leaderListener()});

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

  void leaderListener() {
    leadersHired++;
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
      "leadersHired": leadersHired,
      "soldStock": soldStock.toJson(),
      "achievements": achievements.map((ach) => ach.toJson()).toList(),
      "unreadCount": unreadCount,
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    final achJson = inputJson["achievements"] as List;
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"],
      leadersHired: inputJson["leadersHired"],
      soldStock: Stock.fromJson(inputJson["soldStock"]),
      achievements: achJson.map((json) => Achievement.fromJson(json)).toList(),
      unreadCount: inputJson["unreadCount"],
    );
  }
}
