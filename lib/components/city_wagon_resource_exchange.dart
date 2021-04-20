import 'package:chumaki/components/resource_image_view.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ResourceImageView(resource),
        SizedBox(
          width: 75,
          height: 64,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.black),
            ),
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Text(
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
          ),
        ),
        SizedBox(
          width: 65,
          height: 70,
          child: Column(
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
        ),
        SizedBox(
          width: 65,
          height: 70,
          child: Column(
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
        ),
        SizedBox(
          width: 75,
          height: 64,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.black),
            ),
            child: Stack(
              children: [
                Center(
                  child: cityRes == null
                      ? Text("Пусто")
                      : Text(
                          cityRes.amount.toString(),
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
        ),
        ResourceImageView(resource),
      ],
    );
  }
}
