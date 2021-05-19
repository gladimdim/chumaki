import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/ui/action_money_button.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionMoneyButton(
              onPress: enableSellButton(context)
                  ? () {
                      var res = resource.cloneWithAmount(amountTradeValue);
                      if (wagon.canFitNewResource(res)) {
                        city.sellResource(
                            resource: res, toWagon: wagon, company: company);
                      }
                    }
                  : null,
              action: TitleText(ChumakiLocalizations.labelBuy),
              image: Column(
                children: [
                  TitleText(ChumakiLocalizations.getForKey(resource.fullLocalizedKey)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ResourceImageView(
                        resource.cloneWithAmount(amountTradeValue),
                        size: 92,
                      ),
                      BouncingOutlinedText(
                        cityRes == null ? "0" : cityRes.amount.toString(),
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
              money: Column(
                children: [
                  MoneyUnitView(Money(sellPrice)),
                  Text("(${sellPricePerUnit}x$amountTradeValue)"),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ActionMoneyButton(
              onPress: enableBuyButton()
                  ? () {
                var res = resource.cloneWithAmount(amountTradeValue);
                city.buyResource(
                    resource: res, fromWagon: wagon, company: company);
              }
                  : null,
              action: TitleText(ChumakiLocalizations.labelSell),
              image: Column(
                children: [
                  TitleText(ChumakiLocalizations.getForKey(resource.fullLocalizedKey)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ResourceImageView(
                        resource.cloneWithAmount(amountTradeValue),
                        size: 92,
                      ),
                      BouncingOutlinedText(
                        wagonRes == null ? "0" : wagonRes.amount.toString(),
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
              money: Column(
                children: [
                  MoneyUnitView(Money(buyPrice), isEnough: wagonRes == null ? false : wagonRes.amount > 0),
                  Text("(${buyPricePerUnit}x$amountTradeValue)"),
                ],
              ),
            ),
          ],
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
