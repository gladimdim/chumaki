import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/selected_city_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class StockResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;
  final City forCity;

  StockResourceCategoryGroup({
    required this.resources,
    required this.forCity,
  });

  @override
  Widget build(BuildContext context) {
    return GroupedControl(
      title: resourceCategoryToString(resources.first.category),
      borderColor: Colors.blueGrey,
      width: CITY_DETAILS_VIEW_WIDTH,
      height: 110,
      borderWidth: 3,
      titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
      child: SingleChildScrollView(
        child: Row(
            children: resources
                .map((resource) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                        children: [
                          ResourceImageView(
                            resource,
                            showAmount: true,
                          ),
                          Row(
                            children: [
                              Image.asset(Wagon.imagePath, width: 16),
                              Text(forCity.prices
                                  .sellPriceForResource(resource)
                                  .toString()),
                              Image.asset("images/cities/church.png", width: 16),
                              Text(forCity.prices
                                  .buyPriceForResource(resource)
                                  .toString())
                            ],
                          ),
                        ],
                      ),
                ))
                .toList()),
      ),
    );
  }
}
