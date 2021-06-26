import 'package:chumaki/models/cities/cherkasy.dart';
import 'package:chumaki/models/cities/chigirin.dart';
import 'package:chumaki/models/cities/kyiv.dart';
import 'package:chumaki/models/cities/pereyaslav.dart';
import 'package:chumaki/models/cities/sich.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

void main() {
  group("JSON Company object", () {
    test("Can serialize/deserialize Company object", () {
      var company = Company(money: 500)..addMoney(42);

      var newCompany = Company.fromJson(company.toJson());
      expect(newCompany.getMoney().amount, equals(542),
          reason: "500 + 42 == 542.");
    });

    test("Can save/load list of cities", () {
      var company = Company(cities: [Chigirin(), Pereyaslav()]);
      var newCompany = Company.fromJson(company.toJson());
      expect(newCompany.allCities[0].localizedKeyName,
          equals(Chigirin().localizedKeyName),
          reason: "City Nizhin was restored");
      expect(newCompany.allCities[1].localizedKeyName,
          equals(Pereyaslav().localizedKeyName),
          reason: "City Nizhin was restored");
      expect(newCompany.allCities.length, equals(2),
          reason: "Amount of cities is restored");
    });

    test("Can restore active route tasks", () async {
      var company = Company();
      company.startTask(from: Chigirin(), to: Pereyaslav(), withWagon: Wagon());
      var newCompany = Company.fromJson(company.toJson());
      expect(newCompany.activeRouteTasks.length, equals(1),
          reason: "One task restored.");
    });

    test("Can restore active route tasks that are done directly to city", () {
      FakeAsync().run((async) {
        var company = Company();
        company.startTask(
            from: Chigirin(), to: Cherkasy(), withWagon: Wagon());
        var newCompany = Company.fromJson(company.toJson());
        async.elapse(Duration(seconds: 15));
        expect(newCompany.activeRouteTasks, isEmpty,
            reason: "Task was moved directly to target city.");
        expect(newCompany.refToCityByName(Cherkasy()).wagons[0], isNotNull,
            reason: "Wagon was restored directly to city");
      });
    });

    test("Can restore active route tasks that are not yet done to City Route",
        () {
      FakeAsync().run((async) {
        var company = Company();
        final sich = company.refToCityByName(Sich());
        final chigirin = company.refToCityByName(Chigirin());
        company.startTask(
            from: sich, to: chigirin, withWagon: sich.wagons.first);
        var newCompany = Company.fromJson(company.toJson());
        async.elapse(Duration(seconds: 2));
        expect(newCompany.activeRouteTasks, isNotEmpty,
            reason: "Task is still in active state on active route tasks.");
        expect(newCompany.refToCityByName(Sich()).wagons, isEmpty,
            reason:
                "Wagon Dima was restored to City Route thus not yet available in City.");
        var task = newCompany.activeRouteTasks.first;
        var cityRoute = newCompany.getRouteForTask(task);
        expect(cityRoute.routeTasks[0], equals(task),
            reason: "Task was attached to City Route.");
        async.elapse(Duration(minutes: 1));
        expect(newCompany.activeRouteTasks, isEmpty,
            reason: "Task was moved to target city after the task was done.");
        expect(newCompany.refToCityByName(Chigirin()).wagons.isNotEmpty, isTrue,
            reason: "Wagon attached to target city as the task was done.");
      });
    });

    test("Can restore active route tasks with wagon on intermediate stop", () {
      FakeAsync().run((async) {
        var company = Company();
        company.unlockCity(Kyiv());
        final sich = company.refToCityByName(Sich());
        final kyiv = company.refToCityByName(Kyiv());
        company.startTask(from: sich, to: kyiv, withWagon: sich.wagons.first);
        async.elapse(Duration(seconds: 12));
        var newCompany = Company.fromJson(company.toJson());
        async.elapse(Duration(seconds: 8));
        expect(
            newCompany.refToCityByName(Cherkasy()).wagons.isNotEmpty, isTrue,
            reason: "Wagon stopped at the intermediate stop.");
      });
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
      company.buyWagon(Wagon(),
          forCity: company.allCities[0], price: Money(200));
      expect(company.getMoney().amount, equals(100),
          reason: "300 - 200 == 100");
      expect(company.allCities[0].wagons.first, isNotNull,
          reason: "Wagon moved to city #1");
      expect(company.allCities[0].wagons.isNotEmpty, isTrue,
          reason: "Wagon moved to city #1");
      company.buyWagon(Wagon(),
          forCity: company.allCities[0], price: Money(200));
      expect(company.getMoney().amount, equals(100),
          reason: "Could not buy second wagon as not enough money");
      expect(company.allCities[0].wagons.length, equals(1),
          reason: "Did not buy second wagon.");
    });
  });
}
