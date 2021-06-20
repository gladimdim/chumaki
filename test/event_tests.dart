import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:test/test.dart';

void main() {
  group("Test events logic", () {
    test("Can finish event", () {
      final company = Company();
      final sich = company.refToCityByName(Sich());
      final event = sich.queueEvent();
      final wagon = sich.wagons.first;
      wagon.stock.addResource(Grains(20));
      wagon.stock.addResource(Bread(20));
      company.donateResource(Grains(1), fromWagon: wagon, toCity: sich);
      company.donateResource(Bread(1), fromWagon: wagon, toCity: sich);
      expect(sich.activeEvent, isNotNull,
          reason: "Active event is still active");
      // satisfy event requirements
      company.donateResource(Grains(9),
          fromWagon: sich.wagons.first, toCity: sich);
      company.donateResource(Bread(9),
          fromWagon: sich.wagons.first, toCity: sich);

      company.finishEvent(event!, inCity: sich);
      expect(sich.activeEvent, isNull,
          reason: "Active event was satisfied and payment was paid");
      expect(company.getMoney().amount, equals(3100),
          reason: "100 payment for the first event was payed.");
      expect(event.isDone(), isTrue, reason: "Event is done");
    });
  });
}
