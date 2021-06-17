import 'package:chumaki/components/stock_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:flutter/material.dart';

class CityEventView extends StatelessWidget {
  final City city;
  const CityEventView({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = city.activeEvent!;
    return Column(
      children: [
        Text(ChumakiLocalizations.getForKey(event.localizedTitleKey), style: Theme.of(context).textTheme.headline3,),
        Text(ChumakiLocalizations.getForKey(event.localizedTextKey), style: Theme.of(context).textTheme.headline5,),
        Text(ChumakiLocalizations.labelRequirements, style: Theme.of(context).textTheme.headline4),
        StockView(event.requirements),
      ],
    );
  }
}
