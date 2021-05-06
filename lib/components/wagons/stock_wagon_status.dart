import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class StockWagonStatus extends StatelessWidget {
  final Wagon wagon;
  final RESOURCE_CATEGORY category;

  const StockWagonStatus({required this.wagon, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: wagon.stock.resourceForCategory(category).map(
        (resource) {
          return ResourceImageView(
            resource,
            showAmount: true,
            size: 32,
          );
        },
      ).toList(),
    );
  }
}
