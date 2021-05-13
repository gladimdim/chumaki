import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/wagons/wagon_details.dart';
import 'package:chumaki/components/wagons/wagon_list_item.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/models/wagon.dart';

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
    return Column(children: [
      BorderedBottom(child: TitleText(ChumakiLocalizations.labelBuyNewWagon)),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: WagonListItem(wagon: wagon, city: widget.city)),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: company.hasEnoughMoney(wagonPrice) ? () {
                company.buyWagon(wagon, forCity: widget.city, price: wagonPrice);
              } : null,
              child: BorderedBottom(
                child: MoneyUnitView(wagonPrice, isEnough: company.hasEnoughMoney(wagonPrice)),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
