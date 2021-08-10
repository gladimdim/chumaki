import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/money_unit_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/resources/resource.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/extensions/list.dart';

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
          child: GameText(
            ChumakiLocalizations.getForKey(event.localizedKeyTitle),
            addStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(height: 10,),
        Image.asset(
          event.artPath,
          width: CITY_DETAILS_VIEW_WIDTH / 2,
          fit: BoxFit.fitWidth,
        ),
        GameText(
          ChumakiLocalizations.getForKey(event.localizedKeyText),
          addStyle: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 10,),
        if (!event.isDone())
          BorderedBottom(
            child: GameText(
              ChumakiLocalizations.labelRequirements,
              addStyle: Theme.of(context).textTheme.headline2,
            ),
          ),
        if (!event.isDone())
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: event.requirements
                      .divideBy(3)
                      .map((List<Resource> reses) {
                return Row(
                  children: reses
                      .map(
                        (req) => Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: StreamBuilder(
                                stream: widget.city.changes.where((event) =>
                                    event == CITY_EVENTS.STOCK_CHANGED),
                                builder: (context, _snapshot) {
                                  Wagon? wagon;

                                  try {
                                    wagon = widget.city.wagons.firstWhere(
                                      (wagon) => wagon.stock
                                          .hasEnough(req.cloneWithAmount(1)),
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
                          ),
                        ),
                      )
                      .toList(),
                );
              }).toList())),
        BorderedBottom(
          child: GameText(ChumakiLocalizations.labelPayment,
              addStyle: Theme.of(context).textTheme.headline4),
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
      company.donateResource(res.cloneWithAmount(1),
          fromWagon: wagon, toCity: widget.city);
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
