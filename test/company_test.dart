import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Company object", () {
    test("Can serialize/deserialize Company object", () {
      var company = Company(money: 500)..addMoney(42);

      var newCompany = Company.fromJson(company.toJson());
      expect(newCompany.getMoney().amount, equals(542), reason: "500 + 42 == 542.");
    });

    test("Can save/load list of cities", () {
      var company = Company(cities: [Chigirin(), Pereyaslav()]);
      var newCompany = Company.fromJson(company.toJson());
      expect(newCompany.allCities[0].localizedKeyName, equals(Chigirin().localizedKeyName), reason: "City Nizhin was restored");
      expect(newCompany.allCities[1].localizedKeyName, equals(Pereyaslav().localizedKeyName), reason: "City Nizhin was restored");
      expect(newCompany.allCities.length, equals(2), reason: "Amount of cities is restored");
    });
  });

  group("Logic tests", () {
    test("Can tell if company has enough money", () {
      final company = Company(cities: [Chigirin(), Pereyaslav()], money: 300);
      expect(company.hasEnoughMoney(Money(200)), isTrue, reason: "200 < 300");
      expect(company.hasEnoughMoney(Money(301)), isFalse, reason: "301 > 300");
    });

    test("Can buy new wagon for city", () {
      final company = Company(cities: [Chigirin(), Pereyaslav()], money: 300);
      company.buyWagon(Wagon(localizedNameKey: "dima"), forCity: company.allCities[0], price: Money(200));
      expect(company.getMoney().amount, equals(100), reason: "300 - 200 == 100");
      expect(company.allCities[0].wagons.first.localizedNameKey, equals("dima"), reason: "Wagon moved to city #1");
      expect(company.allCities[0].wagons.isNotEmpty, isTrue, reason: "Wagon moved to city #1");
      company.buyWagon(Wagon(localizedNameKey: "dima"), forCity: company.allCities[0], price: Money(200));
      expect(company.getMoney().amount, equals(100), reason: "Could not buy second wagon as not enough money");
      expect(company.allCities[0].wagons.length, equals(1), reason: "Did not buy second wagon.");
    });
  });
}
