import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/govtva.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/myrgorod.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/tasks/route.dart';
import 'package:test/test.dart';

void main() {
  group("Route logic", () {
    test("Can tell if the city has direct connection to other city", () {
      final company = Company(money: 3000);
      expect(
          hasDirectConnection(
              from: Kyiv(), to: Pereyaslav(), inCompany: company),
          isTrue,
          reason: "Kyiv connects to Pereyaslav");
      expect(Kyiv().connectsTo(inCompany: company).length, 5,
          reason: "Kyiv connects to five cities");
      expect(hasDirectConnection(from: Kyiv(), to: Sich(), inCompany: company),
          isFalse,
          reason: "Kyiv is not directly connected to Sich");
    });

    test("Can calculate the full route between two cities", () {
      final company = Company();
      final fullR = fullRoute(from: Kyiv(), to: Pereyaslav(), company: company);
      expect(fullR[0].equalsTo(Pereyaslav()), isTrue,
          reason: "Has direct connection");
    });
    test("Can show the route between far cities", () {
      final company = Company();
      company.unlockCity(company.refToCityByName(Kyiv()));
      company.unlockCity(company.refToCityByName(Ladyzhin()));
      company.unlockCity(company.refToCityByName(Berdychiv()));
      company.unlockCity(company.refToCityByName(Zhytomir()));
      final route = fullRoute(
          company: company,
          from: company.refToCityByName(Kyiv()),
          to: company.refToCityByName(Berdychiv()));
      final route2 = fullRoute(
          company: company,
          from: company.refToCityByName(Kyiv()),
          to: company.refToCityByName(Sich()));
      final route3 = fullRoute(
        company: company,
        from: company.refToCityByName(Kyiv()),
        to: company.refToCityByName(
          Ladyzhin(),
        ),
        allowLocked: true,
      );
      expect(route.length, equals(2), reason: "We need two stops (two cities)");
      expect(route2.length, equals(5),
          reason: "We need five stops (five cities)");
      expect(route3.length, equals(4),
          reason: "We need four stops (four cities)");
    });
  });

  group("Route graph algorithms", () {
    test("Can find a route with fewer steps", () {
      final company = Company();
      company
        ..allCities.forEach((city) {
          city.unlock();
        });

      final fullR = fullRoute(
          from: Sich(),
          to: Nizhin(),
          company: company,
          algoChoice: SHORTEST_ROUTE.FEWER_STOPS);
      expect(fullR.length, equals(3),
          reason:
              "Sich -> Kursk -> Rilsk -> Nizhin has fewer stops than all other routes");
    });

    test("Can find a map route with min time to reach the town", () {
      final company = Company();
      company
        ..allCities.forEach((city) {
          city.unlock();
        });

      final fullR = fullRoute(
          from: Sich(),
          to: Nizhin(),
          company: company,
          algoChoice: SHORTEST_ROUTE.LESS_TIME);
      expect(fullR.length, equals(4),
          reason:
              "Sich -> Govtva -> Mirgorod -> Piryatin -> Nizhin has takes less time than other routes.");
    });

    test("Can calculate total duration time of the route", () {
      final route1 = [Sich(), Govtva()];
      final route2 = [Govtva(), Myrgorod()];
      final route3 = [...route1, Myrgorod()];

      final dRoute1 = fullRouteDuration(cityStops: route1);
      final dRoute2 = fullRouteDuration(cityStops: route2);
      final dRoute3 = fullRouteDuration(cityStops: route3);

      expect(dRoute1.inSeconds, 10, reason: "First duration of route is 10");
      expect(dRoute2.inSeconds, 3, reason: "Second duration of route is 5");
      expect(dRoute3.inSeconds, dRoute2.inSeconds + dRoute1.inSeconds,
          reason: "Third route takes route 1 + route 2 time");
    });
  });
}
