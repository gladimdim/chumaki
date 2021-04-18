import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/components/resource_amount_selector.dart';
import 'package:chumaki/components/resource_category_group.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/wagon_stock_bar.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonResourceExchanger extends StatefulWidget {
  final Wagon wagon;
  final City city;

  WagonResourceExchanger(this.wagon, this.city);

  @override
  _WagonResourceExchangerState createState() => _WagonResourceExchangerState();
}

class _WagonResourceExchangerState extends State<WagonResourceExchanger> {
  int amountTradeValue = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WagonStockBar(
          wagon: widget.wagon,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 75,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ResourceAmountSelector(
                onSelectionChange: onAmountChanged,
                value: amountTradeValue,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 120,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset("images/resources/money/money.png",
                          width: 50),
                      StreamBuilder(
                          stream: Company.instance.changes,
                          builder: (context, snap) {
                            return Text(Company.instance.getMoney().toString());
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ...groupResourcesByCategory(Resource.allResources
                .where(
                  (fakeResource) =>
                      widget.wagon.stock.hasResource(fakeResource) ||
                      widget.city.stock.hasResource(fakeResource),
                )
                .toList())
            .map(
          (List<Resource> groupedResources) {
            return ResourceCategoryGroup(
              city: widget.city,
              wagon: widget.wagon,
              resources: groupedResources,
              amountTradeValue: amountTradeValue,
            );
          },
        ).toList(),
      ],
    );
  }

  void onAmountChanged(int newValue) {
    setState(() {
      amountTradeValue = newValue;
    });
  }

  List<List<Resource>> groupResourcesByCategory(List<Resource> resources) {
    List<List<Resource>> result = resources.fold([], (result, current) {
      if (result.isEmpty) {
        return [
          [current]
        ];
      } else {
        for (var i = 0; i < result.length; i++) {
          var group = result[i];
          if (group.first.category == current.category) {
            group.add(current);
            return result;
          }
        }
        result.add([current]);
        return result;
      }
    });
    return result;
  }
}
