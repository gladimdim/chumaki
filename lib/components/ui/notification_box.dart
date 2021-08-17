import 'dart:async';

import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/cities/city.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';

class NotificationBox extends StatefulWidget {
  final Company company;

  const NotificationBox({Key? key, required this.company}) : super(key: key);

  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  StreamSubscription? _sub;
  List<StreamSubscription> _citySub = [];
  Timer? _timer;
  String? _event;

  @override
  void initState() {
    super.initState();
    _sub = widget.company.changes
        .where((event) => event.item1 == COMPANY_EVENTS.TASK_ENDED)
        .listen((event) {
      _timer?.cancel();
      setShow(eventToText(event));
      _timer = Timer(Duration(seconds: 3), () {
        setShow(null);
      });
    });

    widget.company.allCities.forEach((city) {
      final sub = city.changes
          .where((event) => event == CITY_EVENTS.EVENT_NEW)
          .listen((event) {
        setShow(
            "${ChumakiLocalizations.getForKey("notifications.newEvent")} ${ChumakiLocalizations.getForKey(city.localizedKeyName)}");
        SoundManager.instance.playNewEvent();
      });
      _citySub.add(sub);
    });
  }

  void setShow(String? event) {
    setState(() {
      _event = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 250),
      child: _event != null
          ? Container(
              height: MENU_ITEM_WIDTH,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: GameText(
                  _event!,
                  addStyle: Theme.of(context).textTheme.headline5,
                ),
              ),
            )
          : Container(
              height: MENU_ITEM_WIDTH,
              width: 0,
            ),
    );
  }

  String eventToText(CompanyEvent event) {
    switch (event.item1) {
      case COMPANY_EVENTS.TASK_ENDED:
        final city = event.item2 as City;
        return "${ChumakiLocalizations.getForKey(city.localizedKeyName)} ${ChumakiLocalizations.getForKey("notifications.taskEnded")}";
      default:
        return "";
    }
  }

  void dispose() {
    _sub?.cancel();
    _timer?.cancel();
    _citySub.forEach((element) {
      element.cancel();
    });
    super.dispose();
  }
}
