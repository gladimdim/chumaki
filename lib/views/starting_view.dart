import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/bordered_top.dart';
import 'package:chumaki/components/ui/other_games/other_games_view.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/sound/sound_manager.dart';
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
                maxHeight: 400,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "images/ui/papyrus_1.png",
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                            return OutlinedButton(
                              onPressed: () => _loadGamePressed(
                                  context, Company.fromJson(savedGame)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TitleText(ChumakiLocalizations.labelLoadSave),
                                  IconButton(
                                      onPressed: _removeSave,
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      LocaleSelection(
                        locale: ChumakiLocalizations.locale,
                        onLocaleChanged: (Locale locale) {
                          setState(() {
                            ChumakiLocalizations.locale = locale;
                          });
                        },
                      ),
                      OtherGamesView(),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
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
      currentCompany = company;
    });
  }
}
