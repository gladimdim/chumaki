import 'package:chumaki/components/title_text.dart';
import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/other_games/other_game.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:chumaki/i18n/chumaki_localizations.dart';
import 'package:flutter/material.dart';

class OtherGamesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TitleText(ChumakiLocalizations.labelOtherGames),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: OtherGame.allGames().map((game) {
          return InkWell(
            onTap: () {
              var locale = ChumakiLocalizations.locale;
              game.openUrlFor(locale);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(child: ResizedImage(game.image, width: 46)),
                GameText(ChumakiLocalizations.getForKey(game.titleKey)),
              ],
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
