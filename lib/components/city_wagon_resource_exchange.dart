import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bouncing_outlined_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/components/ui/action_button.dart';

enum EXCHANGE_MOD { BUY, SELL }

class CityWagonResourceExchange extends StatelessWidget {
  final Resource resource;
  final City city;
  final Wagon wagon;
  final int amountTradeValue = 1;
  final EXCHANGE_MOD mode;

  CityWagonResourceExchange(
      {required this.city,
      required this.wagon,
      required this.resource,
      required this.mode});

  @override
  Widget build(BuildContext context) {
    var company = InheritedCompany.of(context).company;
    var wagonRes = wagon.stock.resourceInStock(resource);
    var cityRes = city.stock.resourceInStock(resource);
    var sellPricePerUnit =
        city.buyPriceForResource(resource, company.allCities, withAmount: 1);
    var buyPricePerUnit =
        city.sellPriceForResource(resource, company.allCities, withAmount: 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getTradeUnit(
          company: company,
          pricePerUnit: isBuyMode() ?  sellPricePerUnit : buyPricePerUnit,
          price: isBuyMode() ? sellPricePerUnit : buyPricePerUnit,
          tradeResource: isBuyMode() ? cityRes : wagonRes,
          actionText: isBuyMode()
              ? ChumakiLocalizations.labelBuy
              : ChumakiLocalizations.labelSell,
          onPress: onPressHandler(company),
          onDoublePress: isBuyMode() ? null : () => onDoublePressHandler(company),
        ),
      ],
    );
  }

  bool isBuyMode() {
    return mode == EXCHANGE_MOD.BUY;
  }

  VoidCallback? onPressHandler(Company company) {
    return isBuyMode()
        ? (enableBuyButton(company)
            ? () {
                var res = resource.cloneWithAmount(amountTradeValue);
                if (wagon.canFitNewResource(res)) {
                  city.sellResource(
                      resource: res, toWagon: wagon, company: company);
                }
              }
            : null)
        : (enableSellButton()
            ? () {
                var res = resource.cloneWithAmount(amountTradeValue);
                city.buyResource(
                    resource: res, fromWagon: wagon, company: company);
              }
            : null);
  }

  void onDoublePressHandler(Company company) {
    final availableToSell = wagon.stock.resourceInStock(resource);
    if (availableToSell != null) {
      city.buyResource(
          resource: availableToSell, fromWagon: wagon, company: company);
    }
  }

  Widget getTradeUnit({
    required Company company,
    Resource? tradeResource,
    required double pricePerUnit,
    required double price,
    VoidCallback? onPress,
    VoidCallback? onDoublePress,
    required String actionText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ActionButton(
            onDoublePress: onDoublePress,
            onPress: onPress,
            action: TitleText(actionText),
            image: Column(
              children: [
                TitleText(
                    ChumakiLocalizations.getForKey(resource.fullLocalizedKey)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ResourceImageView(
                      resource.cloneWithAmount(amountTradeValue),
                      size: 92,
                    ),
                    BouncingOutlinedText(
                      tradeResource == null
                          ? "0"
                          : tradeResource.amount.toString(),
                      size: 32,
                      fontColor: getFontColor(company),
                      style: gameTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            subTitle:  MoneyUnitView(Money(price),
                isEnough: isBuyMode()
                    ? enableBuyButton(company)
                    : enableSellButton()),
          ),
        ),
      ],
    );
  }

  Color getFontColor(Company company) {
    if (isBuyMode()) {
      return enableBuyButton(company) ? Colors.yellow : Colors.grey;
    } else {
      return enableSellButton() ? Colors.yellow : Colors.grey;
    }
  }

  bool enableBuyButton(Company company) {
    var resToSell = resource.cloneWithAmount(amountTradeValue);
    var money = city.buyPriceForResource(resToSell, company.allCities);
    var hasWagonEnoughMoney = company.hasMoney(money);
    return hasWagonEnoughMoney &&
        city.canSellResource(resToSell) &&
        wagon.canFitNewResource(resToSell);
  }

  bool enableSellButton() {
    var resToBuy = resource.cloneWithAmount(amountTradeValue);
    return wagon.stock.hasEnough(resToBuy);
  }
}
