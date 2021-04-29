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
  final AsyncMemoizer _appPreferencesInitter = AsyncMemoizer();

  _appPreferencesInit() {
    return _appPreferencesInitter.runOnce(() => AppPreferences.instance.init());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () => _loadGamePressed(context, Company()),
              child: TitleText("New Game")),
          FutureBuilder(
            future: _appPreferencesInit(),
            builder: (context, snapshot) {
              var savedGame = AppPreferences.instance.readGameSave();
              Company company;
              if (savedGame == null) {
                return TextButton(onPressed: null, child: TitleText("No saved game"));
              } else {
                return TextButton(
                    onPressed: () =>
                        _loadGamePressed(context, Company.fromJson(savedGame)),
                    child: TitleText("Load Game"));
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText("Other Games:"),
            ],
          ),
        ],
      ),
    );
  }

  _loadGamePressed(BuildContext context, Company company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Material(
          child: InheritedCompany(
            company: company,
            child: MainView(
              company: company,
            ),
          ),
        ),
      ),
    );
  }
}
