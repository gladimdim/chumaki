import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/resource_group_control.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class CityWagonResourceExchangeRowItem extends StatelessWidget {
  final Resource resource;
  final City city;
  final Wagon wagon;
  final int amountTradeValue;

  CityWagonResourceExchangeRowItem({
    required this.city,
    required this.wagon,
    required this.resource,
    required this.amountTradeValue,
  });

  @override
  Widget build(BuildContext context) {
    var wagonRes = wagon.stock.resourceInStock(resource);
    var cityRes = city.stock.resourceInStock(resource);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {
              var res = resource.cloneWithAmount(amountTradeValue);
              if (wagon.canFitNewResource(res)) {
                city.sellResource(resource: res, toWagon: wagon);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GroupedControl(
                titleHeight: 24,
                title: TitleText("Купити"),
                titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
                width: 100,
                height: 80,
                borderColor: resource.color,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: MoneyUnit(
                      Money(
                        city.prices.sellPriceForResource(resource,
                            withAmount: amountTradeValue),
                      ),
                      direction: Axis.vertical,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ResourceImageView(resource),
          OutlinedButton(
            onPressed: () {
              var res = resource.cloneWithAmount(amountTradeValue);
              city.buyResource(resource: res, fromWagon: wagon);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GroupedControl(
                titleHeight: 24,
                title: TitleText("Продати"),
                titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
                width: 100,
                height: 80,
                borderColor: resource.color,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: MoneyUnit(
                      Money(
                        city.prices.buyPriceForResource(resource,
                            withAmount: amountTradeValue),
                      ),
                      direction: Axis.vertical,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
