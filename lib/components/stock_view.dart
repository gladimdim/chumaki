import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/resources/resource.dart';
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
          if (stock.isNotEmpty)
            Row(
                children: stock.toList().map<Widget>((resource) {
              return ResourceImageView(
                resource,
                showAmount: true,
              );
            }).toList()),
          if (stock.isEmpty) Text(ChumakiLocalizations.labelNothing),
        ],
      ),
    );
  }
}
