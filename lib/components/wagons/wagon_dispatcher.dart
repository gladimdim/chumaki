import 'package:chumaki/components/city/small_city_avatar_with_centers.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/tasks/path_route.dart';
import 'package:chumaki/models/tasks/route.dart';
import 'package:chumaki/models/tasks/route_task.dart';
import 'package:chumaki/models/wagons/wagon.dart';
import 'package:chumaki/utils/time.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/extensions/list.dart';

class WagonDispatcher extends StatelessWidget {
  final Wagon wagon;
  final City city;

  WagonDispatcher({required this.wagon, required this.city});

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    final nearby = city.connectsTo(inCompany: company);
    final allOtherCities = company.allCities
        .where((element) =>
            !element.equalsTo(city) &&
            element.isUnlocked() &&
            nearby.intersection<City, City>(
                [element], (a, b) => a.equalsTo(b)).isEmpty)
        .toList();
    return Column(
      children: [
        ...nearby.divideBy(3).map((List<City> toCities) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: toCities.map((toCity) {
              var pathRoute = PathRoute(
                  stops: fullRoute(
                      from: city,
                      to: toCity,
                      allowLocked: true,
                      company: company),
                  allRoutes: company.cityRoutes,
                  from: city);

              return StreamBuilder(
                stream: toCity.changes,
                builder: (context, snapshot) => SizedBox(
                  height: 120,
                  child: ActionButton(
                    action: Text(readableDuration(pathRoute.totalDuration())),
                    subTitle: Text(ChumakiLocalizations.labelSend),
                    onPress: toCity.isUnlocked()
                        ? () => dispatch(toCity, context)
                        : null,
                    image: SmallCityAvatarWithCenters(city: toCity),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
        Text(
          ChumakiLocalizations.labelOtherCities,
          style: Theme.of(context).textTheme.headline4,
        ),
        ...allOtherCities.divideBy(3).map((List<City> cities) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cities.map((toCity) {
                var fakeRoute = RouteTask(city, toCity, wagon: wagon);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SizedBox(
                      height: 120,
                      child: StreamBuilder(
                        stream: toCity.changes,
                        builder: (context, snapshot) => ActionButton(
                          subTitle: Text(readableDuration(fakeRoute.duration!)),
                          action: Text(
                            ChumakiLocalizations.labelSend,
                          ),
                          onPress: () => dispatch(toCity, context),
                          image: SmallCityAvatarWithCenters(city: toCity),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList()
      ],
    );
  }

  void dispatch(City to, BuildContext context) {
    var company = InheritedCompany.of(context).company;
    company.startTask(from: city, to: to, withWagon: wagon);
  }
}
