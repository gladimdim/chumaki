import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/bouncing_widget.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/models/logger/logger.dart';
import 'package:chumaki/views/game_canvas_view.dart';
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
      top: 5,
      left: opened ? 0 : null,
      right: opened ? null : 15,
      duration: Duration(milliseconds: 150),
      child: AnimatedSize(
        duration: Duration(milliseconds: 150),
        child: SizedBox(
          width: opened ? MediaQuery.of(context).size.width : MENU_ITEM_WIDTH,
          height: opened ? MediaQuery.of(context).size.height : MENU_ITEM_WIDTH,
          child: opened
              ? LoggerStatsView(
                  logger: widget.company.logger,
                  onClose: _toggleOpen,
                )
              : Stack(
                  children: [
                    DDDButton(
                      color: mediumGrey,
                      shadowColor: themeData.backgroundColor,
                      onPressed: _toggleOpen,
                      child: Image.asset(
                        "images/ui/glory.png",
                        width: 44,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: StreamBuilder<LOGGER_EVENTS>(
                          stream: widget.company.logger.changes,
                          builder: (context, snapshot) {
                            return BouncingWidget(
                                child: OutlinedText(
                                  widget.company.logger.unreadCount.toString(),
                                  style: gameTextStyle,
                                ),
                                value: widget.company.logger.unreadCount
                                    .toString());
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _toggleOpen() {
    setState(() {
      widget.company.logger.resetUnreadCount();
      opened = !opened;
    });
  }
}
