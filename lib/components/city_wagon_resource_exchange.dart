import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/models/city.dart';
import 'package:chumaki/models/company.dart';
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
    var sellPricePerUnit =
        city.prices.sellPriceForResource(resource, withAmount: 1);
    var buyPricePerUnit =
        city.prices.buyPriceForResource(resource, withAmount: 1);
    var sellPrice = city.prices
        .sellPriceForResource(resource, withAmount: amountTradeValue);
    var buyPrice =
        city.prices.buyPriceForResource(resource, withAmount: amountTradeValue);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              MoneyUnit(Money(sellPrice)),
              Text("(${sellPricePerUnit}x$amountTradeValue)"),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: enableSellButton() ? () {
                  var res = resource.cloneWithAmount(amountTradeValue);
                  if (wagon.canFitNewResource(res)) {
                    city.sellResource(resource: res, toWagon: wagon);
                  }
                } : null,
                icon: Icon(Icons.arrow_back_outlined, size: 32),
              ),
              SizedBox(
                width: 80,
                height: 50,
                child: Stack(children: [

                  Align(
                    alignment: Alignment.center,
                    child: ResourceImageView(
                      resource.cloneWithAmount(amountTradeValue),
                      size: 64,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                      child: Text(wagonRes == null ? "0" : wagonRes.amount.toString())
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(cityRes == null ? "0" : cityRes.amount.toString())
                  ),
                ]),
              ),
              IconButton(
                onPressed: enableBuyButton() ? () {
                  var res = resource.cloneWithAmount(amountTradeValue);
                  city.buyResource(resource: res, fromWagon: wagon);
                } : null,
                icon: Icon(Icons.arrow_forward_outlined, size: 32),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              MoneyUnit(Money(buyPrice)),
              Text("(${buyPricePerUnit}x$amountTradeValue)"),
            ],
          ),
        ),
      ],
    );
  }

  bool enableSellButton() {
    var resToSell = resource.cloneWithAmount(amountTradeValue);
    var money = city.prices.sellPriceForResource(resToSell);
    var hasWagonEnoughMoney = Company.instance.hasMoney(money);
    return hasWagonEnoughMoney && city.canSellResource(resToSell);
  }

  bool enableBuyButton() {
    var resToBuy = resource.cloneWithAmount(amountTradeValue);
    return wagon.stock.hasEnough(resToBuy);
  }
}
