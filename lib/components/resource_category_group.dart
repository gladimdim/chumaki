import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/wagons/stock_wagon_status.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/city_wagon_resource_exchange.dart';
import 'package:chumaki/components/title_text.dart';

class ResourceCategoryGroup extends StatefulWidget {
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
  _ResourceCategoryGroupState createState() => _ResourceCategoryGroupState();
}

class _ResourceCategoryGroupState extends State<ResourceCategoryGroup> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BorderedBottom(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(
                      ChumakiLocalizations.getForKey(
                          resourceCategoryToLocalizedKey(
                              widget.resources.first.category)),
                    ),
                    Row(children: [
                      StockWagonStatus(wagon: widget.wagon, category: widget.resources.first.category),
                      IconButton(
                        icon: isExpanded
                            ? Icon(Icons.arrow_upward)
                            : Icon(Icons.arrow_downward),
                        onPressed: toggleExpanded,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Padding(
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
                    ...widget.resources.map((resource) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: CityWagonResourceExchange(
                            wagon: widget.wagon,
                            city: widget.city,
                            resource: resource,
                            amountTradeValue: widget.amountTradeValue),
                      );
                    }).toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
