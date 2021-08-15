import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/achievement_city.dart';
import 'package:chumaki/models/logger/achievement_stock.dart';
import 'package:chumaki/models/resources/resource.dart';
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
    required this.stockAchievements,
    required this.cityAchievements,
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
  final List<AchievementStock> stockAchievements;
  final List<AchievementCity> cityAchievements;
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
    stockAchievements.forEach((AchievementStock achievement) {
      if (achievement.processChange(this)) {
        achievementUnlock();
      }
    });
  }

  void achievementUnlock() {
    _unreadCount++;
    _innerChanges.add(LOGGER_EVENTS.ACHIEVEMENT_UNLOCKED);

  }

  void resetUnreadCount() {
    _unreadCount = 0;
  }
  

  void attachToCompany(Company company) {
    company.changes
        .where((event) => event.item1 == COMPANY_EVENTS.WAGON_BOUGHT)
        .listen((_) => wagonListener());

    company.changes
        .where((event) => event.item1 == COMPANY_EVENTS.LEADER_HIRED)
        .listen((_) => leaderListener());
    
    company.changes.where((event) => event.item1 == COMPANY_EVENTS.CITY_EVENT_DONE)
    .listen((_) => cityEventListener());

    company.allCities.forEach((city) {
      city.stock.changes.listen(cityStockListener);
    });
  }
  
  void cityEventListener() {
    _completedCityEvents++;
    cityAchievements.forEach((ach) {
      if (ach.processChange(this)) {
        achievementUnlock();
      }
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
      "stockAchievements": stockAchievements.map((ach) => ach.toJson()).toList(),
      "cityAchievements": cityAchievements.map((ach) => ach.toJson()).toList(),
      "unreadCount": unreadCount,
      "completedCityEvents": completedCityEvents,
    };
  }

  static Logger fromJson(Map<String, dynamic> inputJson) {
    final List achJson = inputJson["stockAchievements"] ?? [];
    final List cityAchJson = inputJson["cityAchievements"] ?? [];
    return Logger(
      boughtStock: Stock.fromJson(
        inputJson["boughtStock"],
      ),
      boughtWagons: inputJson["ownedWagons"] ?? 0 ,
      leadersHired: inputJson["leadersHired"] ?? 0,
      soldStock: Stock.fromJson(inputJson["soldStock"]),
      stockAchievements: achJson.map((json) => AchievementStock.fromJson(json)).toList(),
      cityAchievements: cityAchJson.map((json) => AchievementCity.fromJson(json)).toList(),
      unreadCount: inputJson["unreadCount"] ?? 0,
      
      completedCityEvents: inputJson["completedCityEvents"] ?? 0,
    );
  }
}
