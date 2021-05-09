import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/bordered_top.dart';
import 'package:chumaki/components/wagons/wagon_dispatcher.dart';
import 'package:chumaki/components/wagons/wagon_resource_exchanger.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:flutter/material.dart';

class WagonDetails extends StatelessWidget {
  final Wagon wagon;
  final City city;

  WagonDetails({required this.wagon, required this.city});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: wagon.changes,
      builder: (context, snap) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BorderedBottom(
            child: BorderedTop(
              child: Center(
                child: Text(
                  ChumakiLocalizations.getForKey(wagon.fullLocalizedName),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          VerticalDivider(),
          TitleText(ChumakiLocalizations.labelSend),
          WagonDispatcher(wagon: wagon, city: city),
          BorderedTop(
            child: BorderedBottom(
              child: Center(child: TitleText(ChumakiLocalizations.labelCompanyContains)),
            ),
          ),
          WagonResourceExchanger(wagon, city),
        ],
      ),
    );
  }
}
