import 'package:chumaki/components/stock_resource_category_group.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/wagons/wagon_list_item.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class CityLocalMarket extends StatefulWidget {
  final City city;

  const CityLocalMarket({required this.city});

  @override
  _CityLocalMarketState createState() => _CityLocalMarketState();
}

class _CityLocalMarketState extends State<CityLocalMarket> {
  Wagon? selectedWagon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WagonListItem(city: widget.city),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Colors.black),
            ),
          ),
          child: StreamBuilder(
              stream: widget.city.changes.stream,
              builder: (context, data) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(ChumakiLocalizations.labelContains),
                    if (!widget.city.stock.isEmpty)
                      Column(
                        children: groupResourcesByCategory(
                            widget.city.stock.iterator.toList())
                            .map<Widget>((resources) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: StockResourceCategoryGroup(
                                resources: resources, forCity: widget.city),
                          );
                        }).toList(),
                      ),
                    if (widget.city.stock.isEmpty) Text("Нічого"),
                  ],
                );
              }),
        ),
      ]
    );
  }
}
