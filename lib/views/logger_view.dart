import 'dart:math';

import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/animations/animated_menu_button.dart';
import 'package:chumaki/components/ui/bouncing_widget.dart';
import 'package:chumaki/components/ui/outlined_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
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
    return AnimatedMenuButton(
      opened: opened,
      button: Stack(

        children: [
          DDDButton(
            color: mediumGrey,
            shadowColor: themeData.backgroundColor,
            onPressed: _toggleOpen,
            child: ResizedImage(
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
                      value: widget.company.logger.unreadCount.toString());
                }),
          ),
        ],
      ),
      content: LoggerStatsView(
        logger: widget.company.logger,
        onClose: _toggleOpen,
      ),
      expandAnimation: Duration(milliseconds: 150),
      closedPosition: Point(MediaQuery.of(context).size.width - MENU_ITEM_WIDTH - 15, 5),
      openedPosition: Point(0, 5),
    );
  }

  void _toggleOpen() {
    setState(() {
      widget.company.logger.resetUnreadCount();
      opened = !opened;
    });
  }
}
