import 'dart:math';

import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/animations/animated_menu_button.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';

class GeneralHelpViewButton extends StatefulWidget {
  const GeneralHelpViewButton({Key? key}) : super(key: key);

  @override
  State<GeneralHelpViewButton> createState() => _GeneralHelpViewButtonState();
}

class _GeneralHelpViewButtonState extends State<GeneralHelpViewButton> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AnimatedMenuButton(
      opened: opened,
      button: DDDButton(
        color: mediumGrey,
        shadowColor: themeData.backgroundColor,
        onPressed: _toggleOpen,
        child: ResizedImage(
          "images/icons/unknown/unknown.png",
          width: 44,
        ),
      ),
      content: GeneralHelpView(
        onClose: _toggleOpen,
      ),
      expandAnimation: Duration(milliseconds: 150),
      closedPosition: Point(
          MediaQuery.of(context).size.width - MENU_ITEM_WIDTH * 2 - 15, 5),
      openedPosition: Point(0, 5),
    );
  }

  void _toggleOpen() {
    setState(() {
      opened = !opened;
    });
  }
}

class GeneralHelpView extends StatelessWidget {
  const GeneralHelpView({Key? key, required this.onClose}) : super(key: key);
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer3(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: onClose, icon: Icon(Icons.close)),
                  TitleText(ChumakiLocalizations.labelHelp),
                  IconButton(onPressed: onClose, icon: Icon(Icons.close)),
                ],
              ),
              DecoratedContainer2(
                child: Column(
                  children: [
                    TitleText(ChumakiLocalizations.labelHelpOverviewTitle),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextOverview1,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextOverview2,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextOtamans,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextTowns,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextWagons,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextAchievements,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ChumakiLocalizations.labelHelpTextEvents,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
