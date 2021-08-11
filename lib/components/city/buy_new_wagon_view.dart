import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/action_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/wagons/wagon.dart';

class BuyNewWagonView extends StatefulWidget {
  final City city;

  const BuyNewWagonView(this.city);

  @override
  _BuyNewWagonViewState createState() => _BuyNewWagonViewState();
}

class _BuyNewWagonViewState extends State<BuyNewWagonView> {
  final Money wagonPrice = Money(300);

  @override
  Widget build(BuildContext context) {
    final wagon = Wagon.generateRandomWagon();
    final company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: company.changes.where((event) =>
          event == COMPANY_EVENTS.MONEY_REMOVED ||
          event == COMPANY_EVENTS.MONEY_ADDED),
      builder: (context, snapshot) => ActionButton(
        onPress: company.hasEnoughMoney(wagonPrice)
            ? () {
                company.buyWagon(wagon,
                    forCity: widget.city, price: wagonPrice);
              }
            : null,
        image: ResizedImage(Wagon.imagePath, width: 128),
        action: ActionText(ChumakiLocalizations.labelBuyNewWagon),
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoneyUnitView(wagonPrice,
                isEnough: company.hasEnoughMoney(wagonPrice)),
            Text("/"),
            MoneyUnitView(company.getMoney(),
                isEnough: company.hasEnoughMoney(wagonPrice)),
          ],
        ),
      ),
    );
  }
}
