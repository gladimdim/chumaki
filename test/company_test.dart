import 'package:chumaki/models/company.dart';
import 'package:test/test.dart';

void main() {
  group("Can serialize/deserialize Company object", () {
    var company = Company()..addMoney(42);

    var newCompany = Company.fromJson(company.toJson());
    expect(newCompany.getMoney(), equals(542), reason: "500 + 42 == 542.");
  });
}