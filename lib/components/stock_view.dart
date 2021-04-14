import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:flutter/material.dart';
import 'resource_image_view.dart';

class StockView extends StatelessWidget {
  final List<Resource> stock;

  StockView(this.stock);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText("Містить"),
          if (stock.isNotEmpty)
            Row(
                children: stock.toList().map<Widget>((resource) {
              return ResourceImageView(resource);
            }).toList()),
          if (stock.isEmpty) Text("Нічого"),
        ],
      ),
    );
  }
}
