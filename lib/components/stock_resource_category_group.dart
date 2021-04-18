import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';

class StockResourceCategoryGroup extends StatelessWidget {
  final List<Resource> resources;

  StockResourceCategoryGroup({
    required this.resources,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Column(
        children: [
          TitleText(resourceCategoryToString(resources.first.category)),
          Row(children: resources.map((resource) => ResourceImageView(resource, showAmount: true,)).toList()),
        ],
      ),
    );
  }
}
