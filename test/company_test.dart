import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/company.dart';
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
}
