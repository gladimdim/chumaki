import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class CityEventView extends StatefulWidget {
  final City city;

  const CityEventView({Key? key, required this.city}) : super(key: key);

  @override
  State<CityEventView> createState() => _CityEventViewState();
}

class _CityEventViewState extends State<CityEventView> {
  @override
  Widget build(BuildContext context) {
    final event = widget.city.activeEvent!;
    final done = event.requirements.isEmpty;
    final company = InheritedCompany.of(context).company;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BorderedBottom(
          child: Text(
            ChumakiLocalizations.getForKey(event.localizedTitleKey),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Text(
          ChumakiLocalizations.getForKey(event.localizedTextKey),
          style: Theme.of(context).textTheme.headline5,
        ),
        if (!event.isDone())
          BorderedBottom(
            child: Text(ChumakiLocalizations.labelRequirements,
                style: Theme.of(context).textTheme.headline4),
          ),
        if (!event.isDone())
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: event.requirements
                  .map(
                    (req) => StreamBuilder(
                        stream: widget.city.changes.where(
                            (event) => event == CITY_EVENTS.STOCK_CHANGED),
                        builder: (context, _snapshot) {
                          Wagon? wagon;

                          try {
                            wagon = widget.city.wagons.firstWhere(
                              (wagon) =>
                                  wagon.stock.hasEnough(req.cloneWithAmount(1)),
                            );
                          } catch (e) {
                            print(
                                "No wagons found to satisfy need for res: ${req.localizedKey}");
                          }

                          bool canGive = false;
                          if (wagon == null) {
                            canGive = false;
                          } else {
                            canGive = true;
                          }
                          return EventRequirementView(
                            requirement: req,
                            onDonate: canGive
                                ? () => _onDonate(company, req, wagon!)
                                : null,
                          );
                        }),
                  )
                  .toList(),
            ),
          ),
        BorderedBottom(
          child: Text(ChumakiLocalizations.labelPayment,
              style: Theme.of(context).textTheme.headline4),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActionButton(
            image: MoneyUnitView(
              event.payment,
              size: 64,
            ),
            subTitle: Container(),
            action: Text(ChumakiLocalizations.labelTakePayment),
            onPress: done ? () => _getRevenueForEvent(company) : null,
          ),
        ),
      ],
    );
  }

  void _getRevenueForEvent(Company company) {
    company.finishEvent(widget.city.activeEvent!, inCity: widget.city);
  }

  void _onDonate(Company company, Resource res, Wagon wagon) {
    setState(() {
      company.donateResource(res.cloneWithAmount(1), fromWagon: wagon, toCity: widget.city);
    });
  }
}

class EventRequirementView extends StatelessWidget {
  final Resource requirement;
  final VoidCallback? onDonate;

  const EventRequirementView(
      {Key? key, required this.requirement, this.onDonate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPress: onDonate,
      image: Image.asset(this.requirement.imagePath, width: 128),
      subTitle: Text(this.requirement.amount.toString()),
      action: Text(ChumakiLocalizations.labelGive),
    );
  }
}
