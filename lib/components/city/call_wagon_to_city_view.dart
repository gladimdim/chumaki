import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/action_text.dart';
import 'package:chumaki/components/wagons/wagon_avatar.dart';
import 'package:chumaki/extensions/list.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/tasks/route_task.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:chumaki/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef WagonContainer = List<Tuple2<City, Wagon>>;

class CallWagonToCityView extends StatelessWidget {
  final City toCity;
  final Company company;

  const CallWagonToCityView(
      {Key? key, required this.toCity, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompanyEvent>(stream: company.changes.where((event) {
      return event.item1 == COMPANY_EVENTS.TASK_ENDED ||
          event.item1 == COMPANY_EVENTS.TASK_STARTED;
    }), builder: (context, snapshot) {
      return Column(
        children: allOtherWagons()
            .divideBy(2)
            .map((wagons) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: wagons
                    .map((wagon) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 230,
                            child: ActionButton(
                              onPress: () {
                                company.startTask(
                                    from: wagon.item1,
                                    to: toCity,
                                    withWagon: wagon.item2);
                              },
                              image: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      WagonAvatar(wagon: wagon.item2),
                                      TitleText(ChumakiLocalizations.getForKey(
                                        wagon.item2.fullLocalizedName,
                                      ))
                                    ],
                                  ),
                                  CityAvatar(
                                    width: 92,
                                    city: wagon.item1,
                                  ),
                                ],
                              ),
                              subTitle: Container(),
                              action: Container(
                                child: ActionText(
                                  "${ChumakiLocalizations.labelRecall} (${readableDuration(RouteTask(wagon.item1, toCity, wagon: wagon.item2).duration!)})",
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList()))
            .toList(),
      );
    });
  }

  WagonContainer allOtherWagons() {
    return company.allCities
        .where((city) => city != toCity)
        .fold<WagonContainer>([], (WagonContainer allWagons, city) {
      city.wagons.forEach((wagonToAdd) {
        allWagons.add(Tuple2(city, wagonToAdd));
      });
      return allWagons;
    });
  }
}
