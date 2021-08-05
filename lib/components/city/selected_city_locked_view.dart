import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/city/selected_city_view.dart';
import 'package:chumaki/components/city/small_city_avatar.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/ui/action_button.dart';
import 'package:chumaki/components/ui/bordered_all.dart';
import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

class SelectedCityLockedView extends StatelessWidget {
  final City city;

  const SelectedCityLockedView(this.city);

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return DecoratedContainer3(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: CITY_DETAILS_VIEW_WIDTH,
        ),
        child: Column(
          children: [
            BorderedBottom(
              child: Text(
                ChumakiLocalizations.labelCityIsLocked,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              ChumakiLocalizations.labelUnlockAt,
              style: Theme.of(context).textTheme.headline5,
            ),
            BorderedAll(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: company.allCities.where((cityThatCanUnlock) {
                  var realCity = company.refToCityByName(city);
                  return company
                      .citiesToRealCities(cityThatCanUnlock.unlocksCities)
                      .contains(realCity);
                }).map((cityThatUnlocks) {
                  return SizedBox(
                    width: CITY_DETAILS_VIEW_WIDTH - CITY_MENU_WIDTH / 4,
                    height: 280,
                    child: ActionButton(
                      image: CityAvatarStacked(
                        city: cityThatUnlocks,
                        width: 180,
                      ),
                      subTitle: Container(),
                      action: Text(ChumakiLocalizations.labelGoTo),
                      onPress: () => _navigateViewerToCity(cityThatUnlocks),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (city.manufacturings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BorderedAll(
                  child: Column(
                    children: [
                      Text(ChumakiLocalizations.labelProductionCenter,
                          style: Theme.of(context).textTheme.headline3),
                      Row(
                        children: city.manufacturings
                            .map((mfg) => ResourceImageView(
                                  mfg.produces,
                                  size: 64,
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BorderedAll(child: CityStockView(city: city)),
            ),
          ],
        ),
      ),
    );
  }

  _navigateViewerToCity(City cityThatUnlocks) {
    final viewer = globalViewerKey.currentState;
    if (viewer == null) {
      return;
    }
    viewer.navigateToCity(to: cityThatUnlocks);
  }
}
