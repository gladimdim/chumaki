import 'package:chumaki/components/group_control.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class CityWagonResourceExchange extends StatelessWidget {
  final Resource resource;
  final City city;
  final Wagon wagon;
  final int amountTradeValue;

  CityWagonResourceExchange({
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
      padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GroupedControl(
            title: Text("Купити"),
            titleHeight: 16,
            titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: TitleText(
                  wagonRes == null ? "Пусто" : wagonRes.amount.toString(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 5,
                  color: resource.color,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "images/wagon/wagon.png",
                    width: 50,
                  ),
                ),
              ),
            ]),
            width: 100,
            borderColor: resource.color,
            borderWidth: 3,
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  var res = resource.cloneWithAmount(amountTradeValue);
                  if (wagon.canFitNewResource(res)) {
                    city.sellResource(resource: res, toWagon: wagon);
                  }
                },
                icon: Icon(Icons.arrow_back_outlined, size: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/resources/money/money.png",
                    width: 22,
                  ),
                  Text(
                    city.prices
                        .sellPriceForResource(resource,
                            withAmount: amountTradeValue)
                        .toString(),
                  ),
                ],
              ),
            ],
          ),
          ResourceImageView(
            resource.cloneWithAmount(amountTradeValue),
            size: 64,
            showAmount: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  var res = resource.cloneWithAmount(amountTradeValue);
                  city.buyResource(resource: res, fromWagon: wagon);
                },
                icon: Icon(Icons.arrow_forward_outlined, size: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Money(0).imagePath,
                    width: 22,
                  ),
                  Text(
                    city.prices
                        .buyPriceForResource(resource,
                            withAmount: amountTradeValue)
                        .toString(),
                  ),
                ],
              ),
            ],
          ),
          GroupedControl(
            width: 100,
            borderColor: resource.color,
            borderWidth: 3,
            titleAlignment: GROUP_TITLE_ALIGNMENT.CENTER,
            height: 100,
            title: Text("Продати"),
            titleHeight: 16,
            child: Stack(
              children: [
                Center(
                  child: TitleText(
                    cityRes == null ? "Пусто" : cityRes.amount.toString(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      "images/cities/church.png",
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
