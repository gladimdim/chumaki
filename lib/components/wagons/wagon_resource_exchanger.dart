import 'package:chumaki/components/resource_category_group.dart';
import 'package:chumaki/components/wagons/wagon_stock_bar.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:flutter/material.dart';

class WagonResourceExchanger extends StatefulWidget {
  final Wagon wagon;
  final City city;

  WagonResourceExchanger(this.wagon, this.city);

  @override
  _WagonResourceExchangerState createState() => _WagonResourceExchangerState();
}

class _WagonResourceExchangerState extends State<WagonResourceExchanger> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WagonStockBar(
          wagon: widget.wagon,
        ),
        ...sortedResourcesByCategories().map(
          (List<Resource> groupedResources) {
            return ResourceCategoryGroup(
              city: widget.city,
              wagon: widget.wagon,
              resources: groupedResources,
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
}
