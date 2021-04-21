import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/components/title_text.dart';

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
          height: resources.length * 118,
          width: CITY_DETAILS_VIEW_WIDTH,
          borderColor: Colors.black,
          title: TitleText(resourceCategoryToString(resources.first.category)),
          borderWidth: 1,
          titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 2, right: 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(Wagon.imagePath, width: 64),
                    Image.asset("images/cities/church.png", width: 64)
                  ],
                ),
                ...resources.map((resource) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: CityWagonResourceExchange(
                        wagon: wagon,
                        city: city,
                        resource: resource,
                        amountTradeValue: amountTradeValue),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
