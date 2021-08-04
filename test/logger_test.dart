import 'package:chumaki/extensions/stock.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/leaders/leaders.dart';
import 'package:chumaki/models/logger/achievement_city.dart';

import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

void main() {
  group("(De)serialize Logger", () {
    test("Can recover bought stock", () {
      final logger = Logger(
          boughtStock: Stock([]),
          soldStock: Stock([]),
          stockAchievements: [],
          cityAchievements: []);
      logger.addBoughtResource(Firearm(10));
      logger.addBoughtResource(Wax(3));

      final aLogger = Logger.fromJson(logger.toJson());

      expect(aLogger.boughtStock.isEmpty, isFalse,
          reason: "Two items were recovered");
      expect(
          aLogger.boughtStock.resourceInStock(Firearm(1))!.amount, equals(10),
          reason: "3 firearms were recovered");
      expect(aLogger.boughtStock.resourceInStock(Wax(1))!.amount, equals(3),
          reason: "3 wax were recovered");
    });

    test("Can recover sold stock", () {
      final logger = Logger(
          cityAchievements: [],
          boughtStock: Stock([]),
          soldStock: Stock([]),
          stockAchievements: []);
      logger.addSoldStock(Firearm(11));
      logger.addSoldStock(Wax(33));

      final aLogger = Logger.fromJson(logger.toJson());

      expect(aLogger.soldStock.isEmpty, isFalse,
          reason: "Two items were recovered");
      expect(aLogger.soldStock.resourceInStock(Firearm(1))!.amount, equals(11),
          reason: "3 firearms were recovered");
      expect(aLogger.soldStock.resourceInStock(Wax(1))!.amount, equals(33),
          reason: "3 wax were recovered");
    });

    test("Can recover hired leaders count", () {
      FakeAsync().run((async) {
        final logger = Logger(
            cityAchievements: [],
            boughtStock: Stock([]),
            soldStock: Stock([]),
            stockAchievements: []);
        final company = Company();
        logger.attachToCompany(company);
        company.hireLeader(leader: Leader("dima"), forWagon: Wagon());
        company.hireLeader(leader: Leader("dima2"), forWagon: Wagon());
        async.elapse(Duration(milliseconds: 100));
        final aLogger = Logger.fromJson(logger.toJson());

        expect(aLogger.leadersHired, equals(2),
            reason: "Two leaders were recorded and restored");
      });
    });

    test("Can recover wagons bought count", () {
      FakeAsync().run((async) {
        final logger = Logger(
            cityAchievements: [],
            boughtStock: Stock([]),
            soldStock: Stock([]),
            stockAchievements: []);
        final company = Company();
        logger.attachToCompany(company);
        company.buyWagon(Wagon(), forCity: Sich(), price: Money(200));
        company.buyWagon(Wagon(), forCity: Sich(), price: Money(200));
        company.buyWagon(Wagon(), forCity: Sich(), price: Money(200));
        async.elapse(Duration(milliseconds: 100));
        final aLogger = Logger.fromJson(logger.toJson());

        expect(aLogger.boughtWagons, equals(3),
            reason: "Three wagons were bought, recorded and restored");
      });
    });

    test("Can log city done event", () {
      FakeAsync().run((async) {
        final logger = Logger(
            cityAchievements: [],
            boughtStock: Stock([]),
            soldStock: Stock([]),
            stockAchievements: []);
        final company = Company();
        logger.attachToCompany(company);
        final sich = company.refToCityByName(Sich());
        final event = sich.availableEvents.first;
        event.decreaseResource(Grains(100));
        company.finishEvent(event, inCity: Sich());
        async.elapse(Duration(milliseconds: 100));
        final aLogger = Logger.fromJson(logger.toJson());

        expect(aLogger.completedCityEvents, equals(1),
            reason: "One city event was saved and restored.");
      });
    });

    test("Can recover city achievements", () {
      final logger = Logger(
          cityAchievements: [
            AchievementCity(
                localizedKey: "test",
                iconPath: "test.png",
                amountAchievedNeeded: 2),
          ],
          boughtStock: Stock([]),
          soldStock: Stock([]),
          stockAchievements: []);
      logger.cityEventListener();
      logger.cityEventListener();
      final aLogger = Logger.fromJson(logger.toJson());

      expect(aLogger.cityAchievements.length, equals(1), reason: "Reason restored one city achievement");
      expect(aLogger.cityAchievements[0].achieved, isTrue, reason: "Achievement restored");
    });
  });
}
