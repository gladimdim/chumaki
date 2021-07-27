import 'package:chumaki/extensions/stock.dart';

import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("(De)serialize Logger", () {
    test("Can recover bought stock", () {
      final logger = Logger(
          boughtStock: Stock([]), soldStock: Stock([]), achievements: []);
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
  });
}
