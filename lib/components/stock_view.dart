import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:flutter/material.dart';
import 'resource_image_view.dart';
class CityStockView extends StatelessWidget {
  final City city;

  CityStockView(this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText("Stock"),
          Row(
              children: city.stock.toList().map<Widget>((resource) {
            return ResourceImageView(resource);
          }).toList()),
        ],
      ),
    );
  }
}
