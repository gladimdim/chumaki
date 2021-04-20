import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';
import 'title_text.dart';
import 'package:chumaki/extensions/list.dart';

class PriceComparison extends StatefulWidget {
  final City currentCity;

  PriceComparison({required this.currentCity});

  @override
  _PriceComparisonState createState() => _PriceComparisonState();
}

class _PriceComparisonState extends State<PriceComparison> {
  late Resource selectedResource;

  @override
  void initState() {
    selectedResource = widget.currentCity.stock.stock.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentSell =
    widget.currentCity.prices.sellPriceForResource(selectedResource);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: widget.currentCity.stock.iterator.map((resource) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedResource = resource;
                      });
                    },
                    child: ResourceImageView(
                      resource.cloneWithAmount(1),
                      showAmount: selectedResource.sameType(resource),
                    ),
                  );
                }).toList()),
          ),
          ...City.allCities
              .where((city) => city != widget.currentCity)
              .toList()
              .divideBy(2)
              .map((List<City> cityRow) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cityRow.map<Widget>((city) {
                var buyPrice = city.prices.buyPriceForResource(
                    selectedResource);
                var saldo = buyPrice - currentSell;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GroupedControl(
                    borderColor: Colors.blueGrey,
                    height: 100,
                    titleHeight: 25,
                    titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
                    width: 130,
                    title: city.name,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Купівля:"),
                              MoneyUnit(Money(buyPrice)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Вигода:"),
                              MoneyUnit(Money(saldo)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }
}
