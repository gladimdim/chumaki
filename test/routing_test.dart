import 'dart:math';

import 'package:chumaki/models/cities/berdychiv.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/ladyzhin.dart';
import 'package:chumaki/models/cities/nizhin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/route.dart';
import 'package:test/test.dart';

void main() {
  group("Route logic", () {
    test("Can tell if the city has direct connection to other city", () {
      final company = Company(money: 3000);
      expect(company.hasDirectConnection(from: Kyiv(), to: Pereyaslav()), isTrue, reason: "Kyiv connects to Pereyaslav");
      expect(Kyiv().connectsTo(inCompany: company).length, 5, reason: "Kyiv connects to five cities");
      expect(company.hasDirectConnection(from: Kyiv(), to: Sich()), isFalse, reason: "Kyiv is not directly connected to Sich");
    });

    test("Can calculate the full route between two cities", () {
      final company = Company();
      final fullRoute = company.fullRoute(from: Kyiv(), to: Pereyaslav());
      expect(fullRoute[0].equalsTo(Pereyaslav()), isTrue, reason: "Has direct connection");
    });
    test("Can show the route between far cities", () {
      final company = Company();
      final route = company.fullRoute(from: Kyiv(), to: Berdychiv());
      final route2 = company.fullRoute(from: Kyiv(), to: Sich());
      final route3 = company.fullRoute(from: Kyiv(), to: Ladyzhin());
      expect(route.length, equals(3), reason: "We need two stops (three cities)");
      expect(route2.length, equals(4), reason: "We need three stops (four cities)");
      expect(route3.length, equals(5), reason: "We need four stops (five cities)");
    });
  });
}
