import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/achievement.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:rxdart/rxdart.dart';

enum LOGGER_EVENTS { ACHIEVEMENT_UNLOCKED }

class Logger {
  Logger({
    required this.boughtStock,
    boughtWagons = 0,
    leadersHired = 0,
    unreadCount = 0,
    completedCityEvents = 0,
    required this.soldStock,
    required this.achievements,
  })  : this._unreadCount = unreadCount,
        this._leadersHired = leadersHired,
        this._boughtWagons = boughtWagons,
        this._completedCityEvents = completedCityEvents {
    this.soldStock.changes.listen(_updateStockAchievements);
    this.boughtStock.changes.listen(_updateStockAchievements);
    changes = _innerChanges.stream;
  }

  final BehaviorSubject<LOGGER_EVENTS> _innerChanges = BehaviorSubject();
  late final ValueStream<LOGGER_EVENTS> changes;

  final Stock boughtStock;
  final Stock soldStock;
  final List<Achievement> achievements;
  int _boughtWagons;
  int _leadersHired;
  int _unreadCount;
  int _completedCityEvents;

  int get unreadCount => _unreadCount;

  int get boughtWagons => _boughtWagons;

  int get leadersHired => _leadersHired;

  int get completedCityEvents => _completedCityEvents;

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
    _unreadCount++;
    _innerChanges.add(LOGGER_EVENTS.ACHIEVEMENT_UNLOCKED);
  }

  void resetUnreadCount() {
    _unreadCount = 0;
  }
  

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());

    company.changes
        .where((event) => event == COMPANY_EVENTS.LEADER_HIRED)
        .listen((_) => {leaderListener()});
    
    company.changes.where((event) => event == COMPANY_EVENTS.CITY_EVENT_DONE)
    .listen((_) => cityEventListener());

    company.allCities.forEach((city) {
      city.stock.changes.listen(cityStockListener);
    });
  }
  
  void cityEventListener() {
    _completedCityEvents++;
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
    _boughtWagons++;
  }

  void leaderListener() {
    _leadersHired++;
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
      "completedCityEvents": completedCityEvents,
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    final achJson = inputJson["achievements"] as List;
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"] ?? 0 ,
      leadersHired: inputJson["leadersHired"] ?? 0,
      soldStock: Stock.fromJson(inputJson["soldStock"]),
      achievements: achJson.map((json) => Achievement.fromJson(json)).toList(),
      unreadCount: inputJson["unreadCount"] ?? 0,
      completedCityEvents: inputJson["completedCityEvents"] ?? 0,
    );
  }
}
