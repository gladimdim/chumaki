import 'package:chumaki/components/city/city_avatar.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/wagons/wagon_avatar.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/wagon.dart';
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
    return StreamBuilder<COMPANY_EVENTS>(stream: company.changes.where((event) {
      return event == COMPANY_EVENTS.TASK_ENDED ||
          event == COMPANY_EVENTS.TASK_STARTED;
    }), builder: (context, snapshot) {
      return Column(
        children: allOtherWagons()
            .map((wagon) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActionButton(
                    onPress: () {
                      company.startTask(
                          from: wagon.item1,
                          to: toCity,
                          withWagon: wagon.item2);
                    },
                    image: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            WagonAvatar(wagon: wagon.item2),
                            Text(ChumakiLocalizations.getForKey(
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
                      child: Text(ChumakiLocalizations.labelRecall,
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  ),
                ))
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
