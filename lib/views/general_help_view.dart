import 'dart:math';

import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/animations/animated_menu_button.dart';
import 'package:chumaki/components/ui/bordered_container_with_side.dart';
import 'package:chumaki/components/ui/decorated_container.dart';
import 'package:chumaki/components/ui/game_text.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.up
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleOverview1,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            GameText(
                              ChumakiLocalizations.labelHelpTextOverview1,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.up,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleOverview2,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "map.png"),
                            GameText(
                              ChumakiLocalizations.labelHelpTextOverview2,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleOtamans,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "leader.png"),
                            GameText(
                              ChumakiLocalizations.labelHelpTextOtamans,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleWagons,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "wagon.png"),
                            GameText(
                              ChumakiLocalizations.labelHelpTextWagons,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleTowns,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "town.png"),
                            GameText(
                              ChumakiLocalizations.labelHelpTextTowns,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleManufacturing,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "manufacturing.png"),
                            GameText(
                              ChumakiLocalizations.labelHelpTextManufacturing,
                              addStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleMarket,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "market.png"),
                            Text(
                              ChumakiLocalizations.labelHelpTextMarket,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleGlobalMarket,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "global_market.png"),
                            Text(
                              ChumakiLocalizations.labelHelpTextGlobalMarket,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleAchievements,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "achievements.png"),
                            Text(
                              ChumakiLocalizations.labelHelpTextAchievements,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedContainerWithSides(
                      borderDirections: [
                        AxisDirection.left,
                        AxisDirection.right,
                        AxisDirection.down
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GameText(
                              ChumakiLocalizations.labelHelpTitleEvents,
                              addStyle: Theme.of(context).textTheme.headline5,
                            ),
                            HelpImage(imagePath: "event.png"),
                            Text(
                              ChumakiLocalizations.labelHelpTextEvents,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
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

class HelpImage extends StatelessWidget {
  final String imagePath;

  const HelpImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageToLocalizedImage(imagePath),
      width: 350,
    );
  }

  String imageToLocalizedImage(String image) {
    var lang = ChumakiLocalizations.locale.languageCode;
    if (lang == "ru") {
      lang = "uk";
    }
    return "images/help/$lang/$imagePath";
  }
}
