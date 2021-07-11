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
  AsyncMemoizer _appPreferencesInitter = AsyncMemoizer();

  _appPreferencesInit() {
    return _appPreferencesInitter.runOnce(() => AppPreferences.instance.init());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameCanvasView(
          initialPanDuration: Duration(seconds: 15),
          screenSize: MediaQuery.of(context).size,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                  onPressed: () => _loadGamePressed(context, Company()),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TitleText(ChumakiLocalizations.labelNewGame),
                  )),
              FutureBuilder(
                future: _appPreferencesInit(),
                builder: (context, snapshot) {
                  var savedGame = AppPreferences.instance.readGameSave();
                  if (savedGame == null) {
                    return TextButton(
                        onPressed: null,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            ChumakiLocalizations.labelNoSave,
                          ),
                        ));
                  } else {
                    return TextButton(
                      onPressed: () => _loadGamePressed(
                          context, Company.fromJson(savedGame)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TitleText(ChumakiLocalizations.labelLoadSave),
                            IconButton(
                                onPressed: _removeSave,
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              BorderedTop(
                child: Container(
                  color: Theme.of(context).backgroundColor.withAlpha(200),
                  child: LocaleSelection(
                    locale: ChumakiLocalizations.locale,
                    onLocaleChanged: (Locale locale) {
                      setState(() {
                        ChumakiLocalizations.locale = locale;
                      });
                    },
                  ),
                ),
              ),
              BorderedTop(
                child: Container(
                  color: Theme.of(context).backgroundColor.withAlpha(200),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OtherGamesView(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _removeSave() async {
    await AppPreferences.instance.removeSavedGame();
    setState(() {
      _appPreferencesInitter = AsyncMemoizer();
    });
  }

  _loadGamePressed(BuildContext context, Company company) async {
    SoundManager.instance.attachToCompany(company);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Material(
          child: InheritedCompany(
            company: company,
            child: GameCanvasView(
              initialPanDuration: Duration(seconds: 15),
              company: company,
              screenSize: MediaQuery.of(context).size,
            ),
          ),
        ),
      ),
    );
    company.dispose();
    setState(() {
      _appPreferencesInitter = AsyncMemoizer();
    });
  }
}
