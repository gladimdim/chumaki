import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class StockWagonStatus extends StatelessWidget {
  final Wagon wagon;
  const StockWagonStatus({required this.wagon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: wagon.stock.stock.map((resource) {
        return ResourceImageView(resource, showAmount: true, size: 32,);
      }).toList(),
    );
  }
}
