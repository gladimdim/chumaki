import 'dart:async';

import 'package:chumaki/components/city/can_unlock_cities_view.dart';
import 'package:chumaki/components/city/city_wagons_view.dart';
import 'package:chumaki/components/city/city_stock_view.dart';
import 'package:chumaki/components/global_market_view.dart';
import 'package:chumaki/components/manufacturing/city_manufacturing_view.dart';
import 'package:chumaki/components/resource_image_view.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/city_menu_item.dart';
import 'package:chumaki/components/ui/city_menu_item_view.dart';
import 'package:chumaki/components/wagons/wagon_details.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/resources/resource_category.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:chumaki/views/city_event_view.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:flutter/material.dart';

const CITY_DETAILS_VIEW_WIDTH = 780.0;

class SelectedCityView extends StatefulWidget {
  final City city;

  SelectedCityView(this.city);

  @override
  _SelectedCityViewState createState() => _SelectedCityViewState();
}

class _SelectedCityViewState extends State<SelectedCityView> {
  Widget? detailsContent;

  CityMenuItem? selectedButton;
  late StreamSubscription _cityListener;

  void initState() {
    super.initState();
    _cityListener = widget.city.changes
        .where((event) => [CITY_EVENTS.WAGON_DISPATCHED, CITY_EVENTS.EVENT_DONE]
            .contains(event))
        .listen(_recalcMenuItems);
  }

  void _recalcMenuItems(CITY_EVENTS event) {
    setState(() {
      selectedButton = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final company = InheritedCompany.of(context).company;
    return StreamBuilder(
      stream: widget.city.changes,
      builder: (context, data) => AnimatedSize(
        alignment: Alignment.topLeft,
        duration: Duration(milliseconds: 400),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: selectedButton == null ? 195 : CITY_DETAILS_VIEW_WIDTH),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: CITY_DETAILS_VIEW_WIDTH / 4,
                  minHeight: 150,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CityMenuItem(
                          menuKey: "new_wheel",
                          image: Image.asset(
                            "images/icons/wagon/wagon_2d.png",
                            width: 128,
                          ),
                          label: TitleText(ChumakiLocalizations.labelCompanies),
                          contentBuilder: (context) =>
                              CityWagonsView(city: widget.city)),
                      CityMenuItem(
                          menuKey: "market",
                          image: Image.asset(
                            "images/icons/market/market.png",
                            width: 128,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleText(ChumakiLocalizations.labelMarket),
                              ...widget.city.manufacturings
                                  .map((mfg) => ResourceImageView(
                                        mfg.produces,
                                        size: 32,
                                      ))
                                  .toList(),
                            ],
                          ),
                          playSoundOnOpen: () {
                            SoundManager.instance.playLocalMarket();
                          },
                          contentBuilder: (context) =>
                              CityStockView(city: widget.city)),
                      CityMenuItem(
                          menuKey: "global_market",
                          image: Image.asset(
                            "images/icons/market/market2.png",
                            width: 128,
                          ),
                          playSoundOnOpen: () {
                            SoundManager.instance.playGlobalMarket();
                          },
                          label:
                              TitleText(ChumakiLocalizations.labelWorldMarket),
                          contentBuilder: (context) =>
                              GlobalMarketView(currentCity: widget.city)),
                      if (company.cityCanUnlockMore(widget.city))
                        CityMenuItem(
                            menuKey: "unlock",
                            image: Image.asset(
                              "images/cities/church.png",
                              width: 128,
                            ),
                            label: TitleText(
                                ChumakiLocalizations.labelMenuBuyNewRoutes),
                            contentBuilder: (context) =>
                                CanUnlockCitiesView(widget.city)),
                      if (widget.city.manufacturings.isNotEmpty)
                        CityMenuItem(
                          menuKey: "manufacturing",
                          image: Image.asset(
                            "images/icons/lock/lock.png",
                            width: 128,
                          ),
                          playSoundOnOpen: () {
                            SoundManager.instance.playGlobalMarket();
                          },
                          label: TitleText("Manufacturing"),
                          contentBuilder: (context) => CityManufacturingView(
                            city: widget.city,
                          ),
                        ),
                      ...widget.city.wagons.map(
                        (wagon) => CityMenuItem(
                            menuKey: wagon.fullLocalizedName,
                            image: StreamBuilder(
                              stream: wagon.changes,
                              builder: (context, _) => Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipOval(
                                      child: Image.asset(wagon.getImagePath(),
                                          width: 128),
                                    ),
                                  ),
                                  wagon.leader == null
                                      ? Container()
                                      : StreamBuilder(
                                          stream: wagon.leader!.changes,
                                          builder: (context, _) => Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Row(
                                              children: wagon.leader!.perks
                                                  .map(
                                                    (perk) => Image.asset(
                                                      categoryToImagePath(perk
                                                          .affectsResourceCategory),
                                                      width: 32,
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            label: StreamBuilder(
                                stream: wagon.changes,
                                builder: (context, snap) => TitleText(
                                    ChumakiLocalizations.getForKey(
                                        wagon.fullLocalizedName))),
                            contentBuilder: (context) => WagonDetails(
                                  wagon: wagon,
                                  city: widget.city,
                                )),
                      ),
                      if (widget.city.activeEvent != null)
                        CityMenuItem(
                          menuKey: "activeEvent",
                          image: Image.asset(widget.city.activeEvent!.iconPath),
                          contentBuilder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CityEventView(city: widget.city),
                          ),
                          label: TitleText(
                            ChumakiLocalizations.getForKey(
                                widget.city.activeEvent!.localizedKeyTitle),
                          ),
                        ),
                    ].map((action) {
                      return CityMenuItemView(
                        isSelected: selectedButton != null &&
                            selectedButton!.menuKey == action.menuKey,
                        menuItem: action,
                        onPress: () => handleMenuItemPress(action),
                      );
                    }).toList()),
              ),
              Expanded(
                flex: 1,
                child: AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: getContent(context),
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: selectedButton != null
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleMenuItemPress(CityMenuItem action) {
    if (action.playSoundOnOpen != null) {
      action.playSoundOnOpen!();
    }
    if (selectedButton == action) {
      selectedButton = null;
    } else {
      selectedButton = action;
    }
    setState(() {});
  }

  Widget getContent(BuildContext context) {
    var button = selectedButton;
    return button != null
        ? button.contentBuilder(context)
        : Container(
            width: 0,
            height: 0,
          );
  }

  void dispose() {
    _cityListener.cancel();
    super.dispose();
  }
}
