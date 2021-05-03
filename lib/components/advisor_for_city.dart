import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:chumaki/extensions/list.dart';

class AdvisorForCity extends StatefulWidget {
  final City city;

  AdvisorForCity({required this.city});

  @override
  _AdvisorForCityState createState() => _AdvisorForCityState();
}

class _AdvisorForCityState extends State<AdvisorForCity> {

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return Column(
        children: widget.city.wagons.map((wagon) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.blueGrey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText("Total price of: ${wagon.name}"),
                ...calculateTopForWagon(wagon, company).divideBy(3).map((rowResult) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: rowResult.map((result) {
                      return Column(
                        children: [
                          SmallCityAvatar(result.item1),
                          MoneyUnit(Money(result.item2)),
                        ],
                      );
                    }).toList(),
                  );
                }).toList(),
              ],
            ),
          );
        }).toList());
  }

  List<Tuple2<City, double>> calculateTopForWagon(Wagon wagon, Company company) {
    var result = City.allCities.map((city) {
      return Tuple2(city, priceForFullWagonInCity(wagon, city));
    }).toList();
    result.sort((a, b) {
      return (a.item2 - b.item2) > 0 ? -1 : 1;
    });
    return result;
  }

  double priceForFullWagonInCity(Wagon wagon, City city) {
    return wagon.stock.iterator.fold(0, (previousValue, resource) {
      var price = city.prices.buyPriceForResource(resource);
      return previousValue + price;
    });
  }
}
