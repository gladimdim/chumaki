import 'package:chumaki/components/money_unit.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/components/ui/bouncing_text.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
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
    var company = InheritedCompany.of(context).company;
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
              MoneyUnitView(Money(sellPrice)),
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
                onPressed: enableSellButton(context)
                    ? () {
                        var res = resource.cloneWithAmount(amountTradeValue);
                        if (wagon.canFitNewResource(res)) {
                          city.sellResource(
                              resource: res, toWagon: wagon, company: company);
                        }
                      }
                    : null,
                icon: Icon(Icons.arrow_back_outlined, size: 32),
              ),
              SizedBox(
                width: 80,
                height: 50,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ResourceImageView(
                        resource.cloneWithAmount(amountTradeValue),
                        size: 64,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: BouncingOutlinedText(
                        wagonRes == null ? "0" : wagonRes.amount.toString(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: BouncingOutlinedText(
                        cityRes == null ? "0" : cityRes.amount.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: enableBuyButton()
                    ? () {
                        var res = resource.cloneWithAmount(amountTradeValue);
                        city.buyResource(
                            resource: res, fromWagon: wagon, company: company);
                      }
                    : null,
                icon: Icon(Icons.arrow_forward_outlined, size: 32),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              MoneyUnitView(Money(buyPrice)),
              Text("(${buyPricePerUnit}x$amountTradeValue)"),
            ],
          ),
        ),
      ],
    );
  }

  bool enableSellButton(BuildContext context) {
    var company = InheritedCompany.of(context).company;

    var resToSell = resource.cloneWithAmount(amountTradeValue);
    var money = city.prices.sellPriceForResource(resToSell);
    var hasWagonEnoughMoney = company.hasMoney(money);
    return hasWagonEnoughMoney && city.canSellResource(resToSell);
  }

  bool enableBuyButton() {
    var resToBuy = resource.cloneWithAmount(amountTradeValue);
    return wagon.stock.hasEnough(resToBuy);
  }
}
