import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_amount_selector.dart';
import 'package:chumaki/components/resource_category_group.dart';
import 'package:chumaki/components/wagons/wagon_stock_bar.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

import 'package:chumaki/views/inherited_company.dart';

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
    var company = InheritedCompany.of(context).company;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: company.changes,
                    builder: (context, snap) {
                      return MoneyUnitView(company.getMoney());
                    }),
              ),
            ],
          ),
        ),
        ...sortedResourcesByCategories().map(
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

  List<List<Resource>> sortedResourcesByCategories() {
    var list = groupResourcesByCategory(RESOURCES.values
        .where((resType) {
          var fakeResource = Resource.fromType(resType);
          return widget.wagon.stock.hasResource(fakeResource) ||
              widget.city.stock.hasResource(fakeResource);
        })
        .map<Resource>(Resource.fromType)
        .toList()
        .toList());

    var allUnlocked = list
        .where((List<Resource> res) =>
            widget.wagon.categoryUnlocked(res.first.category))
        .toList();
    var allLocked = list
        .where((List<Resource> res) =>
            !widget.wagon.categoryUnlocked(res.first.category))
        .toList();

    return [...allUnlocked, ...allLocked];
  }

  void onAmountChanged(int newValue) {
    setState(() {
      amountTradeValue = newValue;
    });
  }
}
