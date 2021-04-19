import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';
import 'title_text.dart';

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
              .map((city) {
            var buyPrice = city.prices.buyPriceForResource(selectedResource);
            var saldo = currentSell - buyPrice;
            return Column(
              children: [
                TitleText(city.name),
                // Text("Продаж: $sellPrice"),
                // Text(
                //   diffSell.toStringAsFixed(1),
                //   style: sellStyle(diffSell),
                // ),
                Text("Купівля: $buyPrice"),
                Text(saldo.toStringAsFixed(1), style: saldoStyle(saldo)),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  TextStyle saldoStyle(double diff) {
    return TextStyle(color: diff > 0 ? Colors.green : Colors.red);
  }

}
