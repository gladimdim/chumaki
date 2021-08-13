import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/3d_button.dart';
import 'package:chumaki/components/ui/other_games/other_games_view.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/sound/sound_manager.dart';
import 'package:chumaki/theme.dart';
import 'package:chumaki/views/game_canvas_view.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:chumaki/views/inherited_company.dart';
import 'package:chumaki/components/ui/locale_selection.dart';

class StartingView extends StatefulWidget {
  @override
  _StartingViewState createState() => _StartingViewState();
}

class _StartingViewState extends State<StartingView> {
  Company? currentCompany;
  AsyncMemoizer _appPreferencesInitter = AsyncMemoizer();
  final double menuHeight = 350.0;

  _appPreferencesInit() {
    return _appPreferencesInitter.runOnce(() => AppPreferences.instance.init());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (currentCompany == null)
          GameCanvasView(
            company: currentCompany,
            key: globalViewerKey,
            initialPanDuration: Duration(seconds: 15),
            screenSize: MediaQuery.of(context).size,
            onBackPressed: onBackPressed,
          ),
        if (currentCompany != null)
          InheritedCompany(
            company: currentCompany!,
            child: GameCanvasView(
              onBackPressed: onBackPressed,
              company: currentCompany,
              key: globalViewerKey,
              initialPanDuration: Duration(seconds: 15),
              screenSize: MediaQuery.of(context).size,
            ),
          ),
        if (currentCompany == null)
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
                maxHeight: menuHeight,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "images/ui/papyrus_1.png",
                    height: menuHeight,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () => _loadGamePressed(context, Company()),
                          child: TitleText(ChumakiLocalizations.labelNewGame)),
                      FutureBuilder(
                        future: _appPreferencesInit(),
                        builder: (context, snapshot) {
                          var savedGame =
                              AppPreferences.instance.readGameSave();
                          if (savedGame == null) {
                            return OutlinedButton(
                                onPressed: null,
                                child: Text(
                                  ChumakiLocalizations.labelNoSave,
                                ));
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () => _loadGamePressed(
                                      context, Company.fromJson(savedGame)),
                                  child: TitleText(
                                      ChumakiLocalizations.labelLoadSave),
                                ),
                                IconButton(
                                    onPressed: _removeSave,
                                    icon: Icon(
                                      Icons.delete,
                                      color: darkGrey,
                                    )),
                              ],
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TitleText(ChumakiLocalizations.labelSound),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: MENU_ITEM_WIDTH,
                              height: MENU_ITEM_WIDTH,
                              child: DDDButton(
                                color: mediumGrey,
                                shadowColor: Theme.of(context).backgroundColor,
                                onPressed: _toggleSoundMode,
                                child: StreamBuilder<APP_PREFERENCES_EVENTS>(
                                    stream: AppPreferences.instance.changes
                                        .where((event) =>
                                            event ==
                                            APP_PREFERENCES_EVENTS
                                                .SOUND_CHANGE),
                                    builder: (context, snapshot) {
                                      return ResizedImage(
                                        AppPreferences.instance
                                                .getIsSoundEnabled()
                                            ? "images/ui/bandura.png"
                                            : "images/ui/bandura_back.png",
                                        width: 44,
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      OtherGamesView(),
                      LocaleSelection(
                        locale: ChumakiLocalizations.locale,
                        onLocaleChanged: (Locale locale) {
                          setState(() {
                            ChumakiLocalizations.locale = locale;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _toggleSoundMode() async {
    await AppPreferences.instance.toogleIsSoundEnabled();
  }

  onBackPressed() {
    setState(() {
      currentCompany = null;
    });
  }

  _removeSave() async {
    await AppPreferences.instance.removeSavedGame();
    setState(() {
      _appPreferencesInitter = AsyncMemoizer();
    });
  }

  _loadGamePressed(BuildContext context, Company company) async {
    setState(() {
      _appPreferencesInitter = AsyncMemoizer();
      SoundManager.instance.attachToCompany(company);
      currentCompany = company;
    });
  }
}
