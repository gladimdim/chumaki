import 'dart:async';

import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/company.dart';
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
  Timer? _timer;
  COMPANY_EVENTS? _event;

  @override
  void initState() {
    super.initState();
    _sub = widget.company.changes
        .where((event) => event == COMPANY_EVENTS.TASK_ENDED)
        .listen((event) {
      _timer?.cancel();
      setShow(event);
      _timer = Timer(Duration(seconds: 3), () {
        setShow(null);
      });
    });
  }

  void setShow(COMPANY_EVENTS? event) {
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
                  eventToText(_event!),
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

  String eventToText(COMPANY_EVENTS event) {
    switch (event) {
      case COMPANY_EVENTS.TASK_ENDED:
        return ChumakiLocalizations.getForKey("notifications.taskEnded");
      default:
        return "";
    }
  }

  void dispose() {
    _sub?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
