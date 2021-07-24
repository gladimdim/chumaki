import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/models/company.dart';
import 'package:flutter/material.dart';
import 'package:chumaki/theme.dart';
import 'logger_stats_view.dart';

class LoggerView extends StatefulWidget {
  final Company company;

  const LoggerView({Key? key, required this.company}) : super(key: key);

  @override
  _LoggerViewState createState() => _LoggerViewState();
}

class _LoggerViewState extends State<LoggerView> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AnimatedPositioned(
      bottom: 5,
      left: opened ? 0 : 55 * 3 + 15,
      duration: Duration(milliseconds: 150),
      child: AnimatedSize(
        duration: Duration(milliseconds: 150),
        child: SizedBox(
          width: opened ? MediaQuery.of(context).size.width : 55,
          height: opened ? MediaQuery.of(context).size.height : 55,
          child: opened
              ? LoggerStatsView(
                  logger: widget.company.logger,
                  onClose: _toggleOpen,
                )
              : DDDButton(
                  color: mediumGrey,
                  shadowColor: themeData.backgroundColor,
                  onPressed: _toggleOpen,
                  child: StreamBuilder<APP_PREFERENCES_EVENTS>(
                      stream: AppPreferences.instance.changes.where((event) =>
                          event == APP_PREFERENCES_EVENTS.SOUND_CHANGE),
                      builder: (context, snapshot) {
                        return Image.asset(
                          AppPreferences.instance.getIsSoundEnabled()
                              ? "images/icons/paths/paths.png"
                              : "images/icons/lock/lock.png",
                          width: 44,
                        );
                      }),
                ),
        ),
      ),
    );
  }

  void _toggleOpen() {
    setState(() {
      opened = !opened;
    });
  }
}
