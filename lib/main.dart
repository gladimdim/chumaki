import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale("en");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localeResolutionCallback: (locale, list) {
        if (locale != null && ChumakiLocalizations.supportedLanguageCodes
            .contains(locale.languageCode) ) {
          _locale = locale;
        } else {
          _locale = Locale("en");
        }
        return _locale;
      },
      title: 'Дике Поле: Чумаки',
      home: Scaffold(
        body: MainView(),
      ),
      localizationsDelegates: [
        const HexLocalizationsDelegate(),
      ],
      supportedLocales: ChumakiLocalizations.supportedLanguageCodes
          .map((sLocale) => Locale(sLocale)),
    );
  }
}
