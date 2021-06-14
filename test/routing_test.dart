import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/cities/zhytomir.dart';
import 'package:chumaki/models/company.dart';
import 'package:test/test.dart';

void main() {
  group("Route logic", () {
    test("Can tell if the city has direct connection to other city", () {
      final company = Company(money: 3000);
      expect(
          company.hasDirectConnection(from: Kyiv(), to: Pereyaslav()), isTrue,
          reason: "Kyiv connects to Pereyaslav");
      expect(Kyiv().connectsTo(inCompany: company).length, 5,
          reason: "Kyiv connects to five cities");
      expect(company.hasDirectConnection(from: Kyiv(), to: Sich()), isFalse,
          reason: "Kyiv is not directly connected to Sich");
    });

    test("Can calculate the full route between two cities", () {
      final company = Company();
      final fullRoute = company.fullRoute(from: Kyiv(), to: Pereyaslav());
      expect(fullRoute[0].equalsTo(Pereyaslav()), isTrue,
          reason: "Has direct connection");
    });
    test("Can show the route between far cities", () {
      final company = Company();
      company.unlockCity(company.refToCityByName(Kyiv()));
      company.unlockCity(company.refToCityByName(Ladyzhin()));
      company.unlockCity(company.refToCityByName(Berdychiv()));
      company.unlockCity(company.refToCityByName(Zhytomir()));
      final route = company.fullRoute(
          from: company.refToCityByName(Kyiv()),
          to: company.refToCityByName(Berdychiv()));
      final route2 = company.fullRoute(
          from: company.refToCityByName(Kyiv()),
          to: company.refToCityByName(Sich()));
      final route3 = company.fullRoute(
        from: company.refToCityByName(Kyiv()),
        to: company.refToCityByName(
          Ladyzhin(),
        ),
        allowLocked: true,
      );
      expect(route.length, equals(2), reason: "We need two stops (two cities)");
      expect(route2.length, equals(3),
          reason: "We need three stops (three cities)");
      expect(route3.length, equals(4),
          reason: "We need four stops (four cities)");
    });
  });
}
