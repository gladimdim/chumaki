import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';

class ResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;
  final City city;
  final Wagon wagon;
  final int amountTradeValue;

  ResourceCategoryGroup({
    required this.resources,
    required this.city,
    required this.wagon,
    required this.amountTradeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        child: GroupedControl(
          height: resources.length * 80,
          width: CITY_DETAILS_VIEW_WIDTH,
          borderColor: Colors.blueGrey,
          title: resourceCategoryToString(resources.first.category),
          borderWidth: 3,
          titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
          child: Column(
            children: [
              ...resources.map((resource) {
                return CityWagonResourceExchange(
                    wagon: wagon,
                    city: city,
                    resource: resource,
                    amountTradeValue: amountTradeValue);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
