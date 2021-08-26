import 'package:chumaki/components/ui/bordered_bottom.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:chumaki/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherGamesLink extends StatelessWidget {
  const OtherGamesLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var locale = ChumakiLocalizations.locale;
        openUrlFor(locale);
      },
      child: BorderedBottom(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.link, color: darkGrey),
          GameText(ChumakiLocalizations.labelOtherGames),
        ],
      )),
    );
  }

  void openUrlFor(Locale locale) async {
    var name = locale.languageCode;
    var url = "https://locadeserta.com/index_en";
    var urlUkr = "https://locadeserta.com/";
    if (name == "uk") {
      url = urlUkr;
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
