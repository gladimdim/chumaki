import 'package:chumaki/app_preferences.dart';
import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/models/company.dart';
import 'package:chumaki/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:chumaki/views/inherited_company.dart';

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
        Image.asset(
          "images/ui/main_view_background.png",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withAlpha(200),
                child: TextButton(
                    onPressed: () => _loadGamePressed(context, Company()),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TitleText("New Game"),
                    )),
              ),
              FutureBuilder(
                future: _appPreferencesInit(),
                builder: (context, snapshot) {
                  var savedGame = AppPreferences.instance.readGameSave();
                  if (savedGame == null) {
                    return Container(
                      color: Colors.white.withAlpha(200),
                      child: TextButton(
                          onPressed: null,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: TitleText("No saved game"),
                          )),
                    );
                  } else {
                    return Container(
                      color: Colors.white.withAlpha(200),
                      child: TextButton(
                        onPressed: () => _loadGamePressed(
                            context, Company.fromJson(savedGame)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleText("Load Game"),
                              IconButton(
                                  onPressed: _removeSave,
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                color: Colors.white.withAlpha(200),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TitleText("Other Games"),
                ),
              ),

            ],
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,

          child: Image.asset(
            "images/ui/persons_on_a_map.png",
            height: 150,
            fit: BoxFit.fitWidth,
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
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Material(
          child: InheritedCompany(
            company: company,
            child: GameCanvasView(
              company: company,
              screenSize: MediaQuery.of(context).size,
            ),
          ),
        ),
      ),
    );
    setState(() {
      _appPreferencesInitter = AsyncMemoizer();
    });
  }
}
